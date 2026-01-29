import 'package:get/get.dart';

class StoryModel {
  final String id;
  final String username;
  final String avatarUrl;
  final String imageUrl;
  final DateTime timestamp;
  final bool isMe;
  final RxBool isViewed;
  final RxBool isLiked;

  StoryModel({
    required this.id,
    required this.username,
    required this.avatarUrl,
    required this.imageUrl,
    required this.timestamp,
    this.isMe = false,
    bool isViewed = false,
    bool isLiked = false,
  }) : isViewed = isViewed.obs,
       isLiked = isLiked.obs;
}

class UserStoryGroup {
  final String username;
  final String avatarUrl;
  final List<StoryModel> stories;

  UserStoryGroup({
    required this.username,
    required this.avatarUrl,
    required this.stories,
  });

  bool get allViewed => stories.every((s) => s.isViewed.value);
}

class PostModel {
  final String id;
  final String username;
  final String avatarUrl;
  final String imageUrl;
  final String caption;
  final RxInt likes;
  final RxBool isLiked;
  final RxBool isSaved;
  final String timestamp;

  PostModel({
    required this.id,
    required this.username,
    required this.avatarUrl,
    required this.imageUrl,
    required this.caption,
    int likes = 0,
    bool isLiked = false,
    bool isSaved = false,
    required this.timestamp,
    List<String>? comments,
  })  : likes = likes.obs,
        isLiked = isLiked.obs,
        isSaved = isSaved.obs,
        comments = (comments ?? []).obs;

  final RxList<String> comments;
}
