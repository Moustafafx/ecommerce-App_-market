import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/features/shared/coustomtext.dart';

class Definition_of_part extends StatelessWidget {
   Definition_of_part({
    super.key, required this.namedescription,required this.ontap
  });
  void Function()ontap;
final String namedescription;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        coustomtext(
          text: namedescription,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
    


    
        TextButton(
          onPressed: ontap,
          child: coustomtext(
            text: "View all",
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.colorbluebutton,
          ),
        ),
      ],
    );
  }
}
