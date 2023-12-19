import 'package:authorization/core/consts/color_constants.dart';
import 'package:flutter/material.dart';

class SettingsTextField extends StatefulWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String placeHolder;

  const SettingsTextField({
    Key? key,
    required this.controller,
    this.obscureText = false,
    required this.placeHolder,
  }) : super(key: key);

  @override
  _SettingsTextFieldState createState() => _SettingsTextFieldState();
}

class _SettingsTextFieldState extends State<SettingsTextField> {
  final focusNode = FocusNode();
  bool stateObscureText = false;

  @override
  void initState() {
    super.initState();

    stateObscureText = widget.obscureText;
  }

  @override
  void didUpdateWidget(covariant SettingsTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    stateObscureText = widget.obscureText;
  }

  void _togglePasswordView() {
    setState(() {
      stateObscureText = !stateObscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _createSettingsTextField(),
        ],
      ),
    );
  }

  Widget _createSettingsTextField() {
    return TextField(
      focusNode: focusNode,
      controller: widget.controller,
      obscureText: stateObscureText,
      style: const TextStyle(fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        hintText: widget.placeHolder,
        hintStyle: const TextStyle(color: ColorConstants.grey, fontSize: 16),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        suffix: widget.obscureText
            ? InkWell(
                onTap: _togglePasswordView,
                child: Icon(
                  stateObscureText ? Icons.visibility_off : Icons.visibility,
                  color: widget.controller.text.isNotEmpty
                      ? ColorConstants.primaryColor
                      : ColorConstants.grey,
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
