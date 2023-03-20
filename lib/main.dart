import 'package:flutter/material.dart';

import 'componets/validator_code_step_4.dart';
import 'formKey/build_form.dart';
import 'formKey/form.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _formKey = GlobalKey<FormState>();

  String twoDigits(int n) => n >= 10 ? "$n" : "0$n";
  format(Duration d) => d.toString().split('.').first.padLeft(4, "0");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      // home: const FormTest(),
      // home: ContactFormItemWidget(),
        // home: const ValidatorCode(),
      // home: Scaffold(
      //   appBar: AppBar(title: const Center(child: Text("Only Testes"))),
      //   body: Column(
      //     children: [
      //       FormTest(
      //         formKey: _formKey,
      //       ),
      //       CustomButton(
      //         onPressed: () {
      //           if (_formKey.currentState?.validate() ?? false) {
      //             print("OK");
      //           } else {
      //             print("NAO OK");
      //           }
      //         },
      //         textButton: "Enviar daqui",
      //       ),
      //       // Row(
      //       //   children: [
      //       //     TweenAnimationBuilder(
      //       //       tween: Tween(begin: 3.0, end: 0.0),
      //       //       duration:  Duration(minutes: 3),
      //       //       builder: (_, dynamic value, child) {
      //       //         print(value.round());
      //       //         return Text(
      //       //          '${format(Duration(milliseconds: value.toInt()))}'
      //       //       );
      //       //       },
      //       //     )
      //       //   ],
      //       // ),
      //     ],
      //   ),
      // ),
    );
  }
}

// String sDuration = "${duration.inHours}:${duration.inMinutes.remainder(60)}:${(duration.inSeconds.remainder(60))}"; 