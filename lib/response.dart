class Response {
  final int statusCode;
  final bool isRedirect;
  final String body;
  final Map<String, String> headers;
  final bool persistentConnection;
  final String reasonPhrase;

  Response(this.body, this.statusCode,
      {this.isRedirect = false,
      this.headers = const {},
      this.persistentConnection = true,
      this.reasonPhrase});
}
