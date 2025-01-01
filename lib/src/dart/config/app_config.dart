part of 'index.dart';

enum AppMode { dev, prod }

class AppConfig {
  final String url;
  final String title;
  final bool showDebugInfo;
  final List<RouteName> menuConfig;
  const AppConfig(
      {this.url = '',
      this.title = '',
      this.showDebugInfo = false,
      this.menuConfig = const []});

  static AppConfig getConfig() {
    return (appMode == AppMode.prod) ? appConfigProd : appConfigDev;
  }
}
