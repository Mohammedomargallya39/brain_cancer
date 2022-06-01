import 'package:brain_cancer_detection_v1/features/login/presentaion/pages/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../core/util/constants.dart';
import '../../../../core/util/cubit/cubit.dart';
import '../../../../core/util/cubit/state.dart';
import '../../../../core/util/widgets/logo.dart';
import '../../../../core/util/widgets/my_button.dart';
import '../../../../core/util/widgets/my_drop_down_button_field.dart';
import '../../../../core/util/widgets/my_form.dart';


enum SingingCharacter { doctor, patient }

class RegisterWidget extends StatelessWidget {
  RegisterWidget({Key? key}) : super(key: key);


  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var ageController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        listener: (context, state)
        {
          if(state is RegisterSuccess)
          {
            Fluttertoast.showToast(msg: 'Register Success');
            navigateTo(context, const LoginScreen());
          }
        } ,
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
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              appTranslation(context).createUserAccount,
                              style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          space50Vertical(context),
                          MyForm(
                              label: appTranslation(context).fullName,
                              controller: nameController,
                              type: TextInputType.name,
                              error: '${appTranslation(context).pleaseEnter} ${appTranslation(context).fullName}',
                              isPassword: false
                          ),
                          space10Vertical(context),
                          MyForm(
                              label: appTranslation(context).phone,
                              controller: phoneController,
                              type: TextInputType.phone,
                              error: '${appTranslation(context).pleaseEnter} ${appTranslation(context).phone}',
                              isPassword: false
                          ),
                          space10Vertical(context),
                          MyForm(
                              label: appTranslation(context).emailAddress,
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              error: '${appTranslation(context).pleaseEnter} ${appTranslation(context).emailAddress}',
                              isPassword: false
                          ),
                          space10Vertical(context),
                          MyForm(
                              label: appTranslation(context).password,
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              error: '${appTranslation(context).pleaseEnter} ${appTranslation(context).password}',
                              isPassword: true
                          ),
                          space10Vertical(context),
                          MyForm(
                              label: appTranslation(context).confirmPassword,
                              controller: confirmPasswordController,
                              type: TextInputType.visiblePassword,
                              error: '${appTranslation(context).pleaseEnter} ${appTranslation(context).confirmPassword}  ${appTranslation(context).right}',
                              isPassword: true
                          ),
                          space10Vertical(context),
                          MyForm(
                              label: "age",
                              controller: ageController,
                              type: TextInputType.phone,
                              error: '${appTranslation(context).pleaseEnter} age ${appTranslation(context).right}',
                            isPassword: false,
                          ),
                          space20Vertical(context),
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile<SingingCharacter>(
                                    title: const Text('Patient'),
                                    activeColor: HexColor(mainColor),
                                    value: SingingCharacter.patient,
                                    groupValue: AppCubit.get(context).character,
                                    onChanged: (SingingCharacter? value)
                                    {
                                      AppCubit.get(context).changeStatus(value);
                                    }
                                ),
                              ),
                              space10Horizontal(context),
                              Expanded(
                                child: RadioListTile<SingingCharacter>(
                                    title: const Text('Doctor'),
                                    activeColor: HexColor(mainColor),
                                    value: SingingCharacter.doctor,
                                    groupValue: AppCubit.get(context).character,
                                    onChanged: (SingingCharacter? value)
                                    {
                                      AppCubit.get(context).changeStatus(value);
                                    }
                                ),
                              ),
                            ],
                          ),

                          space40Vertical(context),
                          MyButton(
                            onPressed: ()
                            {
                              if (formKey.currentState!.validate() && passwordController.text == confirmPasswordController.text)
                              {
                                debugPrint("Form is valid");
                                AppCubit.get(context).register(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  confirmPassword: confirmPasswordController.text,
                                  age: int.parse(ageController.text),
                                  isPatient: AppCubit.get(context).patient!,
                                  phone: phoneController.text,
                                  userName: nameController.text,
                                  status: AppCubit.get(context).statusLink!,
                                );
                              }
                              else
                              {
                                debugPrint("Form is invalid");
                              }
                            },
                            text: appTranslation(context).newAccount,
                          ),
                          space30Vertical(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        );
  }
}
