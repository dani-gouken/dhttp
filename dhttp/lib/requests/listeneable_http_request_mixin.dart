import 'dart:async';
import 'package:http/http.dart' as http;
import 'cancellation_token.dart';

mixin ListeneableHttpRequestMixin {
  http.ByteStream makeByteStream();
  int get contentLength;

  http.ByteStream addListenerToStream(
      {Function(int bytes, int totalBytes) onProgress,
      Function() onDone,
      Function() onError,
      CancellationToken cancellationToken}) {
    final byteStream = makeByteStream();
    final total = this.contentLength;
    int bytes = 0;
    final t = StreamTransformer.fromHandlers(
      handleData: (List<int> data, EventSink<List<int>> sink) {
        bytes += data.length;
        if (onProgress != null) {
          onProgress(bytes, total);
        }
        if (cancellationToken != null && cancellationToken.cancelled) {
          throw Exception("request cancelled");
        }
        sink.add(data);
      },
    );
    final stream = byteStream.transform(t);
    return http.ByteStream(stream);
  }
}
