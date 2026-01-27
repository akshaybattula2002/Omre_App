class AppAssets {
  static const String logoLight = 'assets/logo/omre_light_mode.png';
  static const String logoDark = 'assets/logo/omre_dark_mode.png';
  // Placeholders

  static const String avatar1 = 'assets/images/avatars/avatar_1.jpg';
  static const String avatar2 = 'assets/images/avatars/avatar_2.jpg';
  static const String avatar3 = 'assets/images/avatars/avatar_3.jpg';
  static const String avatar4 = 'assets/images/avatars/avatar_4.jpg';
  static const String avatar5 = 'assets/images/avatars/avatar_5.jpg';

  static const String cover1 = 'assets/images/covers/cover_1.jpg';
  static const String cover2 = 'assets/images/covers/cover_2.jpg';
  static const String cover3 = 'assets/images/covers/cover_3.jpg';

  static const String post1 = 'assets/images/posts/post_1.jpg';
  static const String post2 = 'assets/images/posts/post_2.jpg';
  static const String post3 = 'assets/images/posts/post_3.jpg';
  static const String post4 = 'assets/images/posts/post_4.jpg';
  static const String post5 = 'assets/images/posts/post_5.jpg';
  static const String dummyStory = 'assets/images/posts/dummy_story.jpg';

  static const String thumbnail1 = 'assets/images/thumbnails/thumbnail_1.jpg';
  static const String thumbnail2 = 'assets/images/thumbnails/thumbnail_2.jpg';
  static const String thumbnail3 = 'assets/images/thumbnails/thumbnail_3.jpg';

  static const String sampleVideo = 'assets/videos/sample_video.mp4';
  static const String sampleVideo2 = 'assets/videos/sample_video_2.mp4';
  static const String sampleVideo3 = 'assets/videos/sample_video_3.mp4';

  static const List<String> avatars = [avatar1, avatar2, avatar3, avatar4, avatar5];
  static const List<String> posts = [post1, post2, post3, post4, post5];
  static const List<String> thumbnails = [thumbnail1, thumbnail2, thumbnail3];
  static const List<String> covers = [cover1, cover2, cover3];

  static String getRandomAvatar() => (avatars.toList()..shuffle()).first;
  static String getRandomPost() => (posts.toList()..shuffle()).first;
  static String getRandomThumbnail() => (thumbnails.toList()..shuffle()).first;
  static String getRandomCover() => (covers.toList()..shuffle()).first;
}
