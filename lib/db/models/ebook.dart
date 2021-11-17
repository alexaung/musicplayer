class DownloadedEbook {
  int? id;
  String taskId;
  String title;
  String url;
  String thumbnail;
  String monkName;
  String monkImageUrl;

  DownloadedEbook(
      {this.id,
      required this.taskId,
      required this.title,
      required this.url,
      required this.thumbnail,
      required this.monkName,
      required this.monkImageUrl});

  factory DownloadedEbook.fromDatabaseJson(Map<String, dynamic> data) => DownloadedEbook(
      id: data['id'],
      taskId: data ["taskId"],
      title: data['title'],
      url: data['url'],
      thumbnail: data['thumbnail'],
      monkName: data['monk_name'],
      monkImageUrl: data['monk_image_url']);

  Map<String, dynamic> toDatabaseJson() => {
        "id": id,
        "taskId": taskId,
        "title": title,
        "url": url,
        "thumbnail": thumbnail,
        "monk_name": monkName,
        "monk_image_url": monkImageUrl,
      };
}
