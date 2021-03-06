
import 'package:brain_cancer_detection_v1/core/util/widgets/two_options_dialog.dart';
import 'package:brain_cancer_detection_v1/features/setting/presentation/pages/profile_page.dart';
import 'package:brain_cancer_detection_v1/features/setting/presentation/widgets/setting_item.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/network/local/cache_helper.dart';
import '../../../../core/util/constants.dart';
import '../../../../core/util/cubit/cubit.dart';
import '../../../../core/util/cubit/state.dart';
import '../../../../core/util/widgets/logo.dart';
import '../../../login/presentaion/pages/login_page.dart';
import '../pages/about_us_page.dart';
import 'choose_between_two_options.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit,AppState>(
      builder: (context, state)
      {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ConditionalBuilder(
                    condition: AppCubit.get(context).profileModel != null ,
                    builder: (context) => Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: HexColor(regularGrey),
                          child: const CircleAvatar(
                            radius: 33,
                            backgroundColor: whiteColor,
                            child: AppLogo(),
                          ),
                        ),
                        space10Horizontal(context),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppCubit.get(context).profileModel!.username!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppCubit.get(context).isDark ? whiteColor : blackColor,

                                ),
                              ),
                              space3Vertical(context),
                              Text(
                                AppCubit.get(context).profileModel!.email!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.caption!.copyWith(
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    fallback: (context) => const Center(child: CircularProgressIndicator()),
                  ),
                ),
                bigDivider(context),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                            appTranslation(context).settings,
                            style: Theme.of(context).textTheme.headline6!.copyWith(
                                fontWeight: FontWeight.w700
                            ),
                        ),
                      ),
                      space3Vertical(context),
                      SettingsItem(
                        title: appTranslation(context).profile,
                        icon: Icons.person,
                        function: ()
                        {
                          navigateTo(context, const ProfilePage());
                        },
                      ),
                      space10Vertical(context),
                      SettingsItem(
                        title: appTranslation(context).mode,
                        icon: Icons.brightness_2_outlined,
                        function: ()
                        {
                          myBottomSheet(
                            context: context,
                            widget: ChooseYourOption(
                              titleFirstOption: Icons.brightness_5_outlined,
                              fullTitleFirstOption: appTranslation(context).lightMode,
                              secondTitleOption: Icons.brightness_4_outlined,
                              fullSecondTitleOption: appTranslation(context).darkMode,
                              onTapFirstOption: ()
                              {
                                AppCubit.get(context).changeMode(value: false);
                                Navigator.pop(context);
                              },
                              onTapSecondOption: ()
                              {
                                AppCubit.get(context).changeMode(value: true);
                                Navigator.pop(context);
                              },
                            ),
                          );
                        },

                        // (){}
                      ),
                      space10Vertical(context),
                      SettingsItem(
                        title: appTranslation(context).language,
                        icon: Icons.language_outlined,
                        function: ()
                        {
                          myBottomSheet(
                              context: context,
                              widget: ChooseYourOption(
                                  titleFirstOption: Icons.abc_sharp,
                                  fullTitleFirstOption: appTranslation(context).english,
                                  secondTitleOption: Icons.language_outlined,
                                  fullSecondTitleOption: appTranslation(context).arabic,
                                  onTapFirstOption: ()
                                {
                                    if (AppCubit.get(context).isRtl == false) {
                                      Navigator.pop(context);
                                    }
                                    if (AppCubit.get(context).isRtl == true) {
                                      AppCubit.get(context).changeLanguage(value: false);
                                      Navigator.pop(context);
                                    }

                                  },
                                  onTapSecondOption: ()
                                          {
                                            if (AppCubit.get(context).isRtl == true) {
                                              Navigator.pop(context);
                                            }
                                            if (AppCubit.get(context).isRtl == false) {
                                              AppCubit.get(context).changeLanguage(value: true);
                                              Navigator.pop(context);
                                            }
                                          },
                              ),
                          );
                        },
                      ),
                      space10Vertical(context),
                      SettingsItem(
                        title: appTranslation(context).aboutUs,
                        icon: Icons.info_outlined,
                        function: () {
                          navigateTo(context, const AboutUsPage());
                        }
                      ),
                      space10Vertical(context),
                      SettingsItem(
                        title: appTranslation(context).logOut,
                        icon: Icons.logout_outlined,
                        function: ()
                        {
                          showLogoutDialog(context: context,
                              function: ()
                              {
                                Fluttertoast.showToast(msg: 'Log out success');
                                signOut(context);
                                navigateAndFinish(context, const LoginScreen());
                              },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ]
          ),
        );
      },
    );
  }
}
