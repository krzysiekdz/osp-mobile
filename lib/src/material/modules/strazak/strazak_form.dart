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
                    : Text('${state.item!.nazwisko} ${state.item!.imie}')),
        body: Center(
          child: state.isPending
              ? const CircularProgressIndicator()
              : state.isError
                  ? Text(state.err?.msg ?? 'Wystąpił bład')
                  : Text('${state.item!.nazwisko} ${state.item!.imie}'),
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
                    : Text('${state.item!.nazwisko} ${state.item!.imie}')),
        body: Center(
          child: state.isPending
              ? const CircularProgressIndicator()
              : state.isError
                  ? Text(state.err?.msg ?? 'Wystąpił bład')
                  : Text('${state.item!.nazwisko} ${state.item!.imie}'),
        ));
  }
}

// pierwsza rzecz, to zrobic prosty formularz dla danego konkretnego typu, aby potem sie nie pogubic na typach generycznych
//zrobic prosty formularz z podziałem na zakladki, mozliwoscia zapisz potem prosty formularz dodawania
//potem zrobic analogicznie dla sprzet - czyli wszystko w generyczne klasy
class StrazakFormContent extends StatefulWidget {
  const StrazakFormContent({super.key, required this.state});

  final AppFormState<Strazak> state;

  @override
  State<StrazakFormContent> createState() => _StrazakFormContentState();
}

class _StrazakFormContentState extends State<StrazakFormContent> {
  Strazak get item => widget.state.item!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${item.nazwisko} ${item.imie}"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text("${item.nazwisko} ${item.imie}"),
            ],
          ),
        ));
  }
}
