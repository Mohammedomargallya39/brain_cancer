import 'package:brain_cancer_detection_v1/core/di/injection.dart';
import 'package:brain_cancer_detection_v1/core/network/local/cache_helper.dart';
import 'package:brain_cancer_detection_v1/core/network/remote/api_endpoints.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../core/util/constants.dart';
import '../../../../core/util/cubit/cubit.dart';
import '../../../../core/util/cubit/state.dart';
import '../../../../core/util/widgets/default_icon_button.dart';
import '../../../../core/util/widgets/logo.dart';
import '../../../../core/util/widgets/my_button.dart';
import '../../../../core/util/widgets/my_form.dart';
import '../../../../core/util/widgets/my_rich_text.dart';
import '../../../main/pages/main_page.dart';
import '../../../register/presentaion/pages/register_page.dart';

class LoginWidget extends StatelessWidget {
  LoginWidget({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is UserLoginError) {
          Fluttertoast.showToast(
            msg: state.message.toString(),
          );
        }

        if(state is UserLoginSuccess) {
          Fluttertoast.showToast(
            msg: 'login success',
          );
          navigateTo(context, const MainPageScreen());
          sl<CacheHelper>().put('token', state.token);
          token = state.token;
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const Expanded(
                flex: 1,
                child: Center(
                  child: AppLogo(),
                ),
              ),
              Expanded(
                flex: 2,
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appTranslation(context).userLogin,
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                        space50Vertical(context),
                        MyForm(
                          label: appTranslation(context).emailAddress,
                          controller: AppCubit.get(context).emailController,
                          type: TextInputType.emailAddress,
                          error: appTranslation(context).enterYourEmail,
                          isPassword: false,
                        ),
                        space10Vertical(context),
                        MyForm(
                          label: appTranslation(context).password,
                          controller: AppCubit.get(context).passwordController,
                          type: TextInputType.visiblePassword,
                          error: appTranslation(context).enterYourPassword,
                          isPassword: true,
                        ),
                        space40Vertical(context),
                        MyButton(
                            isLoading: state is UserLoginLoading,
                            onPressed: ()
                            {
                              if (formKey.currentState!.validate())
                              {
                                FocusScope.of(context).requestFocus(FocusNode());
                                AppCubit.get(context).userLogin();
                                debugPrint("Form is valid");
                              }
                              else
                              {
                                debugPrint("Form is invalid");
                              }
                            },
                            text: appTranslation(context).userLogin,
                        ),
                        space20Vertical(context),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyRichText(
                                text: appTranslation(context).dontHaveAccount,
                                textButton: appTranslation(context).newAccount,
                                onTap: ()
                                {
                                  navigateTo(context, const RegisterPage());
                                }
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
