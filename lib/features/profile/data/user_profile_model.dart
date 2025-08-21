class UserProfileEntity {
  final String userId;
  final String fullName;
  final String email;
  final String phoneNumber;
  final int age;
  final String gender;
  final bool profileUpdated;
  final bool isAdmin;

  UserProfileEntity({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.age, 
    required this.gender,
    this.profileUpdated = false,
    this.isAdmin = false,
  });

  UserProfileEntity copyWith({
    String? fullName,
    String? userName,
    String? email,
    String? phoneNumber,
    int? age,
    String? gender,
  
    bool? profileUpdated,
    bool? isAdmin,
  }) {
    return UserProfileEntity(
      userId: userId, //yo not editable
      fullName: fullName ?? this.fullName,
  
      email: email ?? this.email, // yo ni not editable
      phoneNumber: phoneNumber ?? this.phoneNumber,
    
      profileUpdated: profileUpdated ?? this.profileUpdated,
      isAdmin: isAdmin ?? this.isAdmin, age: age ?? this.age, gender: gender ?? this.gender,
    );
  }
}
