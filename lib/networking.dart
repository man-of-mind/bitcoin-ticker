import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  Future getData(String url) async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String result = response.body;
      return jsonDecode(result);
    }
  }
}
