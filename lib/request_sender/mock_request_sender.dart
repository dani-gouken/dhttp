import 'package:dhttp/dhttp.dart';
import 'package:dhttp/request_sender/i_request_sender.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as httpTest;
import 'dart:convert';

import '../response.dart';

class MockRequestSender extends IRequestSender{
  final Response Function(AbstractRequest request) resolver;

  MockRequestSender(this.resolver);

  @override
  Future<http.StreamedResponse> send(AbstractRequest originalRequest, http.BaseRequest request) async{
    dynamic _client = httpTest.MockClient.streaming((http.BaseRequest request, http.ByteStream stream) async{
      await for (List<int> _ in stream){ 
        if(request.contentLength == 0){
          break;
        }
      }
      Response response = resolver(originalRequest);
      return http.StreamedResponse(
        Stream<List<int>>.fromIterable([utf8.encode(response.body)]),
        response.statusCode,
        isRedirect: response.isRedirect,
        headers: response.headers
      );
    });
    try {
      return _client.send(request);
    } finally {
      _client.close();
    }
  }

}