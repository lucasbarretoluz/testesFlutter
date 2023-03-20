import 'package:flutter/material.dart';

import 'custom_singn_up_form.dart';

class PersonalDataStepTwo extends StatefulWidget {
  const PersonalDataStepTwo({
    super.key,
    required GlobalKey<FormState> personalDataStepTwo,
    this.onChanged,
  }) : _personalDataStepTwo = personalDataStepTwo;

  final GlobalKey<FormState> _personalDataStepTwo;
  final void Function(String cpf, String phone)? onChanged;

  @override
  State<PersonalDataStepTwo> createState() => _PersonalDataStepTwoState();
}

class _PersonalDataStepTwoState extends State<PersonalDataStepTwo> {
  final _cpfController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _cpfController.addListener(() {
      widget.onChanged?.call(_cpfController.text, _phoneController.text);
    });

    _phoneController.addListener(() {
      widget.onChanged?.call(_cpfController.text, _phoneController.text);
    });
  }

  @override
  void dispose() {
    _cpfController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(27.0),
      child: CustomSignUpForm(
        formKey: widget._personalDataStepTwo,
        description: 'Adicione o seu CPF e número de contato',
        textFieldsList: [
          TextFormField(
            controller: _cpfController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: '000.000.000-00',
            ),
          ),
          const SizedBox(height: 34.0),
          TextFormField(
            controller: _phoneController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: '(00) 0000-0000',
            ),
          ),
        ],
      ),
    );
  }
}
