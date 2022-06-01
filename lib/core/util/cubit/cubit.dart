import 'dart:convert';
import 'dart:io';
import 'package:brain_cancer_detection_v1/core/models/register_model.dart';
import 'package:brain_cancer_detection_v1/core/util/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../features/register/presentaion/widgets/register_widget.dart';
import '../../di/injection.dart';
import '../../models/login_model.dart';
import '../../models/select_government_model.dart';
import '../../network/local/cache_helper.dart';
import '../../network/remote/api_endpoints.dart';
import '../../network/repository.dart';
import '../constants.dart';
import '../translation.dart';

class AppCubit extends Cubit<AppState> {
  final Repository _repository;

  AppCubit({
    required Repository repository,
  })  : _repository = repository,
        super(Empty());

  static AppCubit get(context) => BlocProvider.of(context);

  late TranslationModel translationModel;

  bool isRtl = false;
  bool isRtlChange = false;
  bool isDark = false;
  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;
  late ThemeData lightTheme;
  late ThemeData darkTheme;
  late String family;

  void changeSuffix() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility: Icons.visibility_off;
    emit(UserChangeLoginSuffixState());
  }

  void setThemes({
    required bool dark,
    required bool rtl,
  }) {
    isRtl = rtl;
    isRtlChange = rtl;
    isDark = false;

    debugPrint('dark mode ------------- $isDark');

    changeTheme();

    emit(ThemeLoaded());
  }


  void changeLanguage({required bool value}) async {
    isRtl = !isRtl;

    sl<CacheHelper>().put('isRtl', isRtl);
    String translation = await rootBundle
        .loadString('assets/translations/${isRtl ? 'ar' : 'en'}.json');

    setTranslation(
      translation: translation,
    );

    emit(ChangeLanguageState());
  }

  void changeMode({required bool value}) {
    isDark = value;

    sl<CacheHelper>().put('isDark', isDark);

    emit(ChangeModeState());
  }

  void changeTheme() {
    family = isRtl ? 'Cairo' : 'Poppins';

    lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: Platform.isIOS
            ? null
            : const SystemUiOverlayStyle(
                statusBarColor: whiteColor,
                statusBarIconBrightness: Brightness.dark,
              ),
        backgroundColor: whiteColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(
          size: 20.0,
          color: Colors.black,
        ),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: family,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: whiteColor,
        elevation: 50.0,
        selectedItemColor: HexColor(mainColor),
        unselectedItemColor: Colors.grey[400],
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          height: 1.5,
        ),
      ),
      primarySwatch: MaterialColor(int.parse('0xff$mainColor'), color),
      textTheme: TextTheme(

        headline6: TextStyle(
          fontSize: pxToDp(20.0),
          fontFamily: family,
          color: HexColor(secondaryVariant),
          height: 1.4,
        ),
        bodyText1: TextStyle(
          fontSize: pxToDp(18.0),
          fontFamily: family,
          color: HexColor(secondaryVariant),
          height: 1.4,
        ),
        bodyText2: TextStyle(
          fontSize: pxToDp(16.0),
          fontFamily: family,
          color: HexColor(secondaryVariant),
          height: 1.4,
        ),
        subtitle1: TextStyle(
          fontSize: pxToDp(14.0),
          fontFamily: family,
          color: HexColor(secondaryVariant),
          height: 1.4,
        ),
        subtitle2: TextStyle(
          fontSize: pxToDp(12.0),
          fontFamily: family,
          color: HexColor(secondaryVariant),
          height: 1.4,
        ),
        caption: TextStyle(
          fontSize: pxToDp(10.0),
          fontFamily: family,
          color: HexColor(secondaryVariant),
          height: 1.4,
        ),
        overline: TextStyle(
          fontSize: pxToDp(8.0),
          fontFamily: family,
          color: HexColor(secondaryVariant),
          height: 1.4,
        ),
        button: TextStyle(
          fontSize: pxToDp(16.0),
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: whiteColor,
          height: 1.4,
        ),
      ),
    );

  }

  void setTranslation({
    required String translation,
  }) {
    translationModel = TranslationModel.fromJson(json.decode(
      translation,
    ));

    emit(LanguageLoaded());
  }

  PageController pageController = PageController();

  int currentIndex = 0;

  void bottomChanged(
    int index,
    context,
  ) {
    currentIndex = index;

    pageController.jumpToPage(
      index,
    );

    emit(BottomChanged());
  }

  //SelectGovernmentModel selectGovernment = cities[0];
//   void changeSelectGovernment({
//   required SelectGovernmentModel value,
// }){
//     selectGovernment = value;
//     emit(ChangeSelectGovernment());
//   }


  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  LoginModel? loginModel;

  void userLogin() async
  {
    emit(UserLoginLoading());

    final login = await _repository.login(
      email: emailController.text,
      password: passwordController.text,
    );

    login.fold(
            (failure)
        {
          emit(UserLoginError(
              message: failure,
          )
          );
          debugPrint(failure.toString());
        },
            (data)
          {
            loginModel = data;
             emit(UserLoginSuccess(
                 token: loginModel!.token!,
             ));

  }
    );

}

  RegisterModel? registerModel;

  void register(
  {
    required String email,
    required String password,
    required String confirmPassword,
    required int age,
    required bool isPatient,
    required String phone,
    required String userName,
    required String status,
  }
  ) async
  {
    emit(RegisterLoading());

    final register = await _repository.register(
      email: email,
      password: password,
      age: age,
      phone: phone,
      confirmPassword: confirmPassword,
      isPatient: isPatient,
      userName: userName,
      status: status
    );

    register.fold(
            (failure)
        {
          emit(RegisterError(
            message: failure,
          )
          );
          debugPrint(failure.toString());
        },
            (data)
        {

          registerModel = data;
          emit(RegisterSuccess(
            message: registerModel!.message!,
          ));

        }
    );

  }

  SingingCharacter? character = SingingCharacter.patient;
  String? statusLink;
  bool? patient;
  void changeStatus(value)
  {
    character = value;
    if(character == SingingCharacter.patient)
    {
      statusLink = patientUrl;
      patient = true;
    } else
    {
      statusLink = doctorUrl;
      patient = false;
    }
    emit(ChangeStatus());
  }



}
