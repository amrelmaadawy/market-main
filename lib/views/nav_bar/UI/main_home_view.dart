import 'package:app/core/app_colors.dart';
import 'package:app/views/favorite/UI/favorite_view.dart';
import 'package:app/views/home/UI/home_view.dart';
import 'package:app/views/nav_bar/logic/nav_bar_cubit_cubit.dart';
import 'package:app/views/profile/UI/profile_view.dart';
import 'package:app/views/store/UI/store_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainHomeView extends StatelessWidget {
  MainHomeView({super.key});
  final List<Widget> views = [
    const HomeView(),
    const StoreView(),
    const FavoriteView(),
    const ProfileView()
  ];
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
              color: AppColors.kWhiteColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GNav(
                    selectedIndex: cubit.currentIndex,
                    rippleColor: AppColors.kPrimaryColor,
                    hoverColor: AppColors.kPrimaryColor,
                    tabBorderRadius: 20,
                    duration: const Duration(milliseconds: 900),
                    gap: 8,
                    color: Colors.grey,
                    activeColor: AppColors.kWhiteColor,
                    iconSize: 24,
                    tabBackgroundColor: AppColors.kPrimaryColor,
                    onTabChange: (index) {
                      cubit.changeView(index);
                    },
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    tabs: const [
                      GButton(
                        icon: Icons.home,
                        text: 'Home',
                      ),
                      GButton(
                        icon: Icons.store,
                        text: 'Store',
                      ),
                      GButton(
                        icon: Icons.favorite,
                        text: 'Favorites',
                      ),
                      GButton(
                        icon: Icons.person,
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
