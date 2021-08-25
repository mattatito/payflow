import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:payflow/modules/splash/splash_page.dart';
import 'package:mockito/mockito.dart';
import 'package:payflow/shared/auth/auth_controller.dart';
import 'package:payflow/shared/themes/app_images.dart';

import 'splash_page_test.mocks.dart';

@GenerateMocks([AuthController])
void main() {
  var mockController = MockAuthController();

  ///Test not running
  ///
  testWidgets("Verify if screen has two images", (WidgetTester tester) async {
    var expectedImage = AppImages.logomini;

    when(mockController.currentUser(any))
        .thenAnswer((realInvocation) => Future.value());

    tester.pumpWidget(MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(
        home: SplashPage(
          controller: mockController,
        ),
      ),
    ));

    final image = find.byType(Image).evaluate().single.widget as Image;

    expect(image, findsOneWidget);
  });

  testWidgets("Teste", (tester) async {});
}
