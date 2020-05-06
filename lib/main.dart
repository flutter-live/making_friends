import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:makingfriends/provider/provider_manager.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'config/application.dart';
import 'routes/page_routes.dart';
import 'viewModel/theme_v_m.dart';
import 'viewModel/user_v_m.dart';

void main() async{
  Router router = Router();
  PageRoutes.setRouters(router);
  Application.router = router;
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await Application.init();
  runApp(MyApp());
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
                  navigatorKey: Application.navigatorKey,
                  ///路由
                  onGenerateRoute: Application.router.generator,
                  localizationsDelegates: const [
                    RefreshLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate
                  ],
                  supportedLocales: [
                    const Locale('zh'),
                    const Locale('en'),
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
