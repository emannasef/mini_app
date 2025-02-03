import 'package:it_roots_task/features/posts/data_layer/data_source/posts_local_source.dart';
import 'package:it_roots_task/features/posts/data_layer/data_source/posts_remote_source.dart';
import 'package:it_roots_task/features/posts/data_layer/model/posts_model.dart';

abstract class PostRepository {
  Future<List<PostModel>> getRemotePosts();
  Future<List<PostModel>> getLocalPosts();
}

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource postRemoteDataSource;
  final PostLocalDataSource postLocalDataSource;

  PostRepositoryImpl({
    required this.postRemoteDataSource,
    required this.postLocalDataSource,
  });

  @override
  Future<List<PostModel>> getRemotePosts() async {
    try {
      final remotePosts = await postRemoteDataSource.getAllPosts();

      await postLocalDataSource.cachePosts(remotePosts);
      return remotePosts;
    } catch (error) {
      throw Exception('Error fetching remote posts: $error');
    }
  }

  @override
  Future<List<PostModel>> getLocalPosts() async {
    try {
      final cachedPosts = await postLocalDataSource.getCachedPosts();
      if (cachedPosts.isEmpty) {
        throw Exception('No local posts available');
      }
      return cachedPosts;
    } catch (error) {
      throw Exception('Error fetching local posts: $error');
    }
  }
}
