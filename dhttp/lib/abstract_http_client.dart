import 'dart:async';

import 'package:dhttp/request_sender/i_request_sender.dart';
import 'package:dhttp/requests/abstract_request.dart';
import 'package:dhttp/requests/listeneable_http_multipart_request.dart';
import 'package:dhttp/requests/listeneable_request.dart';
import 'package:dhttp/response_handler/i_response_handler.dart';
import 'package:dhttp/utils.dart';
import 'package:http/http.dart' as http;
import 'body_encoder/i_body_encoder.dart';
import 'body_encoder/map_body_encoder.dart';
import 'i_http_client.dart';

abstract class AbstractHttpClient implements IHttpClient {
  String get host;
  String get prefix => "";
  IResponseHandler get responseHandler;
  IBodyEncoder get bodyEncoder => MapBodyEncoder();
  IRequestSender get sender;
  Map<String, String> get headers => {};
  Map<String, String> get queryParams => {};

  Future<T> process<T>(AbstractRequest request) async {
    http.StreamedResponse streamedResponse = await _sendRequest(request);
    final contentLength = streamedResponse.contentLength;
    List<int> bytes =
        await _observeByteStream(streamedResponse.stream, (List<int> b) {
      if (contentLength != null && request.hasResponseProgressListener) {
        request.responseListener.onProgress(b.length, contentLength);
      }
    });
    http.Response response = _responsefromStream(streamedResponse, bytes);
    final url = _makeUrl(request);
    _logResponse(url, response);
    return request.parseResult(responseHandler.handle(request, response)) as T;
  }

  http.Response _responsefromStream(
      http.StreamedResponse response, List<int> bytes) {
    return http.Response.bytes(bytes, response.statusCode,
        request: response.request,
        headers: response.headers,
        isRedirect: response.isRedirect,
        persistentConnection: response.persistentConnection,
        reasonPhrase: response.reasonPhrase);
  }

  Uri _makeUrl(AbstractRequest request) {
    return Uri.https(
        host, prefix + request.url, request.params..addAll(queryParams));
  }

  _logRequest(Uri url, AbstractRequest request) {
    log('''
        Sending request
        Url: $url,
        method: ${request.verb},
        headers: ${request.headers},
        queryParams: ${request.params},
        body: ${request.body},
    ''');
  }
  void log(String message);
  void _logResponse(Uri url, http.Response response) {
    log('''
        Response received for
        Url: $url,
        response: ${response.body},
    ''');
  }

  Future<http.StreamedResponse> _sendRequest(AbstractRequest request) async {
    final url = _makeUrl(request);
    _logRequest(url, request);
    String verbString = Utils.enumToString(request.verb);
    Map<String, dynamic> requestHeaders = _makeHeaders(request);
    if (!request.hasFiles) {
      final httpRequest = ListeneableHttpRequest(request.verbString, url,
          progressListener: request.requestListener,
          cancellationToken: request.cancellationToken);
      var encodedBody = bodyEncoder.encode(request.body);
      if (encodedBody is String) {
        httpRequest.body = encodedBody;
      } else {
        httpRequest.bodyFields = encodedBody;
      }
      httpRequest.headers.addAll(requestHeaders);
      return await sender.send(httpRequest);
    } else {
      ListeneableHttpMultipartRequest multipartRequest =
          ListeneableHttpMultipartRequest(verbString, url,
              progressListener: request.requestListener,
              cancellationToken: request.cancellationToken);
      multipartRequest.headers.addAll(requestHeaders);
      multipartRequest.files.addAll(request.files);
      multipartRequest.fields.addAll(request.body);
      return await sender.send(multipartRequest);
    }
  }

  Future<List<int>> _observeByteStream(
      http.ByteStream bytesStream, Function(List<int> bytes) cb) async {
    List<int> bytes = [];
    await for (var chunk in bytesStream) {
      bytes.addAll(chunk);
      cb(bytes);
    }
    return bytes;
  }

  _makeHeaders(AbstractRequest request) {
    return request.headers..addAll(headers);
  }

}
