class FavouriteSong {
  int? id;
  int? favouriteId;
  String album;
  String title;
  String artist;
  String artUrl;
  String audioUrl;
  bool isFavourite;
  bool isDownloaded;
  int? sortOrder;

  FavouriteSong(
      {this.id,
      required this.favouriteId,
      required this.album,
      required this.title,
      required this.artist,
      required this.artUrl,
      required this.audioUrl,
      this.isFavourite = false,
      this.isDownloaded = false,
      this.sortOrder});

  factory FavouriteSong.fromDatabaseJson(Map<String, dynamic> data) =>
      FavouriteSong(
        id: data['id'],
        favouriteId: data['favouriteId'],
        album: data['album'],
        title: data['title'],
        artist: data['artist'],
        artUrl: data['artUrl'],
        audioUrl: data['audioUrl'],
        isFavourite: data['is_favourite'] == 0 ? false : true,
        isDownloaded: data['is_downloaded'] == 0 ? false : true,
        sortOrder: data['sort_order'],
      );

  Map<String, dynamic> toDatabaseJson() => {
        "id": id,
        "favouriteId": favouriteId,
        "album": album,
        "title": title,
        "artist": artist,
        "artUrl": artUrl,
        "audioUrl": audioUrl,
        "is_favourite": isFavourite == false ? 0 : 1,
        "is_downloaded": isDownloaded == false ? 0 : 1,
        "sort_order": sortOrder
      };
}
