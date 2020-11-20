
import 'package:dhttp/dhttp.dart';
import 'package:dhttp/requests/abstract_request.dart';
import 'cancellation_token.dart';

mixin Cancellation on AbstractRequest {
  CancellationToken cancellationToken;
  cancellable() {
    this.cancellationToken = CancellationToken();
    return this.cancellationToken;
  }

  withCancellationToken(CancellationToken token) {
    this.cancellationToken = token;
    return this;
  }
}
