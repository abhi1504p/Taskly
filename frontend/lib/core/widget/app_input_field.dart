import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppInputField extends StatelessWidget {
  final String? hint;
  final String? labeltext;
  final String? Function(String?)? validate;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool isDropdown;
  final List<String>? dropdownItems;
  final String? value;
  final TextEditingController? controller;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final bool? obscureTexts;



  const AppInputField({
    this.hint,
    this.labeltext,
    this.onChanged,
    this.keyboardType,
    this.isDropdown = false,
    this.dropdownItems,
    this.value,
    this.controller,
    this.maxLength,
    this.inputFormatters,
    this.obscureTexts,
    this.validate,

    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        validator:validate ,
        obscureText: obscureTexts!,
        controller: controller,
        onChanged: onChanged,
        keyboardType: keyboardType,
        maxLength: maxLength,
        inputFormatters: inputFormatters,
        style: const TextStyle(fontSize: 16, color: Color(0xFF212B36)),
        decoration: InputDecoration(
          labelText: labeltext,

          labelStyle: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2),
          ) ,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2,color: Colors.red),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 18,
          ),

          counterText: '',
        ),
      ),
    );
  }
}
