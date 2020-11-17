import 'package:dhttp/requests/progress_listener.dart';
import 'package:http/http.dart' as http;
import 'cancellation_token.dart';
import 'listeneable_http_request_mixin.dart';

class ListeneableHttpRequest extends http.Request
    with ListeneableHttpRequestMixin {
  ListeneableHttpRequest(String method, Uri url,
      {this.progressListener, this.cancellationToken})
      : super(method, url);
  ProgressListener progressListener;
  CancellationToken cancellationToken;
  http.ByteStream finalize() {
    if (progressListener != null) {
      return addListenerToStream(
          onProgress: (byte, total) {
            progressListener.onProgress(byte, total);
          },
          cancellationToken: cancellationToken);
    }
    return addListenerToStream(cancellationToken: cancellationToken);
  }

  @override
  http.ByteStream makeByteStream() {
    return super.finalize();
  }
}
