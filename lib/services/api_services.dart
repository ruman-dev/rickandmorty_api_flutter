import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServices {
  Future fetchData(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to fetch posts');
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
