import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:view_page_testes/util/verification_code.dart';

class AccountConfirmation extends StatefulWidget {
  const AccountConfirmation({super.key});

  @override
  State<AccountConfirmation> createState() => _AccountConfirmationState();
}

class _AccountConfirmationState extends State<AccountConfirmation> {
  void _nextAndPreviousField(String value, bool first, bool last) {
    if (value.length == 1 && last == false) {
      FocusScope.of(context).nextFocus();
    }
    if (value.isEmpty && first == false) {
      FocusScope.of(context).previousFocus();
    }
  }

  String valueFinalCode = '';
  bool _onEditing = true;
  String? _code;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              'Enter your code',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ),
        VerificationCode(
          textStyle: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: Theme.of(context).primaryColor),
          keyboardType: TextInputType.number,
          underlineColor: Colors.amber,
          length: 3,
          cursorColor: Colors.blue,
          clearAll: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'clear all',
              style: TextStyle(
                  fontSize: 14.0,
                  decoration: TextDecoration.underline,
                  color: Colors.blue[700]),
            ),
          ),
          margin: const EdgeInsets.all(12),
          onCompleted: (String value) {
            setState(() {
              _code = value;
            });
          },
          onEditing: (bool value) {
            setState(() {
              _onEditing = value;
            });
            if (!_onEditing) FocusScope.of(context).unfocus();
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: _onEditing
                ? const Text('Please enter full code')
                : Text('Your code: $_code'),
          ),
        )
      ],
    );

    // return Form(
    //   child: Padding(
    //     padding: const EdgeInsets.only(right: 5.0, left: 5.0),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         _individualFieldConfirmCode(true, false),
    //         _individualFieldConfirmCode(false, false),
    //         _individualFieldConfirmCode(false, false),
    //         _individualFieldConfirmCode(false, false),
    //         _individualFieldConfirmCode(false, false),
    //         _individualFieldConfirmCode(false, true),
    //       ],
    //     ),
    //   ),
    // );
  }

  _individualFieldConfirmCode(bool first, last) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 2.5, right: 2.5),
        child: TextFormField(
          style: Theme.of(context).textTheme.headline6,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly,
          ],
          onChanged: (value) {
            print('Valor final: $valueFinalCode');
            if (value.length == 1 && last == false) {
              valueFinalCode += value;
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && first == false) {
              //  valueFinalCode.remove();
              FocusScope.of(context).previousFocus();
            }
          },
        ),
      ),
    );
  }
}

