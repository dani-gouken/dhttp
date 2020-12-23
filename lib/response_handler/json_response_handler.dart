import 'dart:convert';
import 'package:dhttp/requests/abstract_request.dart';
import 'package:dhttp/response.dart';
import '../parsed_response.dart';
import 'i_response_handler.dart';

class JsonResponseHandler extends IResponseHandler {
  @override
  handle(AbstractRequest request, Response response) {
    return ParsedResponse(jsonDecode(response.body), response);
  }
}
