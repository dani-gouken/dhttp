import 'package:dhttp/response_handler/i_response_handler.dart';

import 'abstract_http_client.dart';
import 'body_encoder/i_body_encoder.dart';
import 'body_encoder/json_body_encoder.dart';
import 'response_handler/json_response_handler.dart';

abstract class JsonHttpClient extends AbstractHttpClient {
  IBodyEncoder get bodyEncoder => JsonBodyEncoder();
  @override
  Map<String, String> get headers => {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json'
  };
  @override
  IResponseHandler get responseHandler => JsonResponseHandler();
}
