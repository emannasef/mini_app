import 'dart:convert';
import 'package:it_roots_task/core/constants/cache_constants.dart';
import 'package:it_roots_task/core/helpers/cache_helper.dart';
import 'package:it_roots_task/features/posts/data_layer/model/posts_model.dart';

abstract class PostLocalDataSource {
  Future<List<PostModel>> getCachedPosts();
  Future<void> cachePosts(List<PostModel> posts);
}

class PostLocalDataSourceImpl implements PostLocalDataSource {
  PostLocalDataSourceImpl();
  @override
  Future<void> cachePosts(List<PostModel> posts) async {
    List postsToJson = posts
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();
    await CacheHelper.setStringData(
        key: CacheConstants.posts, value: json.encode(postsToJson));
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final cachedPosts = CacheHelper.getStringData(key: CacheConstants.posts);
    if (cachedPosts != null) {
      List decodeJsonData = json.decode(cachedPosts);
      List<PostModel> jsonToPostModels = decodeJsonData
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return Future.value(jsonToPostModels);
    } else {
      return Future.value([]);
    }
  }
}
