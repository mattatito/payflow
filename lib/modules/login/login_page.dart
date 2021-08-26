import 'package:flutter/material.dart';
import 'package:payflow/modules/login/data/repositories/login_repository_impl.dart';
import 'package:payflow/modules/login/login_controller.dart';
import 'package:payflow/modules/login/login_status.dart';
import 'package:payflow/shared/auth/auth_controller.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_images.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/social_login/social_login_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = LoginController(
    loginRepository: LoginRepositoryImpl(),
    authController: AuthController(),
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Container(
              color: AppColors.primary,
              width: size.width,
              height: size.height * 0.36,
            ),
            Positioned(
              top: 40,
              left: 0,
              right: 0,
              child: Image.asset(
                AppImages.person,
                width: 208,
                height: 373,
              ),
            ),
            Positioned(
              bottom: size.height * 0.05,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AppImages.logomini),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 30,
                      left: 70,
                      right: 70,
                    ),
                    child: Text(
                      "Organize seus boletos em um só lugar",
                      style: AppTextStyles.titleHome,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 40, right: 40, top: 40),
                    child: ValueListenableBuilder<LoginStatus>(
                      valueListenable: controller.statusNotifier,
                      builder: (_, value, __) {
                        if (!value.loading) {
                          return SocialLoginButton(
                            onTap: () {
                              controller.googleSignIn(context);
                            },
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
            ValueListenableBuilder<LoginStatus>(
                valueListenable: controller.statusNotifier,
                builder: (_, value, __) {
                  if (value.error.isNotEmpty) {
                    return Container(
                      color: AppColors.delete,
                      width: size.width * 0.9,
                      height: size.height * 0.2,
                      child: Text("Ocorreu um erro: ${value.error}"),
                    );
                  }
                  return Container();
                }),
          ],
        ),
      ),
    );
  }
}
