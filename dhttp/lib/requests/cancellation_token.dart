class CancellationToken {
  bool _cancelled = false;
  CancellationToken({this.onCancel});
  Function onCancel;
  cancel() {
    if(cancelled){
      return;
    }
    if (onCancel != null) {
      onCancel();
    }
    this._cancelled = true;
  }

  get cancelled => _cancelled;
}
