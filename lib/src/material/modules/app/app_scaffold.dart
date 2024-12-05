part of 'index.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OspAppCubit>(
      create: (_) =>
          OspAppCubit(apiService: context.watch<Api1Service>())..init(),
      child: BlocBuilder<OspAppCubit, AppState>(
        builder: (c, state) {
          if (state is AppStateLogin) {
            return LoginView(state: state);
          } else if (state is AppStateRegister) {
            return const RegisterView();
          } else if (state is AppSession) {
            return MainRouter(
              //menuBottomConfig powinno byc w app state main - wtedy mogloby sie zmieniac, bo app state moglby sie zmieniac
              //na razie w zalozeniu był staly
              menuBottomConfig: state.menuBottomConfig,
              api1service: c.watch<Api1Service>(),
            );
          } else if (state is AppStateInitial) {
            return AppInitialLoader(
                onRetry: () {
                  c.read<OspAppCubit>().init();
                },
                state: state);
          } else {
            return const AppInitialLoader();
          }
        },
      ),
    );
  }
}

// enum AppView { login, register, main, initial }
// class AppScaffold extends StatefulWidget {
//   const AppScaffold({super.key});

//   @override
//   State<AppScaffold> createState() => _AppScaffold();
// }

// class _AppScaffold extends State<AppScaffold> {
//   AppView selectedView = AppView.login;

//   setView(AppView view) {
//     setState(() {
//       selectedView = view;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _init();
//   }

//   @override
//   void didUpdateWidget(covariant AppScaffold oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     _init();
//   }

//   _init() {}

//   @override
//   Widget build(BuildContext context) {
//     switch (selectedView) {
//       case AppView.login:
//         return const LoginWidget();
//       case AppView.register:
//         return const RegisterWidget();
//       case AppView.main:
//         return const MainScaffold(menuBottom: menuBottom);
//       default:
//         return const AppLoader();
//     }
//   }
// }
