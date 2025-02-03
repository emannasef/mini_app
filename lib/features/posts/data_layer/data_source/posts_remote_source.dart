import '../../../../core/constants/api_constans.dart';
import '../../../../core/network/network_client.dart';
import '../model/posts_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final INetworkClient networkClient;

  PostRemoteDataSourceImpl({required this.networkClient});

  @override
  Future<List<PostModel>> getAllPosts() async {
    final result = await networkClient.getData(endPoint: ApiConstants.posts);

    return result.fold(
      (error) {
        throw error;
      },
      (response) {
        if (response.statusCode == 200) {
          try {
            final List<PostModel> posts = (response.data as List)
                .map<PostModel>(
                    (jsonPostModel) => PostModel.fromJson(jsonPostModel))
                .toList();
            return posts;
          } catch (e) {
            throw Exception("Failed to parse posts data");
          }
        } else {
          throw Exception('Unexpected status code: ${response.statusCode}');
        }
      },
    );
  }
}
