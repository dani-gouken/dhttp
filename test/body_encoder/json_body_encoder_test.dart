import 'package:dhttp/body_encoder/json_body_encoder.dart';
import 'package:dhttp/body_encoder/map_body_encoder.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Json Body Encoder Test", (){
    test('encode the request', () async{
      JsonBodyEncoder encoder = JsonBodyEncoder();
      expect(encoder.encode({"foo": "bar"}), '{"foo":"bar"}');
    });
  });

  group("Map Body Encoder Test", (){
    test('encode the request', () async{
      MapBodyEncoder encoder = MapBodyEncoder();
      expect(encoder.encode({"foo": "bar"}), {"foo": "bar"});
    });
  });

}