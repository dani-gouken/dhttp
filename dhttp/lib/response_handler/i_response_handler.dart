import 'package:dhttp/requests/abstract_request.dart';
import 'package:http/http.dart';

abstract class IResponseHandler {
  handle(AbstractRequest request, Response response);
}
