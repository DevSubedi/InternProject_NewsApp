import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

import 'package:news_app/core/di/injection.dart';
import 'package:news_app/core/di/service_locator.dart';
import 'package:news_app/core/localization/bloc/localization_bloc.dart';
import 'package:news_app/core/routing/app_router.dart';
import 'package:news_app/features/home/data/models/news_model.dart';
import 'package:news_app/features/home/presentation/bloc/news_bloc.dart';
import 'package:news_app/l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //hive part
  await Hive.initFlutter();
  //for rememberme in login
  var box = await Hive.openBox('authBox');
  // Register Adapter for favorite news
  Hive.registerAdapter(NewsModelAdapter());
  // Open Box for favorite news
  await Hive.openBox<NewsModel>('favoriteNewsBox');

  // For Android webview initialization
  WebViewPlatform.instance = AndroidWebViewPlatform();

  //env files
  await dotenv.load(fileName: '.env');

  setupLocator();
  configureDependencies();
  await Firebase.initializeApp();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocalizationBloc()),
        BlocProvider(
          create: (context) => NewsBloc()
            ..add(FetchAllNewsEvent())
            ..add(SelectCategoryEvent(selectedCategoryEvent: 'All')),
        ),
      ],
      child: MyApp(authBox: box),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Box authBox;
  const MyApp({super.key, required this.authBox});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationBloc, LocalizationState>(
      builder: (context, state) {
        return ScreenUtilInit(
          designSize: const Size(428, 926),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, __) => MaterialApp.router(
            title: "News App",

            //routing
            routerConfig: appRouter,

            //localization
            locale: state.locale,
            supportedLocales: const [Locale('en'), Locale('ne')],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}
