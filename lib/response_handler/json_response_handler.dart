import 'dart:convert';
import 'package:dhttp/requests/abstract_request.dart';
import 'package:http/http.dart' as http;
import '../parsed_body.dart';
import 'i_response_handler.dart';

class JsonResponseHandler extends IResponseHandler {
  @override
  handle(AbstractRequest request, http.Response response) {
    return ParsedBody(jsonDecode(response.body), response);
  }
}
