import 'package:dhttp/dhttp.dart';

class TestRequest extends AbstractRequest{
  @override
  parseResult(ParsedBody response) {
  return response.data;
  }

  @override
  String get url => "/foo.com";

  @override
  HttpVerb get verb => HttpVerb.POST;
}