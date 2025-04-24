import 'package:app/core/app_colors.dart';
import 'package:app/views/auth/UI/login_view.dart';
import 'package:app/views/auth/logic/loginstate_cubit.dart';
import 'package:app/views/auth/logic/module/user_module.dart';
import 'package:app/views/profile/UI/edit_name_view.dart';
import 'package:app/views/profile/UI/my_orders_view.dart';
import 'package:app/views/profile/UI/widgets/custom_profile_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginstateCubit()..getData(),
      child: BlocConsumer<LoginstateCubit, LoginstateState>(
        listener: (context, state) {
          if (state is LogoutSuccesses) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return LoginView();
            }));
          }
        },
        builder: (context, state) {
          LoginstateCubit cubit = context.read<LoginstateCubit>();
          UserModule? user = context.read<LoginstateCubit>().userModule;
          return state is LogoutLoading
              ? Center(child: CircularProgressIndicator())
              : SafeArea(
                  child: Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: Card(
                        color: AppColors.kWhiteColor,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        margin: const EdgeInsets.all(16),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              const CircleAvatar(
                                radius: 50,
                                backgroundColor: AppColors.kPrimaryColor,
                                child: Icon(
                                  Icons.person,
                                  color: AppColors.kWhiteColor,
                                  size: 50,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                user?.name ?? 'user name',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                user?.email ?? 'Email',
                                style: TextStyle(fontSize: 15),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomProfileButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const EditNameView()));
                                },
                                icon: Icons.person,
                                text: 'Edit Name',
                              ),
                              CustomProfileButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MyOrdersView()));
                                },
                                icon: Icons.badge,
                                text: 'My Orders',
                              ),
                              CustomProfileButton(
                                onPressed: () {
                                  cubit.logOUt();
                                },
                                icon: Icons.logout,
                                text: 'Log Out',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
