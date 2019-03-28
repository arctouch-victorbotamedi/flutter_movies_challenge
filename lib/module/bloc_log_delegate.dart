import 'package:bloc/bloc.dart';

class BlocLogDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    print(transition.toString());
  }
}
