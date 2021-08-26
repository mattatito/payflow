import 'package:payflow/modules/login/data/models/UserResponseModel.dart';
import 'package:payflow/shared/models/user_model.dart';

abstract class LoginRepository {
  Future<UserResponseModel> signInGoogleUser();
}
