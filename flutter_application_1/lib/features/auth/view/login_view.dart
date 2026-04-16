import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/cubits/cubit_user/user_cubit_cubit.dart';
import 'package:flutter_application_1/features/auth/widgets/coustom_buttom.dart';
import 'package:flutter_application_1/features/shared/coustomtext.dart';
import 'package:flutter_application_1/features/shared/coustomtextformfield.dart';
import 'package:flutter_application_1/root_navigator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController _textEditingControlleremail = TextEditingController();

  TextEditingController _textEditingControllerpassword =
      TextEditingController();

  bool isChecked = false;

  GlobalKey<FormState> formkey = GlobalKey();
  List images = [
    Image.asset(
      "assets/images/auth_with/png-clipart-google-logo-computer-icons-google-logo-google-angle-logo-removebg-preview.png",
    ),
    Image.asset("assets/images/auth_with/apple (1).png"),
    Image.asset("assets/images/auth_with/free-facebook-icon-108-thumb.png"),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubitCubit,UserCubitState>(
      listener: (context, state) {
     if(state is usersuccesssignin){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("success")));
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Root()));
     }else if(state is userfailersignin ){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errormessage)));

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
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Color(0xffCADCFF), width: 2),
                    ),
                    child: Center(
                      child: coustomtext(
                        text: "skip",
                        color: Color(0xff3F80FF),
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: AppColors.colorsinapp,
            elevation: 0, // ده يشيل الظل الرمادي
          ),
          body: Form(
            key: formkey,
            child: ListView(
              children: [
                Image.asset("assets/images/Logo_Splash_Screen.png"),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: coustomtextformfield(
                    hintText: "Username or Email",
                    controller: _textEditingControlleremail,
                    password: false,
                    icon: Icon(Icons.email_outlined, color: Colors.black),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: coustomtextformfield(
                    hintText: "password",
                    controller: _textEditingControllerpassword,
                    password: true,
                    icon: Icon(Icons.lock_outline_rounded, color: Colors.black),
                  ),
                ),

                Row(
                  children: [
                    // المتغير اللي هيتحكم في الحالة
                    Checkbox(
                      activeColor: AppColors.colorbluebutton,
                      value: isChecked, // الحالة الحالية
                      onChanged: (bool? value) {
                        // لما المستخدم يضغط على الـ checkbox
                        setState(() {
                          isChecked = value!; // حدث الحالة
                        });
                      },
                    ),

                    coustomtext(text: "Remember Me"),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("ForgotPasswordPage");
                      },
                      child: coustomtext(text: "Forgot Password?"),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:state is userloadingdata? CupertinoActivityIndicator(): coustombuttom(
                    form: formkey,
                    text: "Log In",
                    onTap: () {
                      formkey.currentState!.validate();
                      BlocProvider.of<UserCubitCubit>(context).signin(
                        _textEditingControlleremail.text,
                        _textEditingControllerpassword.text,
                        
                      );

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
