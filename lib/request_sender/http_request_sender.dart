import 'package:dhttp/request_sender/i_request_sender.dart';
import 'package:dhttp/requests/abstract_request.dart';
import 'package:http/http.dart' as http;
class HttpRequestSender extends IRequestSender{
  http.Client _client;
  @override
  Future<http.StreamedResponse> send(AbstractRequest originalRequest,http.BaseRequest request) {
    http.Client client = this._client;
    if(client == null){
      client = makeClient();
    }
    try {
      return client.send(request);
    } finally {
      client.close();
    }
  }

  http.Client makeClient(){
    return http.Client();
  }

  set client(http.Client client){
    this._client = client;
  }
}