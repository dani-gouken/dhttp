import 'package:dhttp/dhttp.dart';
import 'package:http/http.dart' as http;
abstract class IRequestSender {
  Future<http.StreamedResponse> send(AbstractRequest originalRequest, http.BaseRequest request);
}