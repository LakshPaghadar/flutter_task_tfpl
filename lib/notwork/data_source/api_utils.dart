import 'package:dio/dio.dart';
import 'package:dummy_api_call_retrofit/locator/locator.dart';
import 'package:dummy_api_call_retrofit/model/response/post_response.dart';
import 'package:retrofit/retrofit.dart';

import '../../model/response/photos_response.dart';

part 'api_utils.g.dart';

@RestApi()
abstract class PostApi {
  factory PostApi(Dio dio) = _PostApi;
  @GET("/posts")
  Future<List<PostResponse>> getPosts();

  @GET("/photos")
  Future<List<PhotosResponse>> getPhotos(@Query('_start') int start,
      @Query('_limit') int limit,);
}

PostApi postApi = locator<PostApi>();
