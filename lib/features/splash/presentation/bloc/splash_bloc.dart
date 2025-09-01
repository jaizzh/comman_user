import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<AppStarted>((event, emit) async {
      emit(SplashLoading());
      await Future.delayed(const Duration(seconds: 2));

      final prefs = await SharedPreferences.getInstance();
      final seenOnboarding = prefs.getBool('seenOnboarding') ?? false;
      final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

      if (!seenOnboarding) {
        emit(SplashToOnboarding()); // Show onboarding only once
      } else {
        if (isLoggedIn) {
          emit(SplashToHome());
        } else {
          emit(SplashToSignIn());
        }
      }
    });
  }
}
