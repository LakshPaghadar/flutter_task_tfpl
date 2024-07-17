import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dummy_api_call_retrofit/locator/locator.dart';
import 'package:dummy_api_call_retrofit/notwork/repository/post_repo_implement.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../model/response/photos_response.dart';

part 'post_store.g.dart';

class PostStore = PostStoreBase with _$PostStore;

abstract class PostStoreBase with Store {
  //@observable
  //ObservableList<PostResponse> postList = ObservableList();

  @observable
  ObservableList<PhotosResponse> photosList = ObservableList();

  ObservableList<PhotosResponse> backupPhotosList = ObservableList();

  @observable
  String? errorMessage;

  @action
  Future getPhotosList(int start, int limit) async {
    try {
      var res = await postRepositoryImpl.getPhotos(start, limit);
      photosList.addAll(res);
      backupPhotosList.addAll(res);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.unknown &&
          (e.error is SocketException || e.error is HandshakeException)) {
        errorMessage = "No internet connection";
      } else {
        errorMessage = e.toString();
      }
    } catch (error, st) {
      errorMessage = error.toString();
      debugPrintStack(stackTrace: st);
    }
  }

  @action
  void filterPostsByName(String name) {
    if (name.isEmpty) {
      photosList = ObservableList<PhotosResponse>.of(backupPhotosList);
    } else {
      photosList = ObservableList<PhotosResponse>.of(
        backupPhotosList
            .where((post) =>
                post.title!.toLowerCase().contains(name.toLowerCase()))
            .toList(),
      );
    }
  }

  // @action
  // Future searchCharacters(String query) async {
  //   try {
  //     var res = await postRepositoryImpl.searchCharacters(query);
  //     charactersList = res;
  //   } on DioException catch (e) {
  //     if (e.type == DioExceptionType.unknown &&
  //         (e.error is SocketException || e.error is HandshakeException)) {
  //       errorMessage = "No internet connection";
  //     } else {
  //       errorMessage = e.toString();
  //     }
  //   } catch (error, st) {
  //     errorMessage = error.toString();
  //     debugPrintStack(stackTrace: st);
  //   }
  // }
}

final postStore = locator<PostStore>();
