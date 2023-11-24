import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.uid,
    required this.email,
    required this.fullName,
    required this.groupIds,
    required this.enrolledCourseIds,
    required this.following,
    required this.followers,
    required this.points,
    this.image,
    this.bio,
  });

  const User.empty()
      : this(
          uid: '',
          email: '',
          fullName: '',
          image: '',
          points: 0,
          bio: '',
          groupIds: const [],
          enrolledCourseIds: const [],
          followers: const [],
          following: const [],
        );

  final String uid;
  final String email;
  final String? image;
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
