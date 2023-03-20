import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AccountConfirmationCode extends StatefulWidget {
  final ValueChanged<String> onCompleted;
  final ValueChanged<bool> onEditing;

  final int length;
  final double itemSize;

  const AccountConfirmationCode({
    Key? key,
    required this.onCompleted,
    required this.onEditing,
    this.length = 6,
    this.itemSize = 50,
  }) : super(key: key);

  @override
  _AccountConfirmationCodeState createState() =>
      _AccountConfirmationCodeState();
}

class _AccountConfirmationCodeState extends State<AccountConfirmationCode> {
  final List<FocusNode> _listFocusNode = <FocusNode>[];
  final List<FocusNode> _listFocusNodeKeyListener = <FocusNode>[];
  final List<TextEditingController> _listControllerText =
      <TextEditingController>[];

  final List<String> _code = [];
  int _currentIndex = 0;

  @override
  void initState() {
    _listFocusNode.clear();
    _listFocusNodeKeyListener.clear();
    for (var i = 0; i < widget.length; i++) {
      _listFocusNode.add(FocusNode());
      _listFocusNodeKeyListener.add(FocusNode());
      _listControllerText.add(TextEditingController());
      _code.add('');
    }
    super.initState();
  }

  @override
  void dispose() {
    for (final val in _listControllerText) {
      val.dispose();
    }
    for (final val in _listFocusNode) {
      val.dispose();
    }
    super.dispose();
  }

  String _getInputVerify() {
    String verifyCode = "";
    for (var i = 0; i < widget.length; i++) {
      for (var index = 0; index < _listControllerText[i].text.length; index++) {
        if (_listControllerText[i].text[index] != "") {
          verifyCode += _listControllerText[i].text[index];
        }
      }
    }
    return verifyCode;
  }

  Widget _buildInputItem(int index) {
    return RawKeyboardListener(
      focusNode: _listFocusNodeKeyListener[index],
      onKey: (event) {
        if (event.runtimeType == RawKeyUpEvent) {
          if (event.data.logicalKey == LogicalKeyboardKey.arrowLeft) {
            print("Entrei no if");
            _prev(index);
          } else if (event.data.logicalKey == LogicalKeyboardKey.arrowRight) {
            print("ENtrei no else if");
            _next(index);
          }
        }
      },
      child: TextFormField(
        controller: _listControllerText[index],
        focusNode: _listFocusNode[index],
        showCursor: true,
        autocorrect: false,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
        onChanged: (String value) {
          if ((_currentIndex + 1) == widget.length && value.isNotEmpty) {
            widget.onEditing(false);
          } else {
            widget.onEditing(true);
          }

          if (value.isEmpty && index >= 0) {
            _prev(index);
            return;
          }

          if (value.isNotEmpty) {
            String _value = value;
            int _index = index;

            while (_value.isNotEmpty && _index < widget.length) {
              _listControllerText[_index].value = TextEditingValue(
                text: _value[0],
                selection: TextSelection.fromPosition(
                  TextPosition(
                    affinity: TextAffinity.downstream,
                    offset: _listControllerText[_index].text.length,
                  ),
                ),
              );
              _next(_index++);
              _value = _value.substring(1);
            }

            if (_listControllerText[widget.length - 1].value.text.length == 1 &&
                _getInputVerify().length == widget.length) {
              widget.onEditing(false);
              widget.onCompleted(_getInputVerify());
            }
          }
        },
      ),
    );
  }

  void _next(int index) {
    if (index != widget.length - 1) {
      setState(() {
        _currentIndex = index + 1;
      });
      FocusScope.of(context).requestFocus(_listFocusNode[_currentIndex]);
    }
  }

  void _prev(int index) {
    if (index > 0) {
      setState(() {
        if (_listControllerText[index].text.isEmpty) {}
        _currentIndex = index - 1;
      });
      FocusScope.of(context).requestFocus(FocusNode());
      FocusScope.of(context).requestFocus(_listFocusNode[_currentIndex]);
    }
  }

  List<Widget> _buildListWidget() {
    List<Widget> listWidget = [];
    for (int index = 0; index < widget.length; index++) {
      double left = (index == 0) ? 0.0 : (widget.itemSize / 10);
      listWidget.add(Padding(
        padding: EdgeInsets.zero,
        child: Container(
            height: widget.itemSize,
            width: widget.itemSize,
            margin: EdgeInsets.only(left: left),
            child: _buildInputItem(index)),
      ));
    }
    return listWidget;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildListWidget(),
        ));
  }
}
