part of '../index.dart';

class AppPasswordFormField extends StatefulWidget {
  final TextEditingController? controller;
  final AppTextFormValidator? validator;
  const AppPasswordFormField({super.key, this.controller, this.validator});

  @override
  State<StatefulWidget> createState() => _AppPasswordFormField();
}

class _AppPasswordFormField extends State<AppPasswordFormField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
        labelText: 'Hasło',
        obscureText: obscureText,
        prefixIcon: Icons.lock,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: IconButton(
              onPressed: changeObscured,
              icon:
                  Icon(obscureText ? Icons.visibility : Icons.visibility_off)),
        ),
        controller: widget.controller,
        validator: widget.validator);
  }

  void changeObscured() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
