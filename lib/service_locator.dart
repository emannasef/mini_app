import 'package:get_it/get_it.dart';
import 'package:it_roots_task/core/network/api_utlis.dart';
import 'package:it_roots_task/core/network/network_client.dart';
import 'package:it_roots_task/features/posts/data_layer/data_source/posts_local_source.dart';
import 'package:it_roots_task/features/posts/data_layer/data_source/posts_remote_source.dart';
import 'package:it_roots_task/features/posts/domain_layer/posts_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt locator = GetIt.I;

Future<void> setupLocator() async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton<SharedPreferences>(() => preferences);

  locator.registerLazySingleton<ApiUtils>(() => ApiUtils());

  // Register NetworkClient
  locator.registerLazySingleton<INetworkClient>(
    () => NetworkClient(apiUtils: locator<ApiUtils>()),
  );
  // Register Post Data Sources
  locator.registerLazySingleton<PostRemoteDataSource>(
    () => PostRemoteDataSourceImpl(networkClient: locator()),
  );
  locator.registerLazySingleton<PostLocalDataSource>(
    () => PostLocalDataSourceImpl(),
  );

  // Register Post Repository
  locator.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(
      postRemoteDataSource: locator(),
      postLocalDataSource: locator(),
    ),
  );
}
