import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/features/auth/widgets/coustom_buttom.dart';
import 'package:flutter_application_1/features/shared/coustomtext.dart';
import 'package:flutter_application_1/features/shared/coustomtextformfield.dart';

class ForgotPasswordPage extends StatelessWidget {
  GlobalKey<FormState> formkey_ForgotPassword_With_Email = GlobalKey();
  TextEditingController Forgot_Password_With_Email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorsinapp,
      appBar: AppBar(
        title: coustomtext(
          text: "Forgot Password",
          fontWeight: FontWeight.w500,
          fontSize: 19,
          color: Color(0xff51526C),
        ),
        leadingWidth: 80,
        leading: Row(
          children: [
            SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed("signup");
              },
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Color(0xffCADCFF), width: 2),
                ),
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back_ios_new, size: 25),
                  ),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Form(
        key:  formkey_ForgotPassword_With_Email,
        child: ListView(
          children: [
            SizedBox(height: 50),
            Image.asset(
              "assets/images/ForgotPassword_verification/Illustration_Forgot_Password_With_Email.png",
              height: 288,
            ),
            SizedBox(height: 10),
            Column(
              children: [
                coustomtext(
                  text: "Please enter your email address to",
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff51526C),
                ),
                coustomtext(
                  text: "receive a verification code",
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff51526C),
                ),

                coustomtextformfield(
                  hintText: "You@gmail.com",
                  controller: Forgot_Password_With_Email,
                  password: false,
                  icon: Icon(Icons.email_outlined),
                  lable: "Email",
                ),

                SizedBox(height: 30),

                coustombuttom(
                  onTap: () {
                    formkey_ForgotPassword_With_Email.currentState!.validate();
                    Navigator.of(context).pushNamed("Verification_Code_with_email");
                  },
                  form: formkey_ForgotPassword_With_Email,
                  text: "Send Code",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
