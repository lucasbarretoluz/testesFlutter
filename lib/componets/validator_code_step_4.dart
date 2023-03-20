import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:view_page_testes/componets/custom_singn_up_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ValidatorCode extends StatefulWidget {
  const ValidatorCode({super.key});

  @override
  State<ValidatorCode> createState() => _ValidatorCodeState();
}

class _ValidatorCodeState extends State<ValidatorCode> {
  final _slotOneController = TextEditingController();
  final _slotTwoController = TextEditingController();
  final _slotTreeController = TextEditingController();
  final _slotFourController = TextEditingController();
  final _slotFiveController = TextEditingController();
  final _slotSixController = TextEditingController();

  final _slotOneFocusNode = FocusNode();
  final _slotTwoFocusNode = FocusNode();
  final _slotTreeFocusNode = FocusNode();
  final _slotFourFocusNode = FocusNode();
  final _slotFiveFocusNode = FocusNode();
  final _slotSixFocusNode = FocusNode();

  final _listFocusNodeKeyOneListener = FocusNode();
  final _listFocusNodeKeyTwoListener = FocusNode();
  final _listFocusNodeKeyTreeListener = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _slotOneController.addListener(() {
      if (_slotOneController.text.length == 1) {
        _slotTwoFocusNode.requestFocus();
      }
    });

    _slotTwoController.addListener(() {
      if (_slotTwoController.text.length == 1) {
        _slotTreeFocusNode.requestFocus();
      }
    });

    _slotTreeController.addListener(() {
      if (_slotTreeController.text.length == 1) {
        _slotFourFocusNode.requestFocus();
      }
    });

    _slotFourController.addListener(() {
      if (_slotFourController.text.length == 1) {
        _slotFiveFocusNode.requestFocus();
      }
    });

    _slotFiveController.addListener(() {
      if (_slotFiveController.text.length == 1) {
        _slotSixFocusNode.requestFocus();
      }
    });

    _slotSixController.addListener(() {
      if (_slotSixController.text.length == 1) {
        _slotSixFocusNode.unfocus();
      }
    });
  }

  @override
  void dispose() {
    _slotOneController.dispose();
    _slotTwoController.dispose();
    _slotTreeController.dispose();
    _slotFourController.dispose();
    _slotFiveController.dispose();
    _slotSixController.dispose();

    _slotOneFocusNode.dispose();
    _slotTwoFocusNode.dispose();
    _slotTreeFocusNode.dispose();
    _slotFourFocusNode.dispose();
    _slotFiveFocusNode.dispose();
    _slotSixFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations local = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmação de conta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(27.0),
        child: Column(
          children: [
            const Text("Apenas uns testes"),
            Container(
              color: Colors.amber,
              height: 50,
            ),
            Form(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _slotOneController,
                    focusNode: _slotOneFocusNode,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                    ],
                    onChanged: (value) {},
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: RawKeyboardListener(
                    focusNode: _listFocusNodeKeyTwoListener,
                    onKey: ((value) {
                      if (value.runtimeType == RawKeyUpEvent) {
                        if (value.data.logicalKey ==
                            LogicalKeyboardKey.arrowLeft) {
                              
                              print("Entrei no if");
                        } else if (value.data.logicalKey ==
                            LogicalKeyboardKey.arrowRight) {
                              print("ENtrei no else if");
                            }
                      }
                    }),
                    child: TextFormField(
                      controller: _slotTwoController,
                      focusNode: _slotTwoFocusNode,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                      ],
                      onChanged: (value) {
                        if (value.isEmpty) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          FocusScope.of(context)
                              .requestFocus(_slotOneFocusNode);
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: TextFormField(
                    controller: _slotTreeController,
                    focusNode: _slotTreeFocusNode,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                    ],
                    onChanged: (value) {
                      if (value.isEmpty) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        FocusScope.of(context).requestFocus(_slotTwoFocusNode);
                      }
                    },

                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: TextFormField(
                    controller: _slotFourController,
                    focusNode: _slotFourFocusNode,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                    ],
                    onChanged: (value) {
                      if (value.isEmpty) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        FocusScope.of(context).requestFocus(_slotTreeFocusNode);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: TextFormField(
                    controller: _slotFiveController,
                    focusNode: _slotFiveFocusNode,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                    ],
                    onChanged: (value) {
                      if (value.isEmpty) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        FocusScope.of(context).requestFocus(_slotFourFocusNode);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: TextFormField(
                    controller: _slotSixController,
                    focusNode: _slotSixFocusNode,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                    ],
                    onChanged: (value) {
                      if (value.isEmpty) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        FocusScope.of(context).requestFocus(_slotFiveFocusNode);
                      }
                    },
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
