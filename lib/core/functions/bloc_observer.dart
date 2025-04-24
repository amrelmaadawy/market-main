import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

class MyObserver implements BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    if (kDebugMode) {
      print('${bloc.runtimeType} $change');
    }
  }

  @override
  void onClose(BlocBase bloc) {
    if (kDebugMode) {
      print('${bloc.runtimeType} closed');
    }
  }

  @override
  void onCreate(BlocBase bloc) {
    if (kDebugMode) {
      print('${bloc.runtimeType} created');
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {}

  @override
  void onEvent(Bloc bloc, Object? event) {}

  @override
  void onTransition(Bloc bloc, Transition transition) {}
}
