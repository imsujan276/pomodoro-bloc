import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  Future<void> onEvent(Bloc bloc, Object? event) async {
    super.onEvent(bloc, event);
    if (kDebugMode) {
      print("Event: $event");
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (kDebugMode) {
      print(transition);
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      print(error);
    }
    super.onError(bloc, error, stackTrace);
  }
}
