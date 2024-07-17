// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PostStore on PostStoreBase, Store {
  late final _$photosListAtom =
      Atom(name: 'PostStoreBase.photosList', context: context);

  @override
  ObservableList<PhotosResponse> get photosList {
    _$photosListAtom.reportRead();
    return super.photosList;
  }

  @override
  set photosList(ObservableList<PhotosResponse> value) {
    _$photosListAtom.reportWrite(value, super.photosList, () {
      super.photosList = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: 'PostStoreBase.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$getPhotosListAsyncAction =
      AsyncAction('PostStoreBase.getPhotosList', context: context);

  @override
  Future<dynamic> getPhotosList(int start, int limit) {
    return _$getPhotosListAsyncAction
        .run(() => super.getPhotosList(start, limit));
  }

  @override
  String toString() {
    return '''
photosList: ${photosList},
errorMessage: ${errorMessage}
    ''';
  }
}
