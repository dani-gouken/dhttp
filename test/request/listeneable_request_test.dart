import 'package:dhttp/dhttp.dart';
import 'package:dhttp/request_sender/mock_request_sender.dart';
import 'package:dhttp/requests/listeneable_request.dart';
import 'package:dhttp/requests/request.dart';
import 'package:dhttp/requests/request_cancelled_exception.dart';
import 'package:dhttp/response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("the progress updates", () async {
    MockRequestSender client = MockRequestSender((_) => Response("foo", 200));
    ProgressListener listener = ProgressListener();
    expect(0, listener.progress);
    ListeneableHttpRequest request = new ListeneableHttpRequest(
        "POST", Uri.https("google.fr", ""),
        progressListener: listener);
    await client.send(Request.get("google.fr"), request);
    expect(listener.progress, 1);
  });
  test("the it can be cancelled", () async {
    MockRequestSender client = MockRequestSender((_) => Response("foo", 200));
    CancellationToken cancellationToken = CancellationToken();
    ListeneableHttpRequest request = new ListeneableHttpRequest(
        "POST", Uri.https("google.fr", ""),
        cancellationToken: cancellationToken);
    expect(() async {
      request.cancellationToken.cancel();
      await client.send(Request.get("google.fr"), request);
    }, throwsA(isInstanceOf<RequestCancelledException>()));
  });
}
