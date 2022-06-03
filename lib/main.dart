import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'core/di/injection.dart' as di;
import 'core/di/injection.dart';
import 'core/network/local/cache_helper.dart';
import 'core/network/remote/api_endpoints.dart';
import 'core/util/bloc_observer.dart';
import 'core/util/constants.dart';
import 'core/util/cubit/cubit.dart';
import 'core/util/cubit/state.dart';
import 'features/login/presentaion/pages/login_page.dart';
import 'features/main/pages/main_page.dart';
import 'features/no connection/presentation/pages/no_connection.dart';
import 'features/setting/presentation/pages/settings_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();


  await di.init();


  bool isRtl = false;

  await sl<CacheHelper>().get('isRtl').then((value) {
    debugPrint('trl ------------- $value');
    if (value != null) {
      isRtl = value;
    }
  });

  bool isDark = false;


  await sl<CacheHelper>().get('isDark').then((value) {
    debugPrint('dark mode in cubit is------------- $value');
    if (value != null) {
      isDark = value;
    }
  });

  String translation = await rootBundle
      .loadString('assets/translations/${isRtl ? 'ar' : 'en'}.json');

  token = await sl<CacheHelper>().get('token');
  userName = await sl<CacheHelper>().get('userName');
  isPatient = await sl<CacheHelper>().get('isPatient');



  debugPrintFullText('My Current Token => $token');
  debugPrintFullText('My User Name => $userName');
  debugPrintFullText('Is Patient => $isPatient');


  Widget? widget;
  if (token != null) {
    widget = const MainPageScreen();
  } else {
    widget = const LoginScreen();
  }



  // if no internet show toast that no internet
  // if (await sl<CacheHelper>().isConnected()) {
  //   widget = token != null ? const MainPageScreen() :const LoginScreen();
  // } else {
  //   widget = const NoInternetScreen();
  // }

  // if(await sl<CacheHelper>().isConnected())
  // {
  //   widget = token != null ? const MainPageScreen() :const LoginScreen();
  // } else {
  //   widget = const NoInternetScreen();
  // }
  //

  runApp(MyApp(
    userName: userName ?? '',
    isPatient: isPatient ?? true,
    token: token,
    isRtl: isRtl,
    isDark: isDark,
    translation: translation,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  String? token;
  final bool isRtl;
  final bool isDark;
  final String translation;
  final String userName;
  final bool isPatient;
  final Widget startWidget;


  MyApp({
    Key? key,
    required this.token,
    required this.isRtl,
    required this.isDark,
    required this.translation,
    required this.userName,
    required this.isPatient,
    required this.startWidget,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => sl<AppCubit>()
            ..setThemes(
              dark: isDark,
              rtl: isRtl,
            )..setTranslation(
              translation: translation,
            )..profile(
                profileUrl: isPatient? profilePatientUrl: profileDoctorUrl,
            ),
        ),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {

          DataConnectionChecker().onStatusChange.listen((status)
          {
            if (status == DataConnectionStatus.disconnected) {
              debugPrint('No internet connection');
            } else {
              debugPrint('Internet connection is available');
            }
            isConnection = status;
            debugPrint('data Connection ${isConnection.toString()}');
          });

          return MaterialApp(
            title: 'Brain Cancer',
            debugShowCheckedModeBanner: false,
            themeMode: AppCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            theme: AppCubit.get(context).lightTheme,
            darkTheme: AppCubit.get(context).darkTheme,
            home:  AnimatedSplashScreen(
              splashIconSize: 200,
                splash: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/logo.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                nextScreen: isConnection == DataConnectionStatus.disconnected? const NoConnectionPage() : startWidget,
                duration: 1000,
                //splashTransition: SplashTransition.scaleTransition,
                backgroundColor: whiteColor,
                curve: Curves.bounceOut,

            ),
          );
        },
      ),
    );
  }
}
