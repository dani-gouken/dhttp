import 'package:dhttp/dhttp.dart';
import 'package:dhttp/requests/abstract_request.dart';
import 'package:http/http.dart' as http;

class StringResponseHandler extends IResponseHandler{
  @override
  ParsedBody handle(AbstractRequest request, http.Response response) {
    return ParsedBody(response.body,response);
  }

}