import 'dart:convert';

import 'package:http/http.dart';

import '../../data/http/http.dart';

class HttpAdapter extends HttpClient {
  Client client;

  HttpAdapter(this.client);

  @override
  Future<Map<String, dynamic>> request({
    required String url,
    required String method,
    Map<String, dynamic>? body,
  }) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    var jsonBody = body != null ? jsonEncode(body) : null;

    var response = await client.post(Uri.parse(url), headers: headers, body: jsonBody);

    return _handleResponse(response);
  }

  Map<String, dynamic> _handleResponse(Response response) {
    if (response.statusCode == 400) {
      throw HttpError.badRequest;
    }

    if (response.statusCode == 500) {
      throw HttpError.serverError;
    }

    if (response.statusCode == 401) {
      throw HttpError.unauthorized;
    }

    if (response.statusCode == 403) {
      throw HttpError.forbidden;
    }

    if (response.statusCode == 404) {
      throw HttpError.notFound;
    }

    if (response.body == '') {
      return {};
    }

    return jsonDecode(response.body);
  }
}
