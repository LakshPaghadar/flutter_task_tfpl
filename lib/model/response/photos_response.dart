class PhotosResponse {
  PhotosResponse({
      int? albumId, 
      int? id, 
      String? title, 
      String? url, 
      String? thumbnailUrl,}){
    _albumId = albumId;
    _id = id;
    _title = title;
    _url = url;
    _thumbnailUrl = thumbnailUrl;
}

  PhotosResponse.fromJson(dynamic json) {
    _albumId = json['albumId'];
    _id = json['id'];
    _title = json['title'];
    _url = json['url'];
    _thumbnailUrl = json['thumbnailUrl'];
  }
  int? _albumId;
  int? _id;
  String? _title;
  String? _url;
  String? _thumbnailUrl;
PhotosResponse copyWith({  int? albumId,
  int? id,
  String? title,
  String? url,
  String? thumbnailUrl,
}) => PhotosResponse(  albumId: albumId ?? _albumId,
  id: id ?? _id,
  title: title ?? _title,
  url: url ?? _url,
  thumbnailUrl: thumbnailUrl ?? _thumbnailUrl,
);
  int? get albumId => _albumId;
  int? get id => _id;
  String? get title => _title;
  String? get url => _url;
  String? get thumbnailUrl => _thumbnailUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['albumId'] = _albumId;
    map['id'] = _id;
    map['title'] = _title;
    map['url'] = _url;
    map['thumbnailUrl'] = _thumbnailUrl;
    return map;
  }

}