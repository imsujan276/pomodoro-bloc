import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pomodoro/src/pages/home/home_page.dart';
import 'package:pomodoro/src/utils/helpers/helpers.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(milliseconds: 500),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return const Scaffold();
  }
}
