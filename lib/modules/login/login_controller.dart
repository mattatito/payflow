import 'package:flutter/cupertino.dart';
import 'package:payflow/modules/login/login_status.dart';
import 'package:payflow/shared/auth/auth_controller.dart';
import 'package:payflow/shared/models/user_model.dart';

import 'domain/repositories/login_repository.dart';

class LoginController {
  final LoginRepository loginRepository;
  final AuthController authController;
  final statusNotifier = ValueNotifier<LoginStatus>(LoginStatus());
  LoginStatus get status => statusNotifier.value;
  set status(LoginStatus status) => statusNotifier.value = status;

  LoginController({
    required this.loginRepository,
    required this.authController,
  });

  Future<void> googleSignIn(BuildContext context) async {
    try {
      status = LoginStatus.loading();
      final response = await loginRepository.signInGoogleUser();
      final user = UserModel(
        name: response.displayName,
        photoUrl: response.photoUrl,
      );
      status = LoginStatus.success();
      authController.setUser(context, user);
    } catch (error) {
      status = LoginStatus.error(error.toString());
      authController.setUser(context, null);
    }
  }
}
