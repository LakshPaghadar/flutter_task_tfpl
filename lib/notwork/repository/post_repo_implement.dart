import 'package:dummy_api_call_retrofit/locator/locator.dart';
import 'package:dummy_api_call_retrofit/model/response/post_response.dart';
import 'package:dummy_api_call_retrofit/notwork/data_source/api_utils.dart';
import 'package:dummy_api_call_retrofit/notwork/repository/post_repository.dart';

import '../../model/response/photos_response.dart';

class PostRepositoryImpl extends PostRepository {
  @override
  Future<List<PostResponse>> getPosts() {
    var response = postApi.getPosts();
    return response;
  }

  @override
  Future<List<PhotosResponse>> getPhotos(int start,int limit) {
    var response = postApi.getPhotos(start,limit);
    return response;
  }
}

PostRepositoryImpl postRepositoryImpl = locator<PostRepositoryImpl>();
