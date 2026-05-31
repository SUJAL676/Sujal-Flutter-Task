class ReelModel {
  final String id;
  final String username;
  final String caption;
  final int likes;
  final String videoUrl;

  const ReelModel({
    required this.id,
    required this.username,
    required this.caption,
    required this.likes,
    required this.videoUrl,
  });

  factory ReelModel.fromMap(
      String id,
      Map<dynamic, dynamic> map,
      ) {
    return ReelModel(
      id: id,
      username: map['username']?.toString() ?? '',
      caption: map['caption']?.toString() ?? '',
      likes: map['likes'] ?? 0,
      videoUrl: map['videoUrl']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'caption': caption,
      'likes': likes,
      'videoUrl': videoUrl,
    };
  }
}