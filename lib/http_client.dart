import 'package:dhttp/abstract_http_client.dart';
import 'package:dhttp/request_sender/http_request_sender.dart';
import 'package:dhttp/request_sender/i_request_sender.dart';
import 'package:dhttp/response_handler/i_response_handler.dart';
import 'package:dhttp/response_handler/string_response_handler.dart';

class HttpClient extends AbstractHttpClient{
  final String _host;
  IResponseHandler _responseHandler;
  IRequestSender _requestSender;

  HttpClient(this._host,{IRequestSender requestSender,IResponseHandler responseHandler}){
    this._requestSender = requestSender ?? HttpRequestSender();
    this._responseHandler = responseHandler ?? StringResponseHandler();
  }

  @override
  String get host => _host;

  @override
  IResponseHandler get responseHandler => _responseHandler;

  @override
  IRequestSender get sender => _requestSender;
  @override
  void log(String message) {
  }

}