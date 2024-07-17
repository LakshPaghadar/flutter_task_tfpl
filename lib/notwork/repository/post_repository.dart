import 'package:dummy_api_call_retrofit/model/response/post_response.dart';

import '../../model/response/photos_response.dart';

abstract class PostRepository {
  Future<List<PostResponse>> getPosts();
  Future<List<PhotosResponse>> getPhotos(int start,int limit);
}
