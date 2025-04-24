import 'package:app/core/app_colors.dart';
import 'package:app/core/functions/bloc_observer.dart';
import 'package:app/core/sensitive_data.dart';
import 'package:app/views/auth/UI/login_view.dart';
import 'package:app/views/auth/logic/loginstate_cubit.dart';
import 'package:app/views/nav_bar/UI/main_home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://zieeiuozhhjeiseqclvd.supabase.co',
    anonKey: apiKey,
    authOptions: const FlutterAuthClientOptions(
      autoRefreshToken: true,
      detectSessionInUri: true,
    ),
  );
  Bloc.observer = MyObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SupabaseClient client = Supabase.instance.client;
    return BlocProvider(
      create: (context) => LoginstateCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.kScaffoldColor,
          useMaterial3: true,
        ),
        home: 
        client.auth.currentUser != null
            ? MainHomeView()
            : const LoginView(),
            
      ),
    );
  }
}
