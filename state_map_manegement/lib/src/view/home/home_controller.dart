import 'package:flutter/cupertino.dart';

class HomeControler extends ValueNotifier<HomeState> {
  HomeControler() : super(Loading());

  void getData() {
    value = Loaded(['Casa', 'Bwolf', 'Vilson']);
  }

  void getError() {
    value = Error();
  }

  void getSnack() {
    value = Snack();
  }
}

abstract class HomeState {}

class Loading extends HomeState {}

class Error extends HomeState {}

class Snack extends HomeState {}

class Loaded extends HomeState {
  final List<String> data;

  Loaded(this.data);
}
