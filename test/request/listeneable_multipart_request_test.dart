import 'package:dhttp/dhttp.dart';
import 'package:dhttp/request_sender/mock_request_sender.dart';
import 'package:dhttp/requests/listeneable_http_multipart_request.dart';
import 'package:dhttp/requests/request.dart';
import 'package:dhttp/requests/request_cancelled_exception.dart';
import 'package:dhttp/response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  test("the progress updates", () async {
    MockRequestSender client = MockRequestSender((_) => Response("", 200));
    ProgressListener listener = ProgressListener();
    expect(0, listener.progress);
    ListeneableHttpMultipartRequest request = new ListeneableHttpMultipartRequest(
        "POST", Uri.https("google.fr", ""),
        progressListener: listener);
    expect(request, isInstanceOf<http.MultipartRequest>());
    await client.send(Request.post("google.fr"),request);
    expect(listener.progress, 1);
  });
  test("the it can be cancelled", () async {
    MockRequestSender client = MockRequestSender((_) => Response("", 200));
    CancellationToken cancellationToken = CancellationToken();
    ListeneableHttpMultipartRequest request = new ListeneableHttpMultipartRequest(
        "POST", Uri.https("google.fr", ""),
        cancellationToken: cancellationToken);
    expect(() async{
      request.cancellationToken.cancel();
      await client.send(Request.post("google.fr"),request);
    }, throwsA(isInstanceOf<RequestCancelledException>()));
  });
}
