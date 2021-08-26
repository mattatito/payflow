import 'package:google_sign_in/google_sign_in.dart';
import 'package:payflow/modules/login/data/models/UserResponseModel.dart';
import 'package:payflow/modules/login/domain/repositories/login_repository.dart';
import 'package:payflow/modules/login/exception/user_not_found_exception.dart';

class LoginRepositoryImpl implements LoginRepository {
  @override
  Future<UserResponseModel> signInGoogleUser() async {
    final _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );

    final googleUser = await _googleSignIn.signIn();

    if (googleUser == null ||
        googleUser.photoUrl == null ||
        googleUser.displayName == null) {
      throw new UserNotFoundException("User not found. User infos are null");
    }

    return UserResponseModel(
        displayName: googleUser.displayName!, photoUrl: googleUser.photoUrl!);
  }
}
