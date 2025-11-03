import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/profile/data/user_profile_model.dart';
import 'package:news_app/features/profile/presentation/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final FirebaseFirestore firestore;
  ProfileCubit(this.firestore) : super(ProfileLoading());

  Future<void> fetchProfile(String userId) async {
    emit(ProfileLoading());
    try {
      final doc = await firestore.collection("users").doc(userId).get();
      final data = doc.data();
      if (data != null) {
        final profile = UserProfileEntity(
          userId: userId,
          fullName: data["name"] ?? "",

          email: data["email"] ?? "",
          phoneNumber: data["phone"] ?? "",
          age: data["age"] ?? "",
          gender: data["gender"] ?? "",
        );
        emit(ProfileLoaded(profile));
      } else {
        emit(ProfileError("No profile found"));
      }
    } catch (e) {
      emit(ProfileError("Failed to fetch profile"));
    }
  }

  Future<void> updateProfile(UserProfileEntity updated) async {
    emit(ProfileLoading());
    try {
      await firestore.collection("users").doc(updated.userId).update({
        "name": updated.fullName,
        "phone": updated.phoneNumber,
        "age": updated.age,
        "gender": updated.gender,
      });
      emit(ProfileLoaded(updated));
    } catch (e) {
      emit(ProfileError("Failed to update profile"));
    }
  }
}
