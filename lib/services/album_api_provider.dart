import 'package:flutter/services.dart';
import 'package:thitsarparami/models/models.dart';

class AlbumApiProvider {
  Future<List<Album>> fetchAlbums() async {
    // final response = await client.get(Uri.parse('$_baseUrl/popular?api_key=$_apiKey'));
    final String response = await rootBundle.loadString('json/album.json');
    // if (response.statusCode == 200) {
    // ignore: unnecessary_null_comparison
    if (response != null) {
      // If the call to the server was successful, parse the JSON
      return Album.monksFromJson(response);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load albums');
    }
  }

  Future<List<Album>> searchAlbums(int monkId, query) async {
    // final response = await client.get(Uri.parse('$_baseUrl/popular?api_key=$_apiKey'));
    final String response = await rootBundle.loadString('json/album.json');
    // if (response.statusCode == 200) {
    // ignore: unnecessary_null_comparison
    if (response != null) {
      // If the call to the server was successful, parse the JSON
      List<Album> albums = Album.monksFromJson(response);
      if (query.isNotEmpty) {
        var result = albums
            .where((album) =>
                album.title.toLowerCase().contains(query.toLowerCase()) &&
                album.monkId == monkId
                )
            .toList();
        return result;
      } else {
        return albums;
      }
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load albums');
    }
  }
}
