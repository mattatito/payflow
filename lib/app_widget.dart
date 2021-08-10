import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_page.dart';
import 'package:payflow/modules/insert_boleto/insert_boleto_page.dart';
import 'package:payflow/modules/login/login_page.dart';
import 'package:payflow/modules/splash/splash_page.dart';
import 'package:payflow/shared/models/user_model.dart';

import 'modules/home/home_page.dart';
import 'shared/constants/routes.dart';
import 'shared/themes/app_colors.dart';

class AppWidget extends StatelessWidget {
  AppWidget() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pay Flow',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: AppColors.primary,
      ),
      initialRoute: Routes.splash,
      routes: {
        Routes.splash: (context) => SplashPage(),
        Routes.home: (context) => HomePage(
            user: ModalRoute.of(context)!.settings.arguments as UserModel),
        Routes.login: (context) => LoginPage(),
        Routes.barcodeScanner: (context) => BarcodeScannerPage(),
        Routes.insertBoleto: (context) => InsertBoletoPage(
              barcode:
                  ModalRoute.of(context)!.settings.arguments?.toString() ?? "",
            )
      },
    );
  }
}
