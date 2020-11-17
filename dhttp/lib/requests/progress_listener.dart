class ProgressListener {
  int length = 0;
  double get progress {
    if (expectedLenght == null) {
      return 0;
    }
    if (expectedLenght == 0) {
      return 1;
    }
    return length / expectedLenght;
  }

  double get progressPercentage =>
      (double.parse(progress.toStringAsFixed(2)) * 100);
  ProgressListener({this.callback});
  int expectedLenght;
  bool _completed = false;
  bool _cancelled = false;
  Function(ProgressListener listener) callback;
  void onProgress(int lenght, int expectedLenght) {
    if (_completed || _cancelled) {
      return;
    }
    this.length = lenght;
    this.expectedLenght = expectedLenght;
    if (this.callback != null) {
      callback(this);
    }
  }
  void complete(){
    this._completed = true;
  }
  void cancel(){
    this._cancelled = true;
  }
}
