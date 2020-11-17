import 'package:dhttp/requests/progress_listener.dart';

mixin Progress {
  ProgressListener requestListener;
  ProgressListener responseListener;
  onRequestProgress(Function(ProgressListener listener) onProgress) {
    this.requestListener = ProgressListener(callback: onProgress);
    return this;
  }

  onResponseProgress(Function(ProgressListener listener) onProgress) {
    this.responseListener = ProgressListener(callback: onProgress);
    return this;
  }
}
