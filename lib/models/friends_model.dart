class FriendModel {
  final String uid;
  final String name;
  final String bio;
  final String? photoUrl;

  FriendModel({
    required this.uid,
    required this.name,
    required this.bio,
    this.photoUrl,
  });

  factory FriendModel.fromMap(Map<String, dynamic> map, String id) {
    return FriendModel(
      uid: id,
      name: map['displayName'] ?? '',
      bio: map['bio'] ?? '',
      photoUrl: map['photoUrl'],
    );
  }
}
