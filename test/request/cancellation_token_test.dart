import 'package:dhttp/dhttp.dart';
import 'package:flutter_test/flutter_test.dart';

void main()
{
  test("it can be cancelled",(){
    CancellationToken token = CancellationToken();
    expect(false, token.cancelled);
    token.cancel();
    expect(true, token.cancelled);
  });

  test("it call cancellation callback",(){
    CancellationToken token = CancellationToken();
    bool called = true;
    expect(false, token.cancelled);
    token.onCancel = (){
      called = true;
    };
    token.cancel();
    expect(true, token.cancelled);
    expect(called, true);
  });
  test("it cannot be cancelled multiple time",(){
    CancellationToken token = CancellationToken();
    int calledCount = 0;
    expect(false, token.cancelled);
    token.onCancel = (){
      calledCount++;
    };
    token.cancel();
    token.cancel();
    token.cancel();

    expect(true, token.cancelled);
    expect(calledCount, 1);
  });
}