import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pomodoro/src/constants/app_constants.dart';
import 'package:pomodoro/src/pages/home/home_page.dart';
import 'package:pomodoro/src/utils/helpers/helpers.dart';
import 'package:pomodoro/src/widgets/widgets.dart';

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
      const Duration(milliseconds: 1000),
      () => Navigator.pushReplacement(
          context, kRouteFade(page: const HomePage())),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 150,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/logo.png"),
              ),
            ),
          ),
          const CustomText(
            text: kAppName,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ],
      ),
    );
  }
}
