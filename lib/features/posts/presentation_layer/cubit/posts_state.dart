part of 'posts_cubit.dart';

@immutable
sealed class PostsState {}

final class PostsInitial extends PostsState {}

class PostLoadingState extends PostsState {}

class PostLoadedState extends PostsState {}

class PostErrorState extends PostsState {
  final String message;
  PostErrorState(this.message);
}
