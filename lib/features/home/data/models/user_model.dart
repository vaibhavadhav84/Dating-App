// lib/features/home/data/models/user_model.dart
import 'dart:math';
import '../../domain/entities/user_entity.dart';
import '../../../../core/constants/app_constants.dart';

class UserModel {
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

  const UserModel({
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
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['login']?['uuid'] as String? ?? '',
      firstName: json['name']?['first'] as String? ?? '',
      lastName: json['name']?['last'] as String? ?? '',
      age: json['dob']?['age'] as int? ?? 0,
      city: json['location']?['city'] as String? ?? '',
      state: json['location']?['state'] as String? ?? '',
      country: json['location']?['country'] as String? ?? '',
      avatarThumb: json['picture']?['thumbnail'] as String? ?? '',
      avatarLarge: json['picture']?['large'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'login': {'uuid': id},
        'name': {'first': firstName, 'last': lastName},
        'dob': {'age': age},
        'location': {'city': city, 'state': state, 'country': country},
        'picture': {'thumbnail': avatarThumb, 'large': avatarLarge},
        'email': email,
        'phone': phone,
        'gender': gender,
      };
  UserEntity toEntity() {
    final rng = Random(id.hashCode);

    final femaleImages = [
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=800&h=1000&q=80',
      'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=800&h=1000&q=80',
      'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=800&h=1000&q=80',
      'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=800&h=1000&q=80',
      'https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?auto=format&fit=crop&w=800&h=1000&q=80',
      'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=800&h=1000&q=80',
      'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?auto=format&fit=crop&w=800&h=1000&q=80',
      'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?auto=format&fit=crop&w=800&h=1000&q=80',
    ];

    final maleImages = [
      'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=800&h=1000&q=80',
      'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=800&h=1000&q=80',
      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=800&h=1000&q=80',
      'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?auto=format&fit=crop&w=800&h=1000&q=80',
      'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?auto=format&fit=crop&w=800&h=1000&q=80',
      'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?auto=format&fit=crop&w=800&h=1000&q=80',
      'https://images.unsplash.com/photo-1489980508314-941910ded1f4?auto=format&fit=crop&w=800&h=1000&q=80',
      'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=800&h=1000&q=80',
    ];

    final imgIndex = rng.nextInt(8);
    final highResAvatar = gender == 'female'
        ? femaleImages[imgIndex]
        : maleImages[imgIndex];

    final isOnline = rng.nextBool();
    final isVerified = rng.nextBool();
    final distance = (rng.nextDouble() * 14.5) + 0.5; // 0.5–15.0
    final compatibility = rng.nextInt(30) + 70; // 70–99

    final shuffled = List<String>.from(AppConstants.interestsList)
      ..shuffle(rng);
    final interests = shuffled.take(3).toList();

    final templateIndex = rng.nextInt(AppConstants.bioTemplates.length);
    final bio = AppConstants.bioTemplates[templateIndex]
        .replaceAll('{name}', firstName);

    return UserEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      age: age,
      city: city,
      state: state,
      country: country,
      avatarThumb: highResAvatar,
      avatarLarge: highResAvatar,
      email: email,
      phone: phone,
      gender: gender,
      isOnline: isOnline,
      isVerified: isVerified,
      distance: double.parse(distance.toStringAsFixed(1)),
      compatibility: compatibility,
      interests: interests,
      bio: bio,
    );
  }
}
