import 'package:flutter/material.dart';

import 'form.dart';

class BuildFormCustom extends StatefulWidget {
  const BuildFormCustom({
    super.key,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;

  @override
  State<BuildFormCustom> createState() => _BuildFormCustomState();
}

class _BuildFormCustomState extends State<BuildFormCustom> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  bool validateName(String name) {
    bool nameValid = RegExp(r'^[a-zA-Z]+ [a-zA-Z]+$').hasMatch(name);
    return !nameValid;
  }

  void _handleValidate() {
    if (widget._formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.green,
        content: Text('Sucesso'),
        duration: Duration(seconds: 5),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text('Falha'),
        duration: Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._formKey,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                border: OutlineInputBorder(),
                hintText: "Enter Name",
                labelText: "Name",
              ),
              validator: (name) {
                if (name == null || name.isEmpty) {
                  return 'Preencher campo nome.';
                }
                if (validateName(name)) {
                  return 'Nome e sobrenome';
                }
                return null;
              },
            ),
            const SizedBox(height: 25),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                border: OutlineInputBorder(),
                hintText: "Enter Email",
                labelText: "Email",
              ),
              validator: (email) {
                if (email == null || email.isEmpty) {
                  return 'Preencher campo Email.';
                }
                return null;
              },
            ),
            const SizedBox(height: 25),
            CustomButton(
              onPressed: _handleValidate,
              textButton: "Enviar",
            ),
          ],
        ),
      ),
    );
  }
}
