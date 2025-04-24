import 'package:app/core/app_colors.dart';
import 'package:app/core/functions/custom_app_bar.dart';
import 'package:app/views/auth/UI/widgets/custom_button.dart';
import 'package:app/core/components/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class EditNameView extends StatelessWidget {
  const EditNameView({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    return Scaffold(
      appBar: customAppBar(context, 'Edit Name'),
      body: Column(
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
              onPressed: () {},
              child: const Text(
                'Update',
                style: TextStyle(color: AppColors.kWhiteColor),
              ))
        ],
      ),
    );
  }
}
