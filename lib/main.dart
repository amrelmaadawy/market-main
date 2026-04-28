import 'package:app/core/app_colors.dart';
import 'package:app/core/functions/bloc_observer.dart';
import 'package:app/core/shimmer/shimmer_home_view.dart';

import 'package:app/views/auth/UI/login_view.dart';
import 'package:app/views/auth/logic/loginstate_cubit.dart';
import 'package:app/views/nav_bar/UI/main_home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:app/core/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  Bloc.observer = MyObserver();
  runApp(BlocProvider(
    create: (context) => LoginstateCubit(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override

  Widget build(BuildContext context) {
    return BlocConsumer<LoginstateCubit, LoginstateState>(
      listener: (context, state) {},
      builder: (context, state) {
        bool isLoggedIn = context.read<LoginstateCubit>().isLoggedIn;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.kScaffoldColor,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.kPrimaryColor,
              primary: AppColors.kPrimaryColor,
              background: AppColors.kScaffoldColor,
            ),
            useMaterial3: true,
            textTheme: GoogleFonts.interTextTheme(
              Theme.of(context).textTheme,
            ).apply(
              bodyColor: AppColors.kBlackColor,
              displayColor: AppColors.kBlackColor,
            ),
          ),
          home: isLoggedIn
              ? state is LoginstateLoading || state is GoogleSignInLoading
                  ? ShimmerHomeView()
                  : MainHomeView(
                      userModule: context.read<LoginstateCubit>().userModule!,
                    )
              : const LoginView(),
        );
      },
    );
  }
}
