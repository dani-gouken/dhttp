import 'package:dhttp/dhttp.dart';
import 'package:flutter_test/flutter_test.dart';

class TestRequest extends GetRequest{
  @override
  parseResult(ParsedResponse response) {
    return ;
  }
  @override
  String get url => throw UnimplementedError();
}
void main(){
  
  test("test it has the correct verb", (){
    TestRequest request = TestRequest();
    expect(request.verb, HttpVerb.GET);
  });
}