import 'package:dhttp/request_sender/i_request_sender.dart';
import 'package:http/http.dart';
import 'package:dhttp/requests/abstract_request.dart';
import 'dart:io' as io;
import 'package:http/http.dart' as http;

class IOSender extends IRequestSender {
  @override
  Future<StreamedResponse> send(
      AbstractRequest originalRequest, BaseRequest request) {
    io.HttpClient client = io.HttpClient();
    return client
        .open(request.method, request.url.host, request.url.port,
            request.url.path)
        .then((io.HttpClientRequest ioRequest) async {
      request.headers.forEach((key, value) {
        ioRequest.headers.add(key, value);
      });
      ByteStream stream = request.finalize();
      ioRequest.write(await stream.bytesToString());
      return ioRequest.close();
    }).then((io.HttpClientResponse response) {
      return http.StreamedResponse(response, response.statusCode,
          contentLength:
              response.contentLength < 0 ? null : response.contentLength,
          request: request,
          headers: request.headers,
          isRedirect: response.isRedirect,
          persistentConnection: response.persistentConnection,
          reasonPhrase: response.reasonPhrase);
    });
  }
}
