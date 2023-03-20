import 'package:flutter/material.dart';
import 'package:view_page_testes/componets/personal_data_step_2.dart';
import 'package:view_page_testes/componets/personal_data_step_3.dart';

import 'componets/validator_code_step_4.dart';
import 'util/account_confirmation_send_code.dart';
import 'componets/confirm_code.dart';
import 'componets/personal_data_step_1.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageController = PageController();

  final _personalDataStepOne = GlobalKey<FormState>();
  final _personalDataStepTwo = GlobalKey<FormState>();
  final _personalDataStepTree = GlobalKey<FormState>();
  final _stepAccountConfirmation = GlobalKey<FormState>();

  late ValueNotifier<Map<String, dynamic>> _buttonAndAppBarText;

  String _name = '';
  String _email = '';
  String _cpf = '';
  String _phone = '';
  String _password = '';
  String _confirmPassword = '';
  String _validationCode = '';

  void _nextPage() {
    _pageController.nextPage(
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  void _previousPage() {
    if (_pageController.page!.toInt() > 0) {
      _pageController.previousPage(
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    }
  }

  void _handleValidateStep() {
    late GlobalKey<FormState> formKey;
    switch (_pageController.page?.toInt()) {
      case 0:
        formKey = _personalDataStepOne;
        break;
      case 1:
        formKey = _personalDataStepTwo;
        break;
      case 2:
        formKey = _personalDataStepTree;
        break;
      case 3:
        formKey = _stepAccountConfirmation;
        break;
      default:
    }
    if (formKey.currentState?.validate() ?? false) {
      _nextPage();
      FocusScope.of(context).unfocus();
    }
  }

  void _changeTextLoadingButton() {
    switch (_pageController.page?.toInt()) {
      case 0:
        _buttonAndAppBarText.value = {
          'buttonText': 'Continuar',
          'appBarText': 'Dados pessoais',
        };
        break;
      case 1:
        _buttonAndAppBarText.value = {
          'buttonText': 'Confirmar dados',
          'appBarText': 'Dados pessoais'
        };
        break;
      case 2:
        _buttonAndAppBarText.value = {
          'buttonText': 'Confirmar',
          'appBarText': 'Crie a sua senha'
        };
        break;
      case 3:
        _buttonAndAppBarText.value = {
          'buttonText': 'Concordo',
          'appBarText': 'Aceitar os termos',
          'changeNumberButton': true
        };

        break;
      case 4:
        _buttonAndAppBarText.value = {
          'buttonText': 'Confirmar código',
          'appBarText': 'Confirmação de conta',
          'changeNumberButton': true
        };
        break;
      default:
    }
  }

  @override
  void initState() {
    _buttonAndAppBarText = ValueNotifier({
      'buttonText': 'Continuar',
      'appBarText': 'Dados pessoais',
      'changeNumberButton': false
    });
    super.initState();
    _pageController.addListener(() {
      _changeTextLoadingButton();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: ValueListenableBuilder<Map<String, dynamic>>(
            builder: (context, value, _) {
              return Text(value['appBarText'] ?? '');
            },
            valueListenable: _buttonAndAppBarText,
          ),
        ),
        leading: BackButton(
          onPressed: () => _previousPage(),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              children: [
                // PersonalDataStepOne(
                //   personalDataStepOne: _personalDataStepOne,
                //   onChanged: (name, email) {
                //     _name = name;
                //     _email = email;
                //   },
                // ),
                // PersonalDataStepTwo(
                //   personalDataStepTwo: _personalDataStepTwo,
                //   onChanged: (cpf, phone) {
                //     _cpf = cpf;
                //     _phone = phone;
                //   },
                // ),
                // PersonalDataStepTree(
                //   personalDataStepTree: _personalDataStepTree,
                //   onChanged: (password, confirmPassword) {
                //     _password = password;
                //     _confirmPassword = confirmPassword;
                //   },
                // ),
                // const ValidatorCode(),
                const ConfirmCodeSent()
              ],
            ),
          ),
          ValueListenableBuilder<Map<String, dynamic>>(
            builder: (context, value, _) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(27.0),
                    child: ElevatedButton(
                      onPressed: _handleValidateStep,
                      child: SizedBox(
                        width: 200,
                        child: Center(child: Text(value['buttonText'] ?? '')),
                      ),
                    ),
                  ),
                  value['changeNumberButton'] == true
                      ? TextButton(
                          onPressed: () {}, child:const Text('Alterar número'))
                      : Container()
                ],
              );
            },
            valueListenable: _buttonAndAppBarText,
          )
        ],
      )),
    );
  }
}
