import 'package:flutter_driver/driver_extension.dart';
import 'package:payflow/main.dart' as app;

main(List<String> args) {
  // Enables the Flutter Driver extension
  enableFlutterDriverExtension();

  //Calling the main function of PayFlow
  app.main();
}
