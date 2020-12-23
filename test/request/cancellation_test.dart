import 'package:dhttp/dhttp.dart';
import 'package:flutter_test/flutter_test.dart';

class TestRequestWithCancellationToken extends AbstractRequest with Cancellation {
  @override
  parseResult(ParsedResponse response) {}

  @override
  String get url => "foo";
  @override
  HttpVerb get verb => HttpVerb.POST;
}

main() {
  test("test a request can be cancelled", () {
    TestRequestWithCancellationToken request = TestRequestWithCancellationToken();
    expect(request.cancellationToken, null);
    CancellationToken token = request.cancellable();
    expect(token, request.cancellationToken);
  });

  test("test a cancellation token can attached to a request", () {
    TestRequestWithCancellationToken request = TestRequestWithCancellationToken();
    CancellationToken token = CancellationToken();
    request.withCancellationToken(token);
    expect(token, request.cancellationToken);
  });
}
