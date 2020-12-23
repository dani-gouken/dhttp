import 'package:dhttp/requests/abstract_request.dart';

import '../http_verb.dart';

abstract class PutRequest extends AbstractRequest {
  @override
  get verb => HttpVerb.PUT;
}
