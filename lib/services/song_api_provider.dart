import 'package:flutter/services.dart';
import 'package:thitsarparami/models/models.dart';

class SongApiProvider {
  Future<List<Song>> fetchSongs(int id) async {
    // final response = await client.get(Uri.parse('$_baseUrl/popular?api_key=$_apiKey'));
    final String response = await rootBundle.loadString('json/dhamma.json');
    // if (response.statusCode == 200) {
    // ignore: unnecessary_null_comparison
    if (response != null) {
      // If the call to the server was successful, parse the JSON
      return Song.songsFromJson(response);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load songs');
    }
  }
}
