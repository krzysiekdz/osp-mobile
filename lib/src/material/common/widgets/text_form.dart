part of '../index.dart';

typedef AppTextFormValidator = String? Function(String? value);

class AppTextFormField extends StatelessWidget {
  final String labelText;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final AppTextFormValidator? validator;
  final bool obscureText;
  final Widget? suffixIcon;
  const AppTextFormField(
      {super.key,
      required this.labelText,
      this.prefixIcon,
      this.controller,
      this.validator,
      this.suffixIcon,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: labelMedium(context),
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon,
      ),
      controller: controller,
      validator: validator,
    );
  }
}
