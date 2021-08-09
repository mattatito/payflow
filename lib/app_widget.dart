import 'package:flutter/material.dart';
import 'package:payflow/modules/login/login_page.dart';
import 'package:payflow/modules/splash/splash_page.dart';

import 'modules/home/home_page.dart';
import 'shared/constants/routes.dart';
import 'shared/themes/app_colors.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pay Flow',
      theme: ThemeData(primaryColor: AppColors.primary),
      initialRoute: Routes.splash,
      routes: {
        Routes.splash: (context) => SplashPage(),
        Routes.home: (context) => HomePage(),
        Routes.login: (context) => LoginPage()
      },
    );
  }
}
