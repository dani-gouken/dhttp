import 'package:dhttp/http_verb.dart';
import 'package:dhttp/requests/request.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  Map<String,String> params = {"foo":"bar"};
  Map<String,dynamic> body = {"foo":1};
  Map<String,String> headers = {"bar":"baz"};
  test("constructor", (){
    Request request = new Request("foo", HttpVerb.POST,params: params,body: body, headers: headers);
    expect(request.headers, headers);
    expect(request.params, params);
    expect(request.body, body);
    expect(request.url, "foo");
    expect(request.verb, HttpVerb.POST);
  });

   test("post factory", (){
    Map<String,String> params = {"foo":"bar"};
    Request request = new Request.post("foo",params: params,body: body, headers: headers);
    expect(request.url, "foo");
    expect(request.verb, HttpVerb.POST);
    expect(request.body, body);
  });

  test("get factory", (){
    Map<String,String> params = {"foo":"bar"};
    Request request = new Request.get("foo",params: params, headers: headers);
    expect(request.url, "foo");
    expect(request.verb, HttpVerb.GET);
  });

  test("put factory", (){
    Map<String,String> params = {"foo":"bar"};
    Request request = new Request.put("foo",params: params, headers: headers,body: body);
    expect(request.url, "foo");
    expect(request.verb, HttpVerb.PUT);
    expect(request.body, body);
  });

  test("delete factory", (){
    Map<String,String> params = {"foo":"bar"};
    Request request = new Request.delete("foo",params: params, headers: headers);
    expect(request.url, "foo");
    expect(request.verb, HttpVerb.DELETE);
  });

   test("patch factory", (){
    Map<String,String> params = {"foo":"bar"};
    Request request = new Request.patch("foo",params: params, headers: headers);
    expect(request.url, "foo");
    expect(request.verb, HttpVerb.PATCH);
  });
}