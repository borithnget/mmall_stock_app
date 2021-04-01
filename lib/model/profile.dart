class Profile {
  final String imageUrl;
  String title;
  final String subtitle;
  final String totalPost;
  final String totalFollowers;
  final String totalFollowing;

  Profile({
    this.imageUrl,
    this.subtitle,
    this.title,
    this.totalFollowers,
    this.totalFollowing,
    this.totalPost,
  });
}