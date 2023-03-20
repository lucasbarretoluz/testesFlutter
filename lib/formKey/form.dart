import 'package:flutter/material.dart';

import 'build_form.dart';

class FormTest extends StatefulWidget {
  const FormTest({super.key,
   required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;

  @override
  State<FormTest> createState() => _FormTestState();
}

class _FormTestState extends State<FormTest> {
  // final _formKey = GlobalKey<FormState>();

  void _handleValidate() {
    if (widget._formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.green,
        content: Text('Sucesso'),
        duration: Duration(seconds: 5),
      ));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text('Preencher todos codigos'),
        duration: Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BuildFormCustom(
              formKey: widget._formKey,
            ),
            CustomButton(
              onPressed: _handleValidate,
              textButton: "Enviar",
            ),
          ],
        );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.textButton,
  });
  final VoidCallback? onPressed;
  final String textButton;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(onPressed: onPressed, child: Text(textButton)),
      ],
    );
  }
}
