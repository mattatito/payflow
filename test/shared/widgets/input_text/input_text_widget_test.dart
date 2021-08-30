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
    final key = GlobalKey<FormState>();
    final errorMessageFinder = find.text(mensagemDeErro);
    final labelFinder = find.text(label);
    final testedWidget =
        _inputTextWidget(key, label, icon, onChanged, controller, validator);

    await tester.pumpWidget(testedWidget);
    key.currentState?.validate();
    await tester.pumpAndSettle();

    expect(labelFinder, findsOneWidget);
    expect(errorMessageFinder, findsOneWidget);
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
          child: Form(
            key: key,
            child: InputTextWidget(
              label: label,
              icon: icon,
              onChanged: onChanged,
              controller: controller,
              validator: validator,
            ),
          ),
        ),
      ),
    );
