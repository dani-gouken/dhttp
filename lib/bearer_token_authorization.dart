mixin BearerTokenAuthorization {
  String get token;

  Map<String, String> get headers {
    return {"Authorization": "Bearer $token"};
  }
}
