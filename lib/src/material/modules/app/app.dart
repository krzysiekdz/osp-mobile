part of 'index.dart';

class OspMaterialApp extends StatelessWidget {
  const OspMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MultiProvider(
      providers: [
        Provider<Api1Service>(
          create: (_) => DioApi1Service(),
        ),
      ],
      child: AppRegistry(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: appTitle,
          theme: lightTheme(context),
          darkTheme: darkTheme(context),
          themeMode: ThemeMode.dark,
          home: const AppScaffold(),
        ),
      ),
    );
  }
}
