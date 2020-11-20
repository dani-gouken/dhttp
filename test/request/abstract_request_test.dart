import 'package:dhttp/dhttp.dart';
import 'package:dhttp/requests/request.dart';
import 'package:flutter_test/flutter_test.dart';
import '../misc/mock_multipart_file.dart';
import '../misc/test_request.dart';

void main() {
  test("params", () {
    TestRequest request = TestRequest();
    expect(request.params, Map<String, String>());
    request.addParams({"foo": "bar"});
    request.addParams({"bar": "baz"});
    expect(request.params, {"foo": "bar", "bar": "baz"});
  });

  test("headers", () {
    TestRequest request = TestRequest();
    expect(request.headers, Map<String, String>());
    request.addHeaders({"foo": "bar"});
    request.addHeaders({"bar": "baz"});
    expect(request.headers, {"foo": "bar", "bar": "baz"});
  });

  test("files", () {
    TestRequest request = TestRequest();
    expect(request.files, []);
    expect(false, request.hasFiles);
    MockMultipartFile file = MockMultipartFile();
    request.addFiles([file]);
    expect(request.files, [file]);
    expect(true, request.hasFiles);
  });

  test("can have body", () {
    String url = "/foo";
    expect(Request.get(url).canHaveBody, false);
    expect(Request.post(url).canHaveBody, true);
    expect(Request.put(url).canHaveBody, true);
    expect(Request.patch(url).canHaveBody, true);
    expect(Request.delete(url).canHaveBody, false);
  });

  test("body", () {
    TestRequest request = TestRequest();
    expect(request.body, Map<String, dynamic>());
    request.withBody({"foo": "bar"});
    expect(request.body, {"foo": "bar"});
  });

  test("verbString", () {
    String url = "/foo";
    expect(Request.get(url).verbString, "GET");
    expect(Request.post(url).verbString, "POST");
    expect(Request.put(url).verbString, "PUT");
    expect(Request.patch(url).verbString, "PATCH");
    expect(Request.delete(url).verbString, "DELETE");
  });

  test("isUrl", () {
    String url = "/foo";
    expect(Request.get(url).isUrl(url), true);
    expect(Request.get(url).isUrl("not-same"), false);
  });

  test("is method", () {
    String url = "/method";
    expect(Request.get(url).isMethod(HttpVerb.GET), true);
    expect(Request.get(url).isMethod(HttpVerb.POST), false);
  });

  test("listeners", () {
    String url = "/method";
    expect(Request.get(url).hasRequestProgressListener, false);
    expect(Request.get(url).hasResponseProgressListener, false);
  });
}
