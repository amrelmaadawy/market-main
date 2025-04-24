import 'package:app/core/app_colors.dart';
import 'package:app/core/components/custom_text_form_field.dart';
import 'package:app/core/functions/snake_bar.dart';
import 'package:app/views/auth/UI/login_view.dart';
import 'package:app/views/auth/UI/widgets/login_widget.dart';
import 'package:app/views/auth/UI/widgets/text_button.dart';
import 'package:app/views/auth/logic/loginstate_cubit.dart';
import 'package:app/views/nav_bar/UI/main_home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginstateCubit>();

    return BlocConsumer<LoginstateCubit, LoginstateState>(
      listener: (context, state) {
        if (state is SignUpstateSuccesses) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return LoginView();
          }));
          snakeBar(context, 'Sign in success please Login', Colors.green);
        } else if (state is GoogleSignInSuccesses) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return MainHomeView(userModule:  cubit.userModule!,);
          }));
          snakeBar(context, 'Sign In Successes', Colors.green);
        } else if (state is SignUpstateErorr || state is GoogleSignInErorr) {
          snakeBar(context, 'Error please Try again', Colors.red);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Form(
            key: formKey,
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
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  )),
                  const SizedBox(
                    height: 50,
                  ),
                  Card(
                    margin: const EdgeInsets.all(16),
                    color: AppColors.kWhiteColor,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          CustomTextFormFeild(
                              lableText: 'Name',
                              controller: nameController,
                              obscureText: false,
                              keyboardType: TextInputType.text),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextFormFeild(
                              lableText: 'Email',
                              controller: emailController,
                              obscureText: false,
                              keyboardType: TextInputType.emailAddress),
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
                          const SizedBox(
                            height: 20,
                          ),
                          LoginWidget(
                            text: 'Sign Up',
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                await cubit.register(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text);
                                // ignore: use_build_context_synchronously
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return MainHomeView(userModule: cubit.userModule!,);
                                }));
                              } else {
                                snakeBar(context, 'Please fill all fields',
                                    Colors.red);
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          LoginWidget(
                            text: 'Sign Up With Google',
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
                              const Text('already have an account? '),
                              Textbutton(
                                text: 'Login',
                                ontap: () {
                                  Navigator.pop(context);
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
    nameController.dispose();
    super.dispose();
  }
}
