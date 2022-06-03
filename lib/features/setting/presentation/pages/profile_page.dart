import 'package:brain_cancer_detection_v1/core/util/constants.dart';
import 'package:brain_cancer_detection_v1/core/util/cubit/cubit.dart';
import 'package:brain_cancer_detection_v1/core/util/widgets/back_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackScaffold(
        body: Padding(
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
                Center(
                  child: CircleAvatar(
                    radius: responsiveValue(context, 150),
                    backgroundImage: const AssetImage(
                        'assets/images/logo.png'
                    ),
                  ),
                ),
                space20Vertical(context),
                bigDivider(context),
                space20Vertical(context),
                Text(
                  '${appTranslation(context).userName}: ${AppCubit.get(context).profileModel!.username}',
                  style: Theme.of(context).textTheme.caption!.copyWith(
                    fontSize: responsiveValue(context, 16),
                    fontWeight: FontWeight.w700,
                    color: AppCubit.get(context).isDark ? whiteColor : blackColor,
                  ),
                ),
                space20Vertical(context),
                myDivider(context),
                space20Vertical(context),
                Text(
                  '${appTranslation(context).emailAddress}: ${AppCubit.get(context).profileModel!.email}',
                  style: Theme.of(context).textTheme.caption!.copyWith(
                    fontSize: responsiveValue(context, 16),
                    fontWeight: FontWeight.w700,
                    color: AppCubit.get(context).isDark ? whiteColor : blackColor,
                  ),
                ),
                space20Vertical(context),
                myDivider(context),
                space20Vertical(context),
                Text(
                  '${appTranslation(context).phone}: ${AppCubit.get(context).profileModel!.phone}',
                  style: Theme.of(context).textTheme.caption!.copyWith(
                    fontSize: responsiveValue(context, 16),
                    fontWeight: FontWeight.w700,
                    color: AppCubit.get(context).isDark ? whiteColor : blackColor,
                  ),
                ),
                space20Vertical(context),
                myDivider(context),
                space20Vertical(context),
                Text(
                  '${appTranslation(context).age}: ${AppCubit.get(context).profileModel!.age}',
                  style: Theme.of(context).textTheme.caption!.copyWith(
                    fontSize: responsiveValue(context, 16),
                    fontWeight: FontWeight.w700,
                    color: AppCubit.get(context).isDark ? whiteColor : blackColor,
                  ),
                ),
                space20Vertical(context),
                myDivider(context),
                space20Vertical(context),
                AppCubit.get(context).profileModel!.isPatient! ?
                Text(
                '${appTranslation(context).status}: ${appTranslation(context).patient}',
                style: Theme.of(context).textTheme.caption!.copyWith(
                  fontSize: responsiveValue(context, 16),
                  fontWeight: FontWeight.w700,
                  color: AppCubit.get(context).isDark ? whiteColor : blackColor,
                ),
                ) :
                Text(
                  '${appTranslation(context).status}: ${appTranslation(context).doctor}',
                  style: Theme.of(context).textTheme.caption!.copyWith(
                    fontSize: responsiveValue(context, 16),
                    fontWeight: FontWeight.w700,
                    color: AppCubit.get(context).isDark ? whiteColor : blackColor,
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
