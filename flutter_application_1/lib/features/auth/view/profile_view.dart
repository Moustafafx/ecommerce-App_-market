import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/cache/shared_preferences_cache.dart';
import 'package:flutter_application_1/core/constants/app_colors.dart';
import 'package:flutter_application_1/core/network/api_endpoints.dart';
import 'package:flutter_application_1/cubits/add_imageprofile/cubit/add_image_cubit.dart';
import 'package:flutter_application_1/cubits/theme_ucbit/cubit/theme_cubit.dart';
import 'package:flutter_application_1/features/auth/widgets/profile_animation_widget/OrbitAvatar%20.dart'
    show OrbitAvatar;
import 'package:flutter_application_1/features/auth/widgets/profile_animation_widget/coustom_in_profile.dart';
import 'package:flutter_application_1/features/cart/view/cart_view.dart';
import 'package:flutter_application_1/features/shared/coustomtext.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';

class ProfileView extends StatefulWidget {
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final name = SharedPreferencesCache.getdata(key: "name") ?? "مستخدم";
  final email = SharedPreferencesCache.getdata(key: "email") ?? "email";

    @override
  void initState() {
    super.initState();

    // ✅ تحميل الصورة المحفوظة أول ما الصفحة تفتح
    context.read<AddImageCubit>().getSavedProfileImage();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 11),

            coustomtext(
              text: "My Profile",
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
            CircleAvatar(
              child: IconButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (context) => CartView()));
                },
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color: AppColors.colorbluebutton,
                  size: 27,
                ),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 15),

          // 🔥 الانيميشن هنا
        // في الـ BlocBuilder بتاع الصورة
BlocBuilder<AddImageCubit, AddImageState>(
  builder: (context, state) {
    final cubit = context.read<AddImageCubit>();

    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: () async {
            final picked = await ImagePicker()
                .pickImage(source: ImageSource.gallery);

            if (picked != null) {
              // ✅ أولاً: عرض الصورة محلياً فوراً
              cubit.uploadprofilepic(picked);
              // ✅ ثانياً: رفعها للسيرفر
              await cubit.addimage();
            }
          },
          child: OrbitAvatar(
            networkImage:
                "https://p1.hiclipart.com/preview/666/472/877/person-user-profile-avatar-logo-blackandwhite-symbol-circle-png-clipart.jpg",
            localImage: cubit.profilepic, // ✅ بتمرر الصورة المحلية
          ),
        ),

        // ✅ مؤشر التحميل فوق الصورة
        if (state is AddImageLoading)
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.black45,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          ),
      ],
    );
  },
),

          SizedBox(height: 20),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              coustomtext(
                text: "$name",
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),

              coustomtext(text: "$email", fontSize: 16, color: Colors.grey),
            ],
          ),
          SizedBox(height: 20),
          SettingsItem(
            icon: Icons.person_outline,
            title: "Account Preferences",
            onTap: () {},
          ),

          SettingsItem(
            icon: Icons.credit_card,
            title: "Subscription & Payment",
            onTap: () {},
          ),

          SettingsItem(
            icon: Icons.notifications_none,
            title: "App Notifications",
            trailing: Switch(value: true, onChanged: (value) {}),
          ),

          SettingsItem(
            icon: Icons.dark_mode_outlined,
            title: "Dark Mode",
            trailing: BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, themeMode) {
                return Switch(
                  value: themeMode == ThemeMode.dark,
                  onChanged: (value) {
                    context.read<ThemeCubit>().toggleTheme(value);
                  },
                );
              },
            ),
          ),

          SettingsItem(
            icon: Icons.star_border,
            title: "Rate Us",
            onTap: () {
              double rating = 0;

              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),

                    title: const Text(
                      "How would you rate us ?",
                      textAlign: TextAlign.center,
                    ),

                    content: StatefulBuilder(
                      builder: (context, setState) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 10),

                            RatingBar.builder(
                              initialRating: 0,
                              minRating: 1,
                              itemCount: 5,
                              itemSize: 35,
                              itemBuilder: (context, _) =>
                                  const Icon(Icons.star, color: Colors.amber),
                              onRatingUpdate: (value) {
                                setState(() {
                                  rating = value;
                                });
                              },
                            ),

                            const SizedBox(height: 15),

                            Text(
                              "Your Rating: $rating",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        );
                      },
                    ),

                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),

                      TextButton(
                        onPressed: () {
                          print(rating);
                          Navigator.pop(context);
                        },
                        child: const Text("OK"),
                      ),
                    ],
                  );
                },
              );
            },
          ),

          SettingsItem(
            icon: Icons.person_pin_rounded,
            title: "Provide Feedback",
            onTap: () {},
          ),

          SettingsItem(
            icon: Icons.logout,
            title: "Log Out",
            onTap: () async {
              await SharedPreferencesCache.deletedata(key: Apikey.token);
              // روح لصفحة الـ Login
              Navigator.pushReplacementNamed(context, 'login');
            },
          ),
        ],
      ),
    );
  }
}
