part of 'index.dart';

enum FormType { create, edit }

//zrobic dwa formularze - jeden ktory operuje na repository (api), oraz drugi ktory tylko edytuje i zwraca obiekt;

class StrazakFormController extends StatelessWidget {
  final dynamic id;

  const StrazakFormController({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final params = OspRouteParams(
        api1service: context.watch<Api1Service>(), params: {'id': id});
    return StrazakForm(params: params);
  }
}

class StrazakForm extends StatefulWidget {
  const StrazakForm({super.key, this.params});

  final OspRouteParams? params;

  dynamic get id => params?.params?['id'] ?? 'no-id-passed';

  StrazakFormCubit createCubit() =>
      StrazakFormCubit(params!.api1service!, id: id);

  @override
  State<StrazakForm> createState() => _StrazakFormState();
}

class _StrazakFormState extends State<StrazakForm> {
  //type = create | edit - w zaleznosci, czy przekazano ID

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StrazakFormCubit>(
      create: (context) => widget.createCubit()..init(),
      child: BlocBuilder<StrazakFormCubit, AppFormState<Strazak>>(
        builder: (context, state) {
          if (state.phase == AppFormPhase.fetch) {
            return StrazakFormFetching(state: state);
          } else if (state.phase == AppFormPhase.fetchError) {
            return StrazakFormError(state: state);
          } else {
            return StrazakFormContent(state: state);
          }
        },
      ),
    );
    // return StrazakFormContent(item: Strazak({}));
  }
}

class StrazakFormFetching extends StatelessWidget {
  const StrazakFormFetching({super.key, required this.state});

  final AppFormState<Strazak> state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Wczytywanie...'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ));
  }
}

class StrazakFormError extends StatelessWidget {
  const StrazakFormError({super.key, required this.state});

  final AppFormState<Strazak> state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Wystąpił błąd')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                state.err!.msg,
                style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
              space(2),
              SizedBox(
                width: 200,
                height: 64,
                child: ElevatedButton(
                    onPressed: () {
                      context.read<StrazakFormCubit>().fetch();
                    },
                    child: const Text('Ponów')),
              )
            ],
          ),
        ));
  }
}

//odswiezenie listy

//potem więcej pól + podział na zakladki
//dodanie zdjecia do edycji
//potem prosty formularz dodawania
//potem zrobic analogicznie dla sprzet - czyli wszystko w generyczne klasy
class StrazakFormContent extends StatefulWidget {
  const StrazakFormContent({super.key, required this.state});

  final AppFormState<Strazak> state;

  @override
  State<StrazakFormContent> createState() => _StrazakFormContentState();
}

class _StrazakFormContentState extends State<StrazakFormContent> {
  Strazak get b => widget.state.buffer!;
  Strazak get c => widget.state.current!;
  Strazak get i => widget.state.initial!;

  AppFormState<Strazak> get state => widget.state;

  StrazakFormCubit get cubit => context.read<StrazakFormCubit>();

  final formKey = GlobalKey<FormState>();

  AppTextFormField<Strazak, StrazakFormCubit> textForm(
          {String initialValue = '',
          required FormChangeCallback<Strazak> onFormChange,
          AppTextFormValidator? validator,
          String label = ''}) =>
      AppTextFormField<Strazak, StrazakFormCubit>(
        initialValue: initialValue,
        label: label,
        validator: validator,
        onFormChange: onFormChange,
      );

  bool get hasNoErrors => formKey.currentState!.validate();

  Future<bool?> _showBackDialog() {
    return showDialog<bool>(
        context: context, builder: (context) => const AppFormBackDialog());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        if (!state.isDirty) {
          Navigator.pop(context);
          return;
        }
        final canPop = await _showBackDialog() ?? false;
        if (canPop && context.mounted) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("${c.nazwisko} ${c.imie}"),
        ),
        body: Column(
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(gap),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      space(),
                      textForm(
                          initialValue: c.imie,
                          label: 'Imię',
                          onFormChange: (f, v) => f..imie = v,
                          validator: notEmpty('Podaj imię')),
                      space(2),
                      textForm(
                        initialValue: c.nazwisko,
                        label: 'Nazwisko',
                        onFormChange: (f, v) => f..nazwisko = v,
                        validator: notEmpty('Podaj nazwisko'),
                      ),
                      space(),
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 0,
              child: Container(
                decoration: BoxDecoration(color: Theme.of(context).cardColor),
                padding: const EdgeInsets.all(gap),
                child: AppFilledButton(
                  textLabel: 'Zapisz',
                  isDisabled: !state.isDirty ||
                      (state.phase == AppFormPhase.dataSave) ||
                      (state.phase == AppFormPhase.dataSaveSuccess) ||
                      !hasNoErrors,
                  isPending: state.phase == AppFormPhase.dataSave,
                  onPressed: () async {
                    final res = await cubit.save();
                    if (res && context.mounted) {
                      Navigator.of(context).pop(c);
                    }
                  },
                ),
              ),
            ),
            if (state.phase == AppFormPhase.dataSaveError)
              SnackbarDisplay(
                  snackbarMsg: state.err?.msg ?? 'Wystąpił błąd',
                  snackbarType: SnackBarType.error,
                  config: const SnackBarConfig(
                      margin: EdgeInsets.only(bottom: 80),
                      behavior: SnackBarBehavior.floating)),
            if (state.phase == AppFormPhase.dataSaveSuccess)
              const SnackbarDisplay(
                snackbarMsg: 'Zapisano pomyślnie!',
                snackbarType: SnackBarType.success,
              )
          ],
        ),
      ),
    );
  }
}

class AppFormBackDialog extends StatelessWidget {
  const AppFormBackDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Czy zamknąć bez zapisywania?'),
      content: const Text(''),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text('Zamknij')),
        TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text('Nie zamykaj'))
      ],
    );
  }
}
