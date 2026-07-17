// lib/features/home/domain/entities/user_entity.dart
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final int age;
  final String city;
  final String state;
  final String country;
  final String avatarThumb;
  final String avatarLarge;
  final String email;
  final String phone;
  final String gender;
  final bool isOnline;
  final bool isVerified;
  final double distance;
  final int compatibility;
  final List<String> interests;
  final String bio;

  const UserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.city,
    required this.state,
    required this.country,
    required this.avatarThumb,
    required this.avatarLarge,
    required this.email,
    required this.phone,
    required this.gender,
    required this.isOnline,
    required this.isVerified,
    required this.distance,
    required this.compatibility,
    required this.interests,
    required this.bio,
  });

  String get fullName => '$firstName $lastName';
  String get location => '$city, $country';
  String get shortLocation => city;

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        age,
        city,
        state,
        country,
        avatarThumb,
        avatarLarge,
        email,
        phone,
        gender,
        isOnline,
        isVerified,
        distance,
        compatibility,
        interests,
        bio,
      ];
}
