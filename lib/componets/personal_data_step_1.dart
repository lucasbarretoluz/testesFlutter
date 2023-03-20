import 'package:flutter/material.dart';

import 'custom_singn_up_form.dart';

class PersonalDataStepOne extends StatefulWidget {
  const PersonalDataStepOne({
    super.key,
    required GlobalKey<FormState> personalDataStepOne,
    this.onChanged,
  }) : _personalDataStepOne = personalDataStepOne;

  final GlobalKey<FormState> _personalDataStepOne;
  final void Function(String name, String email)? onChanged;

  @override
  State<PersonalDataStepOne> createState() => _PersonalDataStepOneState();
}

class _PersonalDataStepOneState extends State<PersonalDataStepOne> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _nameController.addListener(() {
      widget.onChanged?.call(_nameController.text, _emailController.text);
    });

    _emailController.addListener(() {
      widget.onChanged?.call(_nameController.text, _emailController.text);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  bool validateEmail(String email) {
    bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email);
    return !emailValid;
  }

  bool validateName(String name) {
    bool nameValid = RegExp(r'^[a-zA-Z]+ [a-zA-Z]+$').hasMatch(name);
    return !nameValid;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(27.0),
      child: CustomSignUpForm(
        formKey: widget._personalDataStepOne,
        description: 'Adicione os seus dados de identificação',
        textFieldsList: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Nome',
            ),
            // validator: (name) {
            //   if (name == null || name.isEmpty) {
            //     return 'Preencher campo nome.';
            //   }
            //   if (validateName(name)) {
            //     return 'Nome e sobrenome';
            //   }
            //   return null;
            // },
          ),
          const SizedBox(height: 34.0),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Email',
            ),
            // validator: (email) {
            //   if (validateEmail(email!)) {
            //     return 'E-mail invalido';
            //   }
            //   return null;
            // },
          ),
        ],
      ),
    );
  }
}
