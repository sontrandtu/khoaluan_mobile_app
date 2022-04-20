import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khoaluan_mobile_app/utils/extensions/context_extension.dart';
import 'package:khoaluan_mobile_app/utils/extensions/text_styles_extension.dart';

import '../../res.dart';
import '../../theme/color.dart';

class CustomInputField extends StatefulWidget {
  final String? label;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Function(String)? afterLostFocusChange;
  final FocusNode? focusNode;
  final String? value;
  final bool? enabled;
  final bool? readOnly;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? autoFocus;
  final int? maxLength;
  final String? suffixText;
  final List<TextInputFormatter>? formatters;
  final Widget? labelWidget;

  const CustomInputField({
    Key? key,
    this.label,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.focusNode,
    this.value,
    this.afterLostFocusChange,
    this.suffixIcon,
    this.autoFocus,
    this.formatters,
    this.prefixIcon,
    this.suffixText,
    this.enabled = true,
    this.readOnly = false,
    this.maxLength,
    this.labelWidget,
  }) : super(key: key);

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  TextEditingController textEditingController = TextEditingController();
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      textEditingController.text = widget.value ?? '';
    });
  }

  @override
  void didUpdateWidget(covariant CustomInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (oldWidget.value != widget.value) {
        textEditingController.text = widget.value ?? '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enabled,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(8)),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(8)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(8)),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(8)),
        prefixIcon: widget.prefixIcon,
        suffixIconConstraints: const BoxConstraints(maxHeight: 32),
        suffixIcon: widget.obscureText
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SvgPicture.asset(
                    _obscureText ? Res.iconEyeClosed : Res.iconEye,
                    color: Colors.black45,
                    height: _obscureText ? 22 : 14,
                  ),
                ),
              )
            : widget.suffixIcon ?? const SizedBox(),
        counterText: '',
        hintStyle: const TextStyle(height: 3.0),
        labelStyle: TextStyle(
            color: Colors.black.withOpacity(0.4),
            backgroundColor: Colors.transparent,
            height: 4,
            fontFamily: 'Roboto',
            fontSize: 14),
        labelText: widget.label,
        label: widget.labelWidget,
        isDense: true,
        alignLabelWithHint: true,
        suffixText: widget.suffixText,
        suffixStyle: context.textStyle(color: Colors.red).fontRoboto.size14,
        filled: true,
        fillColor:
            widget.enabled! ? Colors.white : Colors.grey.withOpacity(0.1),
      ),
      textAlign: TextAlign.start,
      readOnly: widget.readOnly ?? false,
      inputFormatters: widget.formatters,
      controller: textEditingController,
      obscureText: _obscureText,
      autofocus: widget.autoFocus ?? false,
      focusNode: widget.focusNode,
      maxLength: widget.maxLength,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      style: Theme.of(context).textTheme.bodyText1?.copyWith(
          color: widget.enabled! ? AppColors.textBlack : Colors.black45,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: 'Roboto'),
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: widget.onChanged,
    );
  }
}
