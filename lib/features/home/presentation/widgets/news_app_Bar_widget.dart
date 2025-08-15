import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/features/auth/presentation/widgets/text_widget.dart';

class NewsAppBarWidget extends StatelessWidget implements PreferredSize {
  final String title;

  const NewsAppBarWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextWidget(
        word: title,
        size: 32.h,
        weight: FontWeight.bold,
        textColor: Colors.blueAccent,
      ),
    );
  }

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}
