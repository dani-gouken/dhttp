import 'package:dhttp/dhttp.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("it can be completed", () {
    ProgressListener listener = ProgressListener();
    expect(listener.cancelled, false);
    listener.cancel();
    expect(listener.cancelled, true);
  });

  test("it can be completed", () {
    ProgressListener listener = ProgressListener();
    expect(listener.completed, false);
    listener.complete();
    expect(listener.completed, true);
  });

  test("it update progress", () {
    ProgressListener listener = ProgressListener();
    expect(listener.progress, 0);
    expect(listener.progressPercentage, 0);

    listener.onProgress(1,2);

    expect(listener.progress, 0.5);
    expect(listener.progressPercentage, 50);

    listener.onProgress(2,2);

    expect(listener.progress, 1);
    expect(listener.progressPercentage, 100);
  });

   test("progress callback is called", () {
    ProgressListener listener = ProgressListener();
    int callCount = 0;
    listener.callback = (listener){
      callCount++;
    };
    listener.onProgress(1,2);
    listener.onProgress(2,2);
    expect(callCount,2);
  });
}
