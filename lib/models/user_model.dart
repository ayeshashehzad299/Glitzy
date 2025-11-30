import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String uid;
  final String email;
  final String username;
  final String? name;
  final String? bio;
  final String? profileImageUrl;
  final DateTime? createdAt;

  AppUser({
    required this.uid,
    required this.email,
    required this.username,
    this.name,
    this.bio,
    this.profileImageUrl,
    this.createdAt,
  });

  // Convert Firebase document to AppUser
  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'],
      email: map['email'],
      username: map['username'],
      name: map['name'],
      bio: map['bio'],
      profileImageUrl: map['profileImageUrl'],
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate()
          : null,
    );
  }

  // Convert AppUser to Firestore-ready map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'name': name,
      'bio': bio,
      'profileImageUrl': profileImageUrl,
      'createdAt': createdAt,
    };
  }

  // Create updated copy (for editing profile)
  AppUser copyWith({
    String? username,
    String? name,
    String? bio,
    String? profileImageUrl,
  }) {
    return AppUser(
      uid: uid,
      email: email,
      username: username ?? this.username,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      createdAt: createdAt,
    );
  }
}
