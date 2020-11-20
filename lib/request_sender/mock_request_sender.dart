import 'package:dhttp/request_sender/i_request_sender.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as httpTest;
import 'dart:convert';

class MockRequestSender extends IRequestSender{
  String _body;
  String get body => _body;

  int _statusCode;
  int get statusCode => _statusCode;


  bool _isRedirect = false;
  bool get isRedirect => _isRedirect;
  
  Map<String,String> _headers;
  Map<String,String> get headers => _headers;


  MockRequestSender(String body,{int statusCode = 200,Map<String,String>headers = const {},isRedirect = false}){
    setResponse(body,statusCode:statusCode,headers:headers,isRedirect:isRedirect);
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async{
    dynamic _client = httpTest.MockClient.streaming((http.BaseRequest request, http.ByteStream stream) async{
      await for (List<int> _ in stream){ 
        if(request.contentLength == 0){
          break;
        }
      }
      return http.StreamedResponse(
        Stream<List<int>>.fromIterable([utf8.encode(body)]),
        statusCode,
        isRedirect: isRedirect,
        headers: headers
      );
    });
    try {
      return _client.send(request);
    } finally {
      _client.close();
    }
  }
 
  setResponse(String body,{int statusCode = 200,Map<String,String>headers = const {},isRedirect = false}){
    this._body = body;
    this._statusCode = statusCode;
    this._headers = headers;
    this._isRedirect = isRedirect;
  }

}