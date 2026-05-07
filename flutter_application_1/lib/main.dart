import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/cache/shared_preferences_cache.dart';
import 'package:flutter_application_1/cubits/RelatedcategoryCubit/cubit/related_category_cubit_cubit.dart';
import 'package:flutter_application_1/cubits/add_imageprofile/cubit/add_image_cubit.dart';
import 'package:flutter_application_1/cubits/brand_cubit/brand_cubit.dart';
import 'package:flutter_application_1/cubits/cubit_category/cubit/cubit_category_cubit.dart';
import 'package:flutter_application_1/core/network/dio_consumer.dart';
import 'package:flutter_application_1/cubits/cubit_user/user_cubit_cubit.dart';
import 'package:flutter_application_1/cubits/favourite/favourite_cubit.dart';
import 'package:flutter_application_1/cubits/product_cubit/popular_product_cubit.dart';
import 'package:flutter_application_1/cubits/searchin_home/cubit/search_cubit.dart';
import 'package:flutter_application_1/cubits/signup/cubit/signup_cubit.dart';
import 'package:flutter_application_1/cubits/theme_ucbit/cubit/theme_cubit.dart';
import 'package:flutter_application_1/features/auth/view/Verification_Code_with_email.dart';
import 'package:flutter_application_1/features/auth/view/forgot_password_page.dart';
import 'package:flutter_application_1/features/auth/view/login_view.dart';
import 'package:flutter_application_1/features/auth/view/signup_view.dart';
import 'package:flutter_application_1/root_navigator.dart';
import 'package:flutter_application_1/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesCache.cacheInitialization();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CubitCategoryCubit(DioConsumer(Dio()))..getProducts(),
        ),

        BlocProvider(
          create: (_) => RelatedCategoryCubitCubit(
            DioConsumer(Dio()), // أو ApiConsumer حسب اللي عندك
          ),
        ),

        BlocProvider(
          create: (_) => BrandCubit(
            DioConsumer(Dio()), // أو ApiConsumer حسب اللي عندك
          )..getBrands(),
        ),

        BlocProvider(
          create: (_) =>
              PopularProductCubit(DioConsumer(Dio()))..getallproduct(),
        ),

        BlocProvider(create: (_) => ThemeCubit()),

        BlocProvider(
          create: (_) => SignupCubit(
            DioConsumer(Dio()), //
          ),
        ),


    BlocProvider(
      create: (_) => UserCubitCubit(DioConsumer(Dio())),
    ),

        BlocProvider(
          create: (_) => FavoriteCubit(
            DioConsumer(Dio()), //
          ),
        ),


        BlocProvider(
          create: (_) => AddImageCubit(
            DioConsumer(Dio()), //
          )..addimage(),
        ),



        BlocProvider(
          create: (_) => SearchCubit(
            DioConsumer(Dio()), //
          )
        ),


      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(
               theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),

          routes: {
            "login": (context) => LoginView(),
            "signup": (context) => SignupView(),
            "ForgotPasswordPage": (context) => ForgotPasswordPage(),
            "Verification_Code_with_email": (context) =>
                VerificationCodeWithEmail(),
            "root": (context) => Root(),
          },
        );
      },
    );
  }
}
