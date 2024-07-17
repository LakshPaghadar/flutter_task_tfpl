/// userId : 1
/// id : 1
/// title : "sunt aut facere repellat provident occaecati excepturi optio reprehenderit"
/// body : "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"

class PostResponse {
  PostResponse({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  PostResponse.fromJson(dynamic json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }
  num? userId;
  num? id;
  String? title;
  String? body;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['id'] = id;
    map['title'] = title;
    map['body'] = body;
    return map;
  }
}
