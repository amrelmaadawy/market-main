import 'package:app/core/app_colors.dart';
import 'package:app/views/auth/logic/module/user_module.dart';
import 'package:app/views/favorite/UI/favorite_view.dart';
import 'package:app/views/home/UI/home_view.dart';
import 'package:app/views/nav_bar/logic/nav_bar_cubit_cubit.dart';
import 'package:app/views/profile/UI/profile_view.dart';
import 'package:app/views/store/UI/store_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainHomeView extends StatefulWidget {
  const MainHomeView({super.key, required this.userModule});

  final UserModule userModule;
  @override
  State<MainHomeView> createState() => _MainHomeViewState();
}

class _MainHomeViewState extends State<MainHomeView> {
  late List<Widget> views;
  @override
  void initState() {
    super.initState();

    views = [
      HomeView(userModule: widget.userModule),
      const StoreView(),
      const FavoriteView(),
      const ProfileView()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavBarCubit(),
      child: BlocBuilder<NavBarCubit, NavBarCubitState>(
        builder: (context, state) {
          NavBarCubit cubit = BlocProvider.of<NavBarCubit>(context);
          return Scaffold(
            body: SafeArea(child: views[cubit.currentIndex]),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: AppColors.kWhiteColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: GNav(
                    selectedIndex: cubit.currentIndex,
                    rippleColor: AppColors.kPrimaryColor.withOpacity(0.1),
                    hoverColor: AppColors.kPrimaryColor.withOpacity(0.05),
                    tabBorderRadius: 16,
                    duration: const Duration(milliseconds: 400),
                    gap: 8,
                    color: AppColors.kGreyColor,
                    activeColor: AppColors.kPrimaryColor,
                    iconSize: 24,
                    tabBackgroundColor: AppColors.kPrimaryColor.withOpacity(0.1),
                    onTabChange: (index) {
                      cubit.changeView(index);
                    },
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    tabs: const [
                      GButton(
                        icon: Icons.home_rounded,
                        text: 'Home',
                      ),
                      GButton(
                        icon: Icons.storefront_rounded,
                        text: 'Store',
                      ),
                      GButton(
                        icon: Icons.favorite_rounded,
                        text: 'Favorites',
                      ),
                      GButton(
                        icon: Icons.person_rounded,
                        text: 'Profile',
                      )
                    ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
