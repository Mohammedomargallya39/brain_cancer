import 'package:brain_cancer_detection_v1/core/util/cubit/cubit.dart';
import 'package:brain_cancer_detection_v1/core/util/cubit/state.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../core/util/constants.dart';

class ResultsWidget extends StatelessWidget {
  const ResultsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit,AppState>(
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
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        responsiveValue(context, 20)
                    ),
                    border: Border.all(
                        color: HexColor(regularGrey),
                        width: responsiveValue(context, 1)
                    )
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsiveValue(
                      context,
                      20,
                    ),
                    vertical: responsiveValue(
                      context,
                      10,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        appTranslation(context).mriResult,
                        style:  Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Expanded(
                        child: Image.asset(
                          'assets/images/brain.png',
                          width: responsiveValue(context, 80),
                          height: responsiveValue(context, 80),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              space50Vertical(context),

              ConditionalBuilder(
                condition:
                result.toString() == '{The Result is: Not a Tumor}' ||
                result.toString() == '{The Result is: Tumor}' ,
                builder: (context) =>  Column(
                  children: [
                    Container(
                      width: responsiveValue(context, 300.0),
                      height: responsiveValue(context, 250.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(
                            AppCubit.get(context).galleryProductImage!,                        ),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.circular(
                          responsiveValue(context, 20),
                        ),
                      ),
                    ),
                    space50Vertical(context),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${appTranslation(context).name}: ${AppCubit.get(context).profileModel!.username}',
                          style:  Theme.of(context).textTheme.headline6!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        space20Vertical(context),
                        Text(
                          '${appTranslation(context).age}: ${AppCubit.get(context).profileModel!.age}',
                          style:  Theme.of(context).textTheme.headline6!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        space20Vertical(context),
                        result.toString() == '{The Result is: Not a Tumor}' ?
                        Text(
                          '${appTranslation(context).results}: ${appTranslation(context).notATumor}',
                          style:  Theme.of(context).textTheme.headline6!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ) :
                        Text(
                          '${appTranslation(context).results}: ${appTranslation(context).aTumor}',
                          style:  Theme.of(context).textTheme.headline6!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        space20Vertical(context),
                      ],
                    )
                  ],
                ),
                fallback: (context) => Center(
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/images/empty_box.svg',
                        color: HexColor(regularGrey),
                      ),
                      Text(
                        'Add an image first to see the result',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: HexColor(darkGreyColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
