library app.config;

part 'route_name.dart';
part 'app_config.dart';

const appMode = AppMode.dev;

const appTitle = 'OSP Pożarnik';

const List<RouteName> aMenuBottomConfig = [
  RouteName.dashboard,
  RouteName.fireman,
  RouteName.equipment,
];

const aConnTimeout = 10; //10 seconds connection timeout

const urlProd = 'https://osp-pozar.hmcloud.pl';
const urlDev = 'http://192.168.68.110:8000';
// const urlDev = 'http://192.168.1.104:8000';

const appConfigProd =
    AppConfig(title: appTitle, url: urlProd, menuConfig: aMenuBottomConfig);

const appConfigDev = AppConfig(
    title: appTitle,
    url: urlDev,
    showDebugInfo: true,
    menuConfig: aMenuBottomConfig);
