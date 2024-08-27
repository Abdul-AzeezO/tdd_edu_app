import 'package:education_app/core/utils/typedefs.dart';

class AppUserModel extends AppUser {
  const AppUserModel({
    required super.uid,
    required super.email,
    required super.fullName,
    required super.points,
    super.avatar,
    super.bio,
    super.groupIds = const [],
    super.enrolledCourseIds = const [],
    super.following = const [],
    super.followers = const [],
  });

  const AppUserModel.empty()
      : this(uid: '', email: '', fullName: '', points: 0);

  AppUserModel.fromMap(DataMap map)
      : super(
          uid: map['uid'] as String,
          email: map['email'] as String,
          avatar: map['avatar'] as String?,
          bio: map['bio'] as String?,
          fullName: map['fullName'] as String,
          points: (map['points'] as num).toInt(),
          groupIds: (map['groupIds'] as List).cast<String>(),
          enrolledCourseIds: (map['enrolledCourseIds'] as List).cast<String>(),
          following: (map['following'] as List).cast<String>(),
          followers: (map['followers'] as List).cast<String>(),
        );

  AppUserModel copyWith({
    String? uid,
    String? email,
    String? avatar,
    String? bio,
    String? fullName,
    int? points,
    List<String>? groupIds,
    List<String>? enrolledCourseIds,
    List<String>? following,
    List<String>? followers,
  }) =>
      AppUserModel(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        avatar: avatar ?? this.avatar,
        bio: bio ?? this.bio,
        fullName: fullName ?? this.fullName,
        points: points ?? this.points,
        groupIds: groupIds ?? this.groupIds,
        enrolledCourseIds: enrolledCourseIds ?? this.enrolledCourseIds,
        following: following ?? this.following,
        followers: followers ?? this.followers,
      );

  DataMap toMap() => {
        'uid': uid,
        'email': email,
        'avatar': avatar,
        'bio': bio,
        'fullName': fullName,
        'points': points,
        'groupIds': groupIds,
        'enrolledCourseIds': enrolledCourseIds,
        'following': following,
        'followers': followers,
      };
}
