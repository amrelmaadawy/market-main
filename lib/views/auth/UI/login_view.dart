// ignore_for_file: use_build_context_synchronously

import 'package:app/core/app_colors.dart';
import 'package:app/core/functions/snake_bar.dart';
import 'package:app/views/auth/UI/forget_password.dart';
import 'package:app/views/auth/UI/sign_up.dart';
import 'package:app/core/components/custom_text_form_field.dart';
import 'package:app/views/auth/UI/widgets/login_widget.dart';
import 'package:app/views/auth/UI/widgets/text_button.dart';
import 'package:app/views/auth/logic/loginstate_cubit.dart';
import 'package:app/views/nav_bar/UI/main_home_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    if (kDebugMode) {
      print(Supabase.instance.client.auth.currentUser);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginstateCubit, LoginstateState>(
      listener: (context, state) {
        if (state is LoginstateSuccesses || state is GoogleSignInSuccesses) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return MainHomeView();
          }));
        }
        if (state is LoginstateErorr) {
          snakeBar(context, state.message, Colors.red);
        }
      },
      builder: (context, state) {
        LoginstateCubit cubit = context.read<LoginstateCubit>();
        return Scaffold(
          body: state is LoginstateLoading
              ? const CircularProgressIndicator()
              : Form(
                  key: _formKey,
                  child: SafeArea(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        const Center(
                            child: Text(
                          'welcome to our market',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        )),
                        const SizedBox(
                          height: 50,
                        ),
                        Card(
                          margin: const EdgeInsets.all(16),
                          color: AppColors.kWhiteColor,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                CustomTextFormFeild(
                                  lableText: 'Email',
                                  controller: emailController,
                                  obscureText: false,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomTextFormFeild(
                                    lableText: 'Password',
                                    controller: passwordController,
                                    obscureText: cubit.isVisible,
                                    keyboardType: TextInputType.visiblePassword,
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          cubit.changeVisibility();
                                        },
                                        icon: Icon(cubit.isVisible
                                            ? Icons.visibility_off
                                            : Icons.visibility))),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Textbutton(
                                      text: 'Forget Password?',
                                      ontap: () => Navigator.push(
                                        (context),
                                        MaterialPageRoute(builder: (context) {
                                          return const ForgetPassword();
                                        }),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                LoginWidget(
                                  text: 'Login',
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      cubit
                                          .login(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      )
                                          .then((value) {
                                        snakeBar(context, 'login successful',
                                            Colors.green);
                                      });
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) {
                                          return MainHomeView();
                                        }),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Please enter valid email and password'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                LoginWidget(
                                  text: 'Login With Google',
                                  onPressed: () {
                                    cubit.nativeGoogleSignIn();
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Don\'t have an account? '),
                                    Textbutton(
                                      text: 'Sign up',
                                      ontap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) {
                                            return const SignUp();
                                          }),
                                        );
                                      },
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
                ),
        );
      },
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
