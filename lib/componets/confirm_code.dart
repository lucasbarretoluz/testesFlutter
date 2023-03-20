import 'package:flutter/material.dart';

import 'package:view_page_testes/componets/validate_code.dart';

class ConfirmCodeSent extends StatefulWidget {
  const ConfirmCodeSent({super.key, this.onChanged});

  final void Function(String code)? onChanged;
  @override
  State<ConfirmCodeSent> createState() => _ConfirmCodeSentState();
}

class _ConfirmCodeSentState extends State<ConfirmCodeSent> {
  bool _onEditing = true;
  String? _code;

  @override
  // void initState() {
  //   _code.addListener(() {
  //     widget.onChanged
  //         ?.call(_code!);
  //   });
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AccountConfirmationCode(
          itemSize: 50,
          onCompleted: (String value) {
            setState(() {
              _code = value;
            });
            print("Codigo: $_code");
          },
          onEditing: (bool value) {
            setState(() {
              _onEditing = value;
            });
            if (!_onEditing) FocusScope.of(context).unfocus();
          },
        ),
      ],
    );
  }
}
