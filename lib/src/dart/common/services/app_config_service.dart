part of '../index.dart';

class AppConfigService {
  static OspAppConfig getConfig() {
    return (appMode == AppMode.prod) ? appConfigProd : appConfigDev;
  }
}
