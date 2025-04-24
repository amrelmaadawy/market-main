import 'package:bloc/bloc.dart';

part 'nav_bar_cubit_state.dart';

class NavBarCubit extends Cubit<NavBarCubitState> {
  NavBarCubit() : super(NavBarCubitInitial());

  int currentIndex = 0;
  void changeView(int index) {
    currentIndex = index;
    emit(NavBarChangeView());
  }
}
