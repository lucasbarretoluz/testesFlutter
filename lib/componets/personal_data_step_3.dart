import 'package:flutter/material.dart';

import 'custom_singn_up_form.dart';

class PersonalDataStepTree extends StatefulWidget {
  const PersonalDataStepTree({
    super.key,
    required GlobalKey<FormState> personalDataStepTree,
    this.onChanged,
  }) : _personalDataStepTree = personalDataStepTree;

  final GlobalKey<FormState> _personalDataStepTree;
  final void Function(String password, String confirmPassword)? onChanged;

  @override
  State<PersonalDataStepTree> createState() => _PersonalDataStepTreeState();
}

class _PersonalDataStepTreeState extends State<PersonalDataStepTree> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _passwordVisible = false;
  bool _invisible = true;
  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      widget.onChanged
          ?.call(_passwordController.text, _confirmPasswordController.text);
    });

    _confirmPasswordController.addListener(() {
      widget.onChanged
          ?.call(_passwordController.text, _confirmPasswordController.text);
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void inContact(TapDownDetails details) {
    setState(() {
      _invisible = false;
    });
  }

  void outContact(TapUpDetails details) {
    setState(() {
      _invisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(27.0),
      child: CustomSignUpForm(
        formKey: widget._personalDataStepTree,
        description: 'Crie uma senha de 8 digitos e confirme-a novamente.',
        textFieldsList: [
          TextFormField(
            controller: _passwordController,
            obscureText: !_passwordVisible,
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Senha',
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                    icon: Icon(_passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off))),
            // validator: (password) {
            //   if (password!.length < 6) {
            //     return 'Sua senha deve possuir mais de 6 digitos';
            //   }
            //   return null;
            // },
          ),
          const SizedBox(height: 34.0),
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: _invisible,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: 'Confirma senha',
              suffixIcon: GestureDetector(
                onTapDown: inContact,
                onTapUp: outContact,
                child: const Icon(
                  Icons.remove_red_eye,
                ),
              ),
            ),
            // validator: (password) {
            //   if (password!.isEmpty) {
            //     return 'Confirme sua senha';
            //   }
            //   if (password != _passwordController.text) {
            //     return 'As senhas devem ser iguais.';
            //   }
            //   return null;
            // },
          ),
        ],
      ),
    );
  }
}
