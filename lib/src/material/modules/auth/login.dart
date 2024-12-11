part of 'index.dart';

class LoginView extends StatefulWidget {
  final AppStateLogin state;
  const LoginView({super.key, required this.state});

  @override
  State<LoginView> createState() => _LoginState();
}

class _LoginState extends State<LoginView> {
  final cEmail = TextEditingController();
  final cPassword = TextEditingController();
  final _form = GlobalKey<FormState>();
  bool _formDirty = false;

  @override
  void dispose() {
    cEmail.dispose();
    cPassword.dispose();
    super.dispose();
  }

  String? validatePassword(value) {
    if (value == null || value.isEmpty) {
      return 'Podaj hasło';
    }
    if (value.length < 6) {
      return 'Hasło musi zawierać co najmniej 6 znaków';
    }
    return null;
  }

  void submitForm() {
    if (_form.currentState!.validate()) {
      context.read<OspAppCubit>().login(cEmail.text, cPassword.text);
    } else {
      if (_formDirty) {
        MatUtils.showSnackBar(
            context, 'Wpisz poprawnie email i hasło', SnackBarType.error);
      }
    }

    if (_formDirty) return;
    setState(() {
      _formDirty = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppImgBg(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // AppLogo(width: 120),
                    // SizedBox(
                    //   height: 8,
                    //   width: 8,
                    // ),
                    AppTitle(fontSize: 28),
                  ],
                ),
                const SizedBox(height: 32),
                Form(
                  key: _form,
                  autovalidateMode: _formDirty
                      ? AutovalidateMode.always
                      : AutovalidateMode.disabled,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Logowanie', style: displaySmall(context)),
                        const SizedBox(height: 32),
                        SimpleTextFormField(
                          labelText: 'Email',
                          prefixIcon: Icons.email,
                          controller: cEmail,
                          validator: validateEmail,
                        ),
                        const SizedBox(height: 24),
                        AppPasswordFormField(
                            controller: cPassword, validator: validatePassword),
                        const SizedBox(height: 32),
                        AppFilledButton(
                          onPressed: widget.state.isPending ? null : submitForm,
                          textLabel: 'Zaloguj się',
                          isPending: widget.state.isPending,
                        ),
                      ]),
                ),
                SnackbarDisplay(
                  snackbarMsg: widget.state.message,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
