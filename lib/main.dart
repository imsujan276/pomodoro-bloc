import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomodoro/src/bloc/bloc.dart';
import 'package:pomodoro/src/constants/constants.dart';
import 'package:pomodoro/src/data/models/models.dart';
import 'package:pomodoro/src/pages/splash/splash_page.dart';
import 'package:pomodoro/src/services/audio_player/audio_player_service.dart';
import 'package:pomodoro/src/services/local_notification/local_notification_service.dart';

import 'init_functions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFunctions();
  // Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SettingsBloc()..add(SettingsInitEvent()),
        ),
        BlocProvider(
          create: (context) => TimerBloc(ticker: const Ticker()),
        ),
        BlocProvider(
          create: (context) => PomodoroCubit(
            settingsBloc: context.read<SettingsBloc>(),
            timerBloc: context.read<TimerBloc>(),
            audioPlayerService: AudioPlayerService(),
            localNotificationService: LocalNotificationService(),
          )..init(),
        ),
        BlocProvider(
          create: (context) => TaskCubit()..init(),
        )
      ],
      child: MaterialApp(
        title: kAppName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(
            color: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            titleTextStyle: GoogleFonts.getFont(
              'Poppins',
              color: kWhiteColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              letterSpacing: 10,
            ),
            iconTheme: const IconThemeData(color: kWhiteColor),
          ),
        ),
        home: const SplashPage(),
      ),
    );
  }
}
