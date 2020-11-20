import 'dart:io';
import 'package:dhttp/http_client.dart';
import 'package:dhttp/request_sender/mock_request_sender.dart';
import 'package:dhttp/requests/request.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('sends a request', () async{
    MockRequestSender sender = new MockRequestSender("body"); 
    final httpClient = new HttpClient("google.fr",requestSender: sender);
    String response = await httpClient.process<String>(Request.get("/"));
    expect(response, "body");
  });
}
