import 'package:dhttp/request_sender/http_request_sender.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
class HttpClientMock extends Mock implements http.Client{}
class HttpRequestSenderMock extends Mock implements HttpRequestSender{}
void main(){
  group("http request sender test",(){
    test("it calls send method on http client", (){
      http.Request request = http.Request("GET",Uri.parse("https://foobar.com"));
      HttpRequestSender sender = HttpRequestSender();
      HttpClientMock mock = HttpClientMock();
      sender.client = mock; 
      sender.send(request);
      verify(mock.send(request));
    });
  });
}