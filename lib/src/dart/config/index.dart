library app.config;

import 'package:osp_mobile/src/dart/core/index.dart';

part 'menu.dart';

/* 
  App defaults
*/
const appMode = AppMode.prod;

const appTitle = 'OSP Pożarnik';

const kShowDebugInfo = true;

class OspAppConfig extends AppConfig {
  final String url;
  // final String url2; //np. url do innego api
  final String title;
  const OspAppConfig({this.url = '', this.title = ''});
}

const appConfigProd =
    OspAppConfig(title: appTitle, url: 'https://osp-pozar.hmcloud.pl');

const appConfigDev =
    // OspAppConfig(title: appTitle, url: 'http://localhost:8000');
    OspAppConfig(title: appTitle, url: 'http://192.168.68.108:8000');
