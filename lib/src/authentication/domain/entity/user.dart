// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.uid,
    required this.email,
    required this.fullName,
    required this.points,
    this.avatar,
    this.bio,
    this.groupIds = const [],
    this.enrolledCourseIds = const [],
    this.following = const [],
    this.followers = const [],
  });

  const User.empty()
      : this(uid: '', email: '', fullName: '', avatar: '', points: 0, bio: '');

  final String uid;
  final String email;
  final String? avatar;
  final String? bio;
  final String fullName;
  final int points;
  final List<String> groupIds;
  final List<String> enrolledCourseIds;
  final List<String> following;
  final List<String> followers;

  @override
  List<Object?> get props => [uid, email];

  @override
  bool get stringify => true;
}
