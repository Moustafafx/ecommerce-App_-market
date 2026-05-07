import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/cubits/signup/cubit/signup_cubit.dart';
import 'package:flutter_application_1/features/auth/widgets/coustom_buttom.dart';
import 'package:flutter_application_1/features/shared/coustomtext.dart';
import 'package:flutter_application_1/features/shared/coustomtextformfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupView extends StatefulWidget {
  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  TextEditingController _FullName = TextEditingController();
  TextEditingController emailsignup = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  TextEditingController phone = TextEditingController();

  TextEditingController _textEditingControllerpassword =
      TextEditingController();
  bool isChecked = false;

  GlobalKey<FormState> _registerFormKey = GlobalKey();
  List images = [
    Image.asset(
      "assets/images/auth_with/png-clipart-google-logo-computer-icons-google-logo-google-angle-logo-removebg-preview.png",
    ),
    Image.asset("assets/images/auth_with/apple (1).png"),
    Image.asset("assets/images/auth_with/free-facebook-icon-108-thumb.png"),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is Signupsuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));

          Navigator.pushReplacementNamed(context, "login");
        }

        if (state is Signuperror) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.colorsinapp,
          appBar: AppBar(
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
            key: _registerFormKey,
            child: ListView(
              children: [
                Image.asset(
                  "assets/images/Logo_Splash_Screen.png",
                  height: 200,
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: coustomtextformfield(
                    keyboardType: TextInputType.name,
                    lable: "Your Name",
                    hintText: "Full Name",
                    controller: _FullName,
                    password: false,
                    icon: Icon(Icons.how_to_reg_rounded, color: Colors.black),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: coustomtextformfield(
                    keyboardType: TextInputType.phone,
                    lable: "Phone Number",
                    hintText: "+20 1501142409",
                    controller: phone,
                    password: false,
                    icon: Icon(Icons.phone_android, color: Colors.black),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: coustomtextformfield(
                    keyboardType: TextInputType.emailAddress,
                    lable: "Email",
                    hintText: "You@gmail.com",
                    controller: emailsignup,
                    password: false,
                    icon: Icon(Icons.email_outlined, color: Colors.black),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: coustomtextformfield(
                    lable: "Password",
                    hintText: "password",
                    controller: _textEditingControllerpassword,
                    password: true,
                    icon: Icon(Icons.lock_outline_rounded, color: Colors.black),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: coustomtextformfield(
                    lable: "Confirm Password",
                    hintText: "password",
                    controller: confirmPasswordController,
                    password: true,
                    icon: Icon(Icons.lock_outline_rounded, color: Colors.black),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: coustombuttom(
                    form: _registerFormKey,
                    text: "Sign Up",
                    onTap: () {
                      if (_registerFormKey.currentState!.validate()) {
                        BlocProvider.of<SignupCubit>(context).signUp(
                          name: _FullName.text,
                          phone: phone.text,
                          email: emailsignup.text,
                          password: _textEditingControllerpassword.text,
                          confirmPassword: confirmPasswordController.text,
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: 6),
                Center(
                  child: coustomtext(
                    text: "Or Continue With",
                    color: Color(0xff51526C),
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
                SizedBox(height: 11),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(images.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(37),
                              border: Border.all(
                                width: 2,
                                color: AppColors.colorbordertextformfield,
                              ),
                            ),
                            height: 55,
                            width: 55,
                            child: images[index],
                          ),
                        ),
                      );
                    }),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    coustomtext(
                      text: "Are you new in Marketi",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: coustomtext(
                        text: "register?",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
