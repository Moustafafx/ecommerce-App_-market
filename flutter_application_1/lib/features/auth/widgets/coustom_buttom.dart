import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/features/shared/coustomtext.dart';

class coustombuttom extends StatelessWidget {
  const coustombuttom({
    super.key,
    required this.form,
    required this.text,
    this.onTap,
  });

  final GlobalKey<FormState> form;
  final String text;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 300,
        height: 48,
        decoration: BoxDecoration(
          color:AppColors.colorbluebutton,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: coustomtext(
            text: text,
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: AppColors.colorsinapp,
          ),
        ),
      ),
    );
  }
}
