import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:makingfriends/provider/provider_manager.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'config/application.dart';
import 'config/global.dart';
import 'routes/page_routes.dart';
import 'view_model/theme_v_m.dart';
import 'package:flutter_screenutil/screenutil.dart';

void main() {
  Router router = Router();
  PageRoutes.setRouters(router);
  Application.router = router;

  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MultiProvider(
        providers: providers,
        child: Consumer<ThemeVM>(
            builder: (context, themeVM, child){
              return RefreshConfiguration(
                hideFooterWhenNotFull: true,
                child: MaterialApp(
                  ///主题
                  theme: themeVM.themeData(),
                  ///全局key
                  navigatorKey: navigatorKey,
                  ///路由
                  onGenerateRoute: Application.router.generator,
                  localizationsDelegates: const [
                    RefreshLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  supportedLocales: [
                    const Locale('zh'),
                  ],
                  locale: const Locale('zh'),
                  localeResolutionCallback:
                      (Locale locale, Iterable<Locale> supportedLocales) {
                    //print("change language");
                    return locale;
                  },
                ),
              );
            }
        ),
      ),
    );
  }

}
