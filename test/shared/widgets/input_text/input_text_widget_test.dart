import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:payflow/shared/widgets/input_text/input_text_widget.dart';

void main() {
  testWidgets('Should fill input correctly', (WidgetTester tester) async {
    final label = "Label";
    final icon = Icons.ac_unit;
    final controller = TextEditingController();
    final onChanged = (value) {};
    final validator = (text) {};

    await tester.pumpWidget(_inputTextWidget(
      GlobalKey(),
      label,
      icon,
      onChanged,
      controller,
      validator,
    ));

    expect(find.text(label), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), "Input filled");

    expect(find.text("Input filled"), findsOneWidget);
    expect(find.byIcon(icon), findsOneWidget);
  });

  testWidgets("Should show error when input is not filled", (tester) async {
    final label = "Label";
    final mensagemDeErro = "A data de vencimento não pode ser vazio";
    final icon = Icons.ac_unit;
    final controller = TextEditingController();
    final onChanged = (value) {};
    final validator =
        (String? value) => value?.isEmpty ?? true ? mensagemDeErro : null;
    final key = GlobalKey<FormFieldState>();

    await tester.pumpWidget(
        _inputTextWidget(key, label, icon, onChanged, controller, validator));

    await tester.pump(Duration(seconds: 1));
    key.currentState?.validate();

    expect(find.text(mensagemDeErro), findsOneWidget);
  });
}

Widget _inputTextWidget(
        Key key,
        String label,
        IconData icon,
        Function(String value) onChanged,
        TextEditingController controller,
        String? Function(String?)? validator) =>
    MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(
        home: Material(
          child: InputTextWidget(
            key: key,
            label: label,
            icon: icon,
            onChanged: onChanged,
            controller: controller,
            validator: validator,
          ),
        ),
      ),
    );
