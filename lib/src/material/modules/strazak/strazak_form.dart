part of 'index.dart';

class StrazakFormController extends StatelessWidget {
  final dynamic id;
  final Strazak? item;
  final bool doRepoAction;
  final AppFormType formType;
  final Map<String, dynamic>? params;

  const StrazakFormController(
      {super.key,
      this.id,
      this.item,
      this.params,
      this.doRepoAction = true,
      this.formType = AppFormType.update});

  @override
  Widget build(BuildContext context) {
    final routeParams = OspRouteParams<Strazak>(
        api1service: context.watch<Api1Service>(),
        params: params ?? {},
        formParams: AppFormParams(
            doRepoAction: doRepoAction,
            id: id,
            item: item,
            formType: formType));
    return StrazakForm(routeParams: routeParams);
  }
}

class StrazakForm extends StatefulWidget {
  const StrazakForm({super.key, required this.routeParams});

  final OspRouteParams<Strazak> routeParams;

  StrazakFormCubit createCubit() {
    var fp = routeParams.formParams;
    if (fp?.formType == AppFormType.create && fp?.item == null) {
      final item = createDefaultItem(routeParams.params ?? {});
      fp = fp!.copyWith(item: item);
    }
    return StrazakFormCubit(routeParams.api1service!,
        formParams: fp!, params: routeParams.params);
  }

  Strazak createDefaultItem(Map<String, dynamic> params) {
    final type = params['type'] ?? '';
    final item = Strazak({});
    item.firstName = 'Jan ${type}';
    item.lastName = 'Kowalski';
    return item;
  }

  @override
  State<StrazakForm> createState() => _StrazakFormState();
}

class _StrazakFormState extends State<StrazakForm> {
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

  bool get isEmptyTitle => c.lastName.isEmpty && c.firstName.isEmpty;

  String get emptyTitle => 'Nowy strażak';

  @override
  void initState() {
    super.initState();
    Timer.run(() {
      formKey.currentState?.validate();
    });
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
        //nie można wyjsc z formularza podczas zapisywania
        if (state.phase == AppFormPhase.dataSave) return;

        final canPop = await _showBackDialog() ?? false;
        if (canPop && context.mounted) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: isEmptyTitle
              ? Text(emptyTitle)
              : Text("${c.lastName} ${c.firstName}"),
        ),
        body: Column(
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: Form(
                key: formKey,
                // autovalidateMode: AutovalidateMode.disabled,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(gap),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      space(),
                      textForm(
                          initialValue: c.firstName,
                          label: 'Imię',
                          onFormChange: (f, v) => f..firstName = v,
                          validator: notEmpty('Podaj imię')),
                      space(2),
                      textForm(
                        initialValue: c.lastName,
                        label: 'Nazwisko',
                        onFormChange: (f, v) => f..lastName = v,
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
                      Navigator.of(context)
                          .pop(OspRouteReturnData(doRefresh: true, data: c));
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
