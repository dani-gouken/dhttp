import 'package:dhttp/parsed_body.dart';
import 'package:dhttp/http_verb.dart';
import 'package:dhttp/requests/abstract_request.dart';

class Request extends AbstractRequest{
  String _url;
  HttpVerb _method;
  Request(String url,HttpVerb method,{Map<String,String> params,dynamic body,Map<String,String> headers}){
    this._url = url;
    this._method = method;
    this.withBody(body ?? Map<String,String>())
        .addHeaders(headers ?? Map<String,String>())
        .addParams(params ?? Map<String,String>());
  }
  @override
  parseResult(ParsedBody response) {
    return response.data;
  }

  @override
  String get url => this._url;

  @override
  HttpVerb get verb => this._method;

  Request.post(String url,{dynamic body,Map<String,String> headers}){
    this._url = url;
    this.withBody(body ?? Map<String,String>())
        .addHeaders(headers ?? Map<String,String>())
        .addParams(params ?? Map<String,String>());
    this._method = HttpVerb.POST;
  }

  Request.delete(String url,{Map<String,String> headers}){
    this._url = url;
    this.addHeaders(headers ?? Map<String,String>())
        .addParams(params ?? Map<String,String>());
    this._method = HttpVerb.DELETE;
  }

  Request.put(String url,{dynamic body,Map<String,String> headers}){
    this._url = url;
    this.withBody(body ?? Map<String,String>())
        .addHeaders(headers ?? Map<String,String>())
        .addParams(params ?? Map<String,String>());
    this._method = HttpVerb.PUT;
  }

  Request.patch(String url,{dynamic body,Map<String,String> headers}){
    this._url = url;
    this.withBody(body ?? Map<String,String>())
        .addHeaders(headers ?? Map<String,String>())
        .addParams(params ?? Map<String,String>());
    this._method = HttpVerb.PATCH;
  }

  Request.get(String url,{Map<String,String> headers}){
    this._url = url;
    this.addHeaders(headers ?? Map<String,String>())
        .addParams(params ?? Map<String,String>());
    this._method = HttpVerb.GET;
  }
}