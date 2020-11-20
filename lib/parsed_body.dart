import 'package:http/http.dart';

class ParsedBody {
  final dynamic data;
  final Response httpResponse;
  ParsedBody(this.data, this.httpResponse);
}
