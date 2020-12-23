import 'package:dhttp/requests/abstract_request.dart';
import 'package:dhttp/response.dart';

abstract class IResponseHandler {
  handle(AbstractRequest request, Response response);
}
