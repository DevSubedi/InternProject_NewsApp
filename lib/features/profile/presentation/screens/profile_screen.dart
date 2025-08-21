import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/routing/navigation_service.dart';
import 'package:news_app/core/routing/route_name.dart';
import 'package:news_app/features/auth/presentation/login/widgets/login_button_widget.dart';

import 'package:news_app/features/auth/presentation/login/widgets/login_change_language_widget.dart';
import 'package:news_app/features/auth/presentation/login/widgets/text_widget.dart';

import 'package:news_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:news_app/features/profile/presentation/cubit/profile_state.dart';

import 'package:news_app/features/profile/presentation/widgets/editable_field_widet.dart';
import 'package:news_app/l10n/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  final String userId;
  const ProfileScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (_) =>
          ProfileCubit(FirebaseFirestore.instance)..fetchProfile(userId),
      child: Scaffold(
        appBar: AppBar(
          title: TextWidget(
            word: l10.myProfile,
            textColor: Colors.blue,
            size: 24,
            weight: FontWeight.w700,
          ),
        ),
        body: Column(
          children: [
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProfileLoaded) {
                  final user = state.profile;
                  return Padding(
                    padding: EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: CircleAvatar(
                              radius: 60,
                              child: Text(
                                user.fullName.isNotEmpty
                                    ? user.fullName[0].toUpperCase()
                                    : "?",
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          EditableField(
                            title: l10.name,
                            value: user.fullName,
                            onEdit: (val) => context
                                .read<ProfileCubit>()
                                .updateProfile(user.copyWith(fullName: val)),
                          ),

                          EditableField(
                            title: l10.email,
                            value: user.email,
                            editable: false,
                          ),
                          EditableField(
                            title: l10.phoneNo,
                            value: user.phoneNumber,
                            onEdit: (val) => context
                                .read<ProfileCubit>()
                                .updateProfile(user.copyWith(phoneNumber: val)),
                          ),
                          EditableField(
                            title: l10.age,
                            value: '${user.age}',
                            onEdit: (val) =>
                                context.read<ProfileCubit>().updateProfile(
                                  user.copyWith(age: int.tryParse(val)),
                                ),
                          ),
                          EditableField(
                            title: l10.gender,
                            value: user.gender,
                            onEdit: (val) => context
                                .read<ProfileCubit>()
                                .updateProfile(user.copyWith(gender: val)),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (state is ProfileError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox.shrink();
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: LoginChangeLanguageWidget(),
            ),
            SizedBox(height: 5),
            LoginButton(
              onPressed: (context) =>
                  NavigationService.pushNamedReplacement(RouteName.login),
              title: l10.logout,
              buttonBackgroundColor: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
