import 'package:dhttp/dhttp.dart';
import 'package:dhttp/request_sender/mock_request_sender.dart';
import 'package:dhttp/requests/listeneable_http_multipart_request.dart';
import 'package:dhttp/requests/listeneable_request.dart';
import 'package:dhttp/requests/request_cancelled_exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

void main() {
  test("the progress updates", () async {
    MockRequestSender client = MockRequestSender("foo");
    ProgressListener listener = ProgressListener();
    expect(0, listener.progress);
    ListeneableHttpMultipartRequest request = new ListeneableHttpMultipartRequest(
        "POST", Uri.https("google.fr", ""),
        progressListener: listener);
    expect(request, isInstanceOf<MultipartRequest>());
    await client.send(request);
    expect(listener.progress, 1);
  });
  test("the it can be cancelled", () async {
    MockRequestSender client = MockRequestSender("foo");
    CancellationToken cancellationToken = CancellationToken();
    ListeneableHttpMultipartRequest request = new ListeneableHttpMultipartRequest(
        "POST", Uri.https("google.fr", ""),
        cancellationToken: cancellationToken);
    expect(() async{
      request.cancellationToken.cancel();
      await client.send(request);
    }, throwsA(isInstanceOf<RequestCancelledException>()));
  });
}
