import 'package:app/core/app_colors.dart';
import 'package:app/core/functions/snake_bar.dart';
import 'package:app/views/auth/UI/widgets/custom_button.dart';
import 'package:app/core/components/custom_text_form_field.dart';
import 'package:app/views/auth/logic/loginstate_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginstateCubit, LoginstateState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccesses) {
            Navigator.pop(context);
            snakeBar(context, 'Email sended successfully', Colors.green);
          }
        },
        builder: (context, state) {
          LoginstateCubit cubit = context.read<LoginstateCubit>();
          return SafeArea(
            child: Form(
              key: formkey,
              child: state is ResetPasswordLoading
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          'Enter your email to reset your password',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Card(
                          margin: const EdgeInsets.all(16),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          color: AppColors.kWhiteColor,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                CustomTextFormFeild(
                                    lableText: 'Email',
                                    controller: emailController,
                                    obscureText: false,
                                    keyboardType: TextInputType.emailAddress),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomButton(
                                    onPressed: () {
                                      if (formkey.currentState!.validate()) {
                                        cubit.resePassword(
                                            email: emailController.text);
                                      }
                                    },
                                    child: const Text(
                                      'Reset Password',
                                      style: TextStyle(
                                          color: AppColors.kWhiteColor),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
