import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  var url;

  NetworkHelper(this.url);

  Future<Map> getJson() async {
    http.Response response = await http.get(url);

    return json.decode(response.body);
  }
}
