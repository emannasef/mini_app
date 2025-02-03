import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_roots_task/it_roots_app.dart';
import 'package:it_roots_task/service_locator.dart';
import 'package:it_roots_task/features/posts/data_layer/model/posts_model.dart';
import 'package:it_roots_task/features/posts/domain_layer/posts_repository_impl.dart';
import 'package:it_roots_task/utils/app_colors.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(PostsInitial());

  static PostsCubit get(context) => BlocProvider.of(context);

  final PostRepository _postRepository = locator<PostRepository>();
  List<PostModel> posts = [];

  Future<bool> isConnectedToNetwork() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result.first.rawAddress.isNotEmpty) {
        return true;
      }
    } catch (e) {
      return false;
    }

    return false;
  }

  void getPosts() async {
    final isConnected = await isConnectedToNetwork();
    if (isConnected) {
      await _fetchRemotePosts();
    } else {
      ScaffoldMessenger.of(ItRootsApp.navigatorKey.currentContext!)
          .showSnackBar(
        SnackBar(
          content: Text('notConnected'.tr()),
          backgroundColor: AppColors.gray200Color,
        ),
      );
      await _fetchOfflinePosts();
    }
  }

  Future<void> _fetchRemotePosts() async {
    emit(PostLoadingState());
    try {
      final result = await _postRepository.getRemotePosts();
      posts = result;
      emit(PostLoadedState());
    } catch (e) {
      emit(PostErrorState('Failed to load posts from the API.'));
    }
  }

  Future<void> _fetchOfflinePosts() async {
    try {
      final cachedPosts = await _postRepository.getLocalPosts();
      posts = cachedPosts;
      emit(PostLoadedState());
    } catch (e) {
      emit(PostErrorState('Failed to load posts from cache.'));
    }
  }
}
