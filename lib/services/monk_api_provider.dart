import 'package:flutter/services.dart';
import 'package:thitsarparami/models/models.dart';

class MonkApiProvider {
  Future<List<Monk>> fetchMonks() async {
    // final response = await client.get(Uri.parse('$_baseUrl/popular?api_key=$_apiKey'));
    final String response = await rootBundle.loadString('json/monk.json');
    // if (response.statusCode == 200) {
    // ignore: unnecessary_null_comparison
    if (response != null) {
      // If the call to the server was successful, parse the JSON
      return Monk.monksFromJson(response);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load monks');
    }
  }

  Future<List<Monk>> searchMonks(String query) async {
    // final response = await client.get(Uri.parse('$_baseUrl/popular?api_key=$_apiKey'));
    final String response = await rootBundle.loadString('json/monk.json');
    // if (response.statusCode == 200) {
    // ignore: unnecessary_null_comparison
    if (response != null) {
      // If the call to the server was successful, parse the JSON
      List<Monk> monks = Monk.monksFromJson(response);
      if (query.isNotEmpty) {
        var result = monks
            .where((monk) =>
                monk.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
        return result;
      } else {
        return monks;
      }
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load monks');
    }
  }
}
