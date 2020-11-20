import 'package:dhttp/requests/abstract_request.dart';

abstract class IHttpClient {
  Future<T> process<T>(AbstractRequest request);
}
