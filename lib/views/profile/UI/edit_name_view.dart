import 'package:app/core/app_colors.dart';
import 'package:app/core/functions/custom_app_bar.dart';
import 'package:app/views/auth/UI/widgets/custom_button.dart';
import 'package:app/core/components/custom_text_form_field.dart';
import 'package:app/views/auth/logic/loginstate_cubit.dart';
import 'package:app/views/nav_bar/UI/main_home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditNameView extends StatefulWidget {
  const EditNameView({super.key});

  @override
  State<EditNameView> createState() => _EditNameViewState();
}

class _EditNameViewState extends State<EditNameView> {
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'Edit Name'),
      body: BlocProvider(
        create: (context) => LoginstateCubit(),
        child: BlocConsumer<LoginstateCubit, LoginstateState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomTextFormFeild(
                      lableText: 'Enter Name',
                      controller: nameController,
                      obscureText: false,
                      keyboardType: TextInputType.text),
                ),
                CustomButton(
                    onPressed: () {
                      if (nameController.text.isNotEmpty) {
                        context.read<LoginstateCubit>().editName(
                              name: nameController.text,
                            );
                      
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainHomeView(
                                        userModule: context
                                            .read<LoginstateCubit>()
                                            .userModule!,
                                      )));
                      
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter your name'),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(color: AppColors.kWhiteColor),
                    ))
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }
}
