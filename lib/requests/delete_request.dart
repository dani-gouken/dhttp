import 'package:dhttp/requests/abstract_request.dart';

import '../http_verb.dart';

abstract class DeleteRequest extends AbstractRequest {
  @override
  get verb => HttpVerb.DELETE;
}
