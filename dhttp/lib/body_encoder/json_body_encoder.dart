import 'dart:convert';
import 'i_body_encoder.dart';

class JsonBodyEncoder extends IBodyEncoder {
  @override
  String encode(Map<String, dynamic> body) {
    return jsonEncode(body);
  }
}
