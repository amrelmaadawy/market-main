part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class GetDataLoadingState extends HomeState {}

class GetDataSuccesseState extends HomeState {}

class GetDataErrorState extends HomeState {
  final String massage;
  GetDataErrorState(this.massage);
}

class AddToFaveLoadingState extends HomeState {}

class AddToFaveSuccesseState extends HomeState {}

class AddToFaveErrorState extends HomeState {}


class DeletFromFaveLoadingState extends HomeState {}

class DeletFromFaveSuccesseState extends HomeState {}

class DeletFromFaveErrorState extends HomeState {}
