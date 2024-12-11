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
          if (state.isPending) {
            return StrazakFormPending(state: state);
          } else if (state.isError) {
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

class StrazakFormPending extends StatelessWidget {
  const StrazakFormPending({super.key, required this.state});

  final AppFormState<Strazak> state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: state.isPending
                ? const Text('Pobieranie...')
                : state.isError
                    ? const Text('Edycja: Wystąpił bład')
                    : Text(
                        '${state.current!.nazwisko} ${state.current!.imie}')),
        body: Center(
          child: state.isPending
              ? const CircularProgressIndicator()
              : state.isError
                  ? Text(state.err?.msg ?? 'Wystąpił bład')
                  : Text('${state.current!.nazwisko} ${state.current!.imie}'),
        ));
  }
}

class StrazakFormError extends StatelessWidget {
  const StrazakFormError({super.key, required this.state});

  final AppFormState<Strazak> state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: state.isPending
                ? const Text('Pobieranie...')
                : state.isError
                    ? const Text('Edycja: Wystąpił bład')
                    : Text(
                        '${state.current!.nazwisko} ${state.current!.imie}')),
        body: Center(
          child: state.isPending
              ? const CircularProgressIndicator()
              : state.isError
                  ? Text(state.err?.msg ?? 'Wystąpił bład')
                  : Text('${state.current!.nazwisko} ${state.current!.imie}'),
        ));
  }
}

//po zapisie wyjscie z formularza lub wyswietlenie bledu
//wyjscie z formularza - jesli zmiany - czy na pewno?
//potem z podziałem na zakladki, mozliwoscia zapisz
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
          String label = ''}) =>
      AppTextFormField<Strazak, StrazakFormCubit>(
        initialValue: initialValue,
        label: label,
        onFormChange: onFormChange,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${c.nazwisko} ${c.imie}"),
      ),
      body: Column(
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: Form(
              key: formKey,
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
                    ),
                    space(2),
                    textForm(
                      initialValue: c.nazwisko,
                      label: 'Nazwisko',
                      onFormChange: (f, v) => f..nazwisko = v,
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
                isDisabled: !state.isDirty || state.isSaving,
                isPending: state.isSaving,
                onPressed: () async {
                  final res = await cubit.save();
                  if (res && context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
