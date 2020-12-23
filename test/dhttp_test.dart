import 'dart:io';
import 'package:dhttp/http_client.dart';
import 'package:dhttp/request_sender/mock_request_sender.dart';
import 'package:dhttp/requests/request.dart';
import 'package:dhttp/response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('sends a request', () async{
    MockRequestSender sender = new MockRequestSender((_){
      return Response("google", 200);
    }); 
    final httpClient = new HttpClient("google.fr",requestSender: sender);
    String response = await httpClient.process<String>(Request.get("/"));
    expect(response, "body");
  });
}
