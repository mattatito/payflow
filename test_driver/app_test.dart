import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

main() {
  group('PayFlow app', () {
    // For integration tests, you can use Keys in components to identify
    //with more precision what u need. Then you can use find.byValueKey
    // Example: final xptoImage = find.byValueKey('image');
    final finderGoogleSignInButton = find.byValueKey('google_signin_button');

    late FlutterDriver driver;

    // Need to connect with the driver before running any test
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Function called after all tests runs
    tearDownAll(() async {
      driver.close();
    });

    test(
        'Given not logged user When app launchs Then login screen is displayed',
        () async {
      await Future.delayed(Duration(seconds: 5));
      expect(
          await driver.getText(finderGoogleSignInButton), 'Entrar com Google');
    });
  });
}
