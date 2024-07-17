import 'package:dummy_api_call_retrofit/notwork/store/post_store.dart';
import 'package:dummy_api_call_retrofit/screens/location_list_page.dart';
import 'package:dummy_api_call_retrofit/screens/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';

import '../generated/l10n.dart';
import 'image_card.dart';

class PhotosListPage extends StatefulWidget {
  const PhotosListPage({super.key});

  @override
  State<PhotosListPage> createState() => _PhotosListPageState();
}

class _PhotosListPageState extends State<PhotosListPage> {
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  ValueNotifier<bool> isLoading2 = ValueNotifier(false);
  List<ReactionDisposer>? disposer;
  ScrollController _scrollController = ScrollController();
  var _searchController = TextEditingController();
  int _page = 1;
  final int _perPage = 10;
  @override
  void initState() {
    super.initState();
    registerReactions();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      //isLoading.value = true;
      isLoading2.value = true;
      await postStore.getPhotosList(_page, _perPage);
      //isLoading.value = false;
      isLoading2.value = false;
    });
    _searchController.addListener(() {
      postStore.photosList;
    });
  }

  void registerReactions() {
    disposer ??= [
      reaction((p0) => postStore.photosList, (list) {
        debugPrint("LIST_LIST : ${list.length}");
        if (list.isNotEmpty) {
          isLoading.value = false;
        }
      }),
      reaction((p0) => postStore.errorMessage, (errorMsg) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errorMsg.toString())));
      })
    ];
  }

  void removeReactions() {
    if (disposer == null) {
      return;
    } else {
      for (var ele in disposer!) {
        ele.reaction.dispose();
      }
    }
  }

  @override
  void dispose() {
    removeReactions();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).home),
        ),
        drawer: Drawer(
            child: ListView(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: ListTile(
                leading: Icon(Icons.message),
                title: Text(S.of(context).home),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LocationListPage()));
              },
              child: ListTile(
                leading: Icon(Icons.account_circle),
                title: Text(S.of(context).geofencing),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SettingsPage()));
              },
              child: ListTile(
                leading: Icon(Icons.settings),
                title: Text(S.of(context).settings),
              ),
            ),
          ],
        )),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20).r,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: S.of(context).search
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
              width: double.infinity,
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: isLoading,
                builder: (context, value, child) {
                  if (value) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return child!;
                  }
                },
                child: observeResponse(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget observeResponse() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Observer(
        builder: (context) {
          if (isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (postStore.photosList.isEmpty) {
            return const Text("No Data found");
          } else {
            return ListView.builder(
              itemCount: postStore.photosList.length + 1,
              shrinkWrap: true,
              controller: _scrollController,
              itemBuilder: (context, index) {
                if (index < postStore.photosList.length) {
                  return ImageCard(
                    imageUrl: postStore.photosList[index].url!,
                    description: postStore.photosList[index].title!,
                  );
                } else {
                  return _buildProgressIndicator();
                }
              },
            );
          }
        },
      ),
    );
  }

  Future<void> _loadData() async {
    if (!isLoading2.value) {
      setState(() {
        isLoading2.value = true;
      });
      await Future.delayed(Duration(seconds: 2));
      await postStore.getPhotosList(_page, _perPage);

      setState(() {
        isLoading2.value = false;
        _page = _page + 10;
      });
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadData();
    }
  }

  Widget _buildProgressIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
