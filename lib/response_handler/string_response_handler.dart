import 'package:dhttp/dhttp.dart';
import 'package:dhttp/requests/abstract_request.dart';
import 'package:dhttp/response.dart';

class StringResponseHandler extends IResponseHandler{
  @override
  ParsedResponse handle(AbstractRequest request, Response response) {
    return ParsedResponse(response.body,response);
  }

}