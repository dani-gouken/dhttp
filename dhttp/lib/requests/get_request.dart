

import 'package:dhttp/requests/abstract_request.dart';
import '../http_verb.dart';

abstract class GetRequest extends AbstractRequest {
  @override
  get verb => HttpVerb.GET;
}
