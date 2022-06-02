import 'package:brain_cancer_detection_v1/core/util/cubit/cubit.dart';
import 'package:brain_cancer_detection_v1/core/util/cubit/state.dart';
import 'package:brain_cancer_detection_v1/core/util/widgets/back_scaffold.dart';
import 'package:brain_cancer_detection_v1/core/util/widgets/default_text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../core/util/constants.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackScaffold(
        body: BlocBuilder<AppCubit,AppState>(
          builder: (context, state) => Padding(
            padding: EdgeInsets.symmetric(
              horizontal: responsiveValue(
                context,
                20,
              ),
              vertical: responsiveValue(
                context,
                20,
              ),
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      appTranslation(context).aboutUs,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppCubit.get(context).isDark ? whiteColor : blackColor,
                    ),

                  ),
                  space10Vertical(context),
                  Text(
                    appTranslation(context).aboutUsDescription,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppCubit.get(context).isDark ? whiteColor : blackColor,
                    ),
                  ),
                  space20Vertical(context),
                  bigDivider(context),
                  space40Vertical(context),
                  Text(
                    appTranslation(context).howToUse,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppCubit.get(context).isDark ? whiteColor : blackColor,
                    ),

                  ),
                  space10Vertical(context),
                  Text(
                    appTranslation(context).howToUseDescription,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppCubit.get(context).isDark ? whiteColor : blackColor,
                    ),
                  ),
                  space20Vertical(context),
                  bigDivider(context),
                  space40Vertical(context),
                  Text(
                    appTranslation(context).connectUs,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppCubit.get(context).isDark ? whiteColor : blackColor,
                    ),

                  ),
                  space10Vertical(context),
                  Text(
                    appTranslation(context).contactUsDescription,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppCubit.get(context).isDark ? whiteColor : blackColor,
                    ),
                  ),
                  space40Vertical(context),
                  DefaultTextButton(
                      text: 'Mohammed Ahmed',
                      fontFamily: 'Roboto',
                      onPressed: () async
                      {
                        await launchUrlString('mailto:mohammed.gallya39@gmail.com');
                      },
                      textColor: HexColor(mainColor),
                      fontSize: responsiveValue(context, 16),
                  ),
                  space10Vertical(context),
                  myDivider(context),
                  space10Vertical(context),
                  DefaultTextButton(
                    text: 'Abdulrahman Zaky',
                    fontFamily: 'Roboto',
                    onPressed: () async
                    {
                      await launchUrlString('mailto:mohammed.gallya39@gmail.com');
                    },
                    textColor: HexColor(mainColor),
                    fontSize: responsiveValue(context, 16),
                  ),
                  space10Vertical(context),
                  myDivider(context),
                  space10Vertical(context),
                  DefaultTextButton(
                    text: 'Ahmed Abd El-naby',
                    fontFamily: 'Roboto',
                    onPressed: () async
                    {
                      await launchUrlString('mailto:mohammed.gallya39@gmail.com');
                    },
                    textColor: HexColor(mainColor),
                    fontSize: responsiveValue(context, 16),
                  ),
                  space10Vertical(context),
                  myDivider(context),
                  space10Vertical(context),
                  DefaultTextButton(
                    text: 'Khaled Ashraf',
                    fontFamily: 'Roboto',
                    onPressed: () async
                    {
                      await launchUrlString('mailto:mohammed.gallya39@gmail.com');
                    },
                    textColor: HexColor(mainColor),
                    fontSize: responsiveValue(context, 16),
                  ),
                  space10Vertical(context),
                  myDivider(context),
                  space10Vertical(context),
                  DefaultTextButton(
                    text: 'Youssef',
                    fontFamily: 'Roboto',
                    onPressed: () async
                    {
                      await launchUrlString('mailto:mohammed.gallya39@gmail.com');
                    },
                    textColor: HexColor(mainColor),
                    fontSize: responsiveValue(context, 16),
                  ),

                ],
              ),
            ),
          ),
        ),
    );
  }
}
