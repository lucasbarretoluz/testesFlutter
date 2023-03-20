import 'package:flutter/material.dart';

class CustomSignUpForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String description;
  final List<Widget> textFieldsList;
  const CustomSignUpForm({
    super.key,
    required this.formKey,
    required this.description,
    required this.textFieldsList,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 85.0),
              child: Text(description,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  )),
            ),
            Column(
              children: textFieldsList,
            )
          ],
        ),
      ),
    );
  }
}
