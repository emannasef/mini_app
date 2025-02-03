import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_roots_task/features/posts/presentation_layer/cubit/posts_cubit.dart';
import 'package:it_roots_task/utils/app_routes.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  void initState() {
    super.initState();
    final cubit = PostsCubit.get(context);
    cubit.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.settings),
              icon: const Icon(Icons.settings))
        ],
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<PostsCubit, PostsState>(
        builder: (context, state) {
          final cubit = PostsCubit.get(context);
          switch (state) {
            case PostLoadingState():
              return const Center(child: CircularProgressIndicator());
            case PostErrorState():
              return const Center(child: Text("Error loading posts"));
            case PostLoadedState():
              return ListView.builder(
                itemCount: cubit.posts.length,
                itemBuilder: (context, index) {
                  final post = cubit.posts[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(post.title ?? 'No Title'),
                      subtitle: Text(post.body ?? 'No Body'),
                    ),
                  );
                },
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
