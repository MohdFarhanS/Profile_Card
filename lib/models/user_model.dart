import 'package:flutter/material.dart';

class UserModel {
  final String name;
  final String description;
  final String profileImage;
  final List<SocialMedia> socialMediaList;

  UserModel({
    required this.name,
    required this.description,
    required this.profileImage,
    required this.socialMediaList,
  });
}

class SocialMedia {
  final String platform;
  final String url;
  final String? iconPath;
  final IconData? iconData;
  final Color color;

  SocialMedia({
    required this.platform,
    required this.url,
    this.iconPath,
    this.iconData,
    required this.color,
  }) : assert(iconPath != null || iconData != null, );
}
