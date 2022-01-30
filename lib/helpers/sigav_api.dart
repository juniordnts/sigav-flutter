import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sigav_app/helpers/sigav_defaults.dart';

class SigavApi {
  String path;
  Map<String, dynamic> body;
  Map<String, String> query;
  String token;
  Map<String, String> headers;

  SigavApi(
      {String? path,
      Map<String, dynamic>? body,
      Map<String, String>? query,
      String? token,
      Map<String, String>? headers})
      : path = path ?? "",
        body = body ?? {},
        query = query ?? {},
        token = token ?? "",
        headers = headers ?? {};

  Future<Map<String, dynamic>> get() async {
    Uri uri = Uri.http(SigavDef.url, path, query);

    headers['x-access-token'] = token;

    http.Response response = await http.get(uri, headers: headers);

    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> post() async {
    Uri uri = Uri.http(SigavDef.url, path, query);

    headers['x-access-token'] = token;

    http.Response response = await http.post(uri, body: body, headers: headers);

    return json.decode(response.body);
  }
}
