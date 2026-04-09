import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/features/auth/widgets/coustom_buttom.dart';
import 'package:flutter_application_1/features/shared/coustomtext.dart';
import 'package:pinput/pinput.dart';

class VerificationCodeWithEmail extends StatefulWidget {
  @override
  State<VerificationCodeWithEmail> createState() =>
      _VerificationCodeWithEmailState();
}

class _VerificationCodeWithEmailState extends State<VerificationCodeWithEmail> {
  GlobalKey<FormState> formkey_ForgotPassword_With_Email = GlobalKey();

  int _start = 30;

  bool _canResend = false;

  Timer? _timer;

  TextEditingController Forgot_Password_With_Email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorsinapp,
      appBar: AppBar(
        title: coustomtext(
          text: "Verification Code",
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
        key: formkey_ForgotPassword_With_Email,
        child: ListView(
          children: [
            SizedBox(height: 50),
            Image.asset(
              "assets/images/ForgotPassword_verification/Illustration_Verification_Code_With_Email.png",
              height: 288,
            ),
            SizedBox(height: 10),
            Column(
              children: [
                coustomtext(
                  text: "Please enter the 4 digit code",
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff51526C),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    coustomtext(
                      text: "sent to:",
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff51526C),
                    ),
                    coustomtext(
                      text: "You@gmail.com",
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff3F80FF),
                    ),
                  ],
                ),

                // داخل الـ Build method
                Pinput(
                  obscureText: false,
                  length: 4, // عدد المربعات (غالباً 4 أو 6)
                  onCompleted: (pin) {
                    print('الكود اللي المستخدم دخله: $pin');
                    // هنا تقدر تبعت الكود للسيرفر للتأكد منه
                  },
                ),

                SizedBox(height: 30),

                coustombuttom(
                  onTap: () {
                    formkey_ForgotPassword_With_Email.currentState!.validate();
                  },
                  form: formkey_ForgotPassword_With_Email,
                  text: "Verify Code",
                ),

                Column(
                  children: [
                    // هنا بيكون الـ Pinput بتاعك
                    const SizedBox(height: 20),

                    TextButton(
                      onPressed: _canResend
                          ? () {
                              // هنا تحط الفانكشن اللي بتكلم السيرفر تبعت الكود تاني
                              startTimer();
                            }
                          : null, // الزرار هيكون مطفي (Disabled) طول ما العداد شغال
                      child: Text(
                        _canResend
                            ? "إعادة إرسال"
                            : "إعادة إرسال خلال $_start ثانية",
                        style: TextStyle(
                          color: _canResend ? Colors.blue : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void startTimer() {
    setState(() {
      _canResend = false;
      _start = 30;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _timer?.cancel();
          _canResend = true;
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }
}
