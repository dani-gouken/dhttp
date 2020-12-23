import 'package:dhttp/dhttp.dart';
import 'package:dhttp/requests/progress_listener.dart';
import 'package:dhttp/utils.dart';
import 'package:http/http.dart';
import '../http_verb.dart';
import '../parsed_response.dart';
import 'cancellation_token.dart';

abstract class AbstractRequest {
  String get url;
  HttpVerb get verb;
  ProgressListener requestListener;
  ProgressListener responseListener;
  CancellationToken cancellationToken;
  Map<String, String> _params =Map<String, String>();
  Map<String, dynamic> _body =Map<String, String>();
  List<MultipartFile> _files = [];
  Map<String, String> _headers = Map<String, String>();

  Map<String, String> get params {
    return this._params;
  }

  Map<String, dynamic> get body {
    return this._body;
  }

  withBody(Map<String, dynamic> body) {
    this._body = body;
    return this;
  }


  List<MultipartFile> get files {
    return this._files;
  }

  bool get hasFiles => files.isNotEmpty;

  Map<String, String> get headers {
    return this._headers;
  }

  addHeaders(Map<String,String> headers){
    this._headers.addAll(headers);
    return this;
  }

  addFiles(List<MultipartFile> files){
    this._files.addAll(files);
    return this;
  }

  addParams(Map<String,String> headers){
    this._params.addAll(headers);
    return this;
  }


  dynamic parseResult(ParsedResponse response);

  bool get canHaveBody {
    switch (verb) {
      case HttpVerb.POST:
        return true;
        break;
      case HttpVerb.GET:
        return false;
        break;
      case HttpVerb.DELETE:
        return false;
        break;
      case HttpVerb.PUT:
        return true;
        break;
      case HttpVerb.PATCH:
        return true;
        break;
      case HttpVerb.HEAD:
        return false;
        break;
    }
    throw Exception("Invalid http verb");
  }

  String get verbString {
    return Utils.enumToString(verb);
  }
  bool isUrl(String path) => path == this.url;
  bool isMethod(HttpVerb verb) => verb == this.verb;
  bool get hasRequestProgressListener => requestListener != null;
  bool get hasResponseProgressListener => responseListener != null;
}
