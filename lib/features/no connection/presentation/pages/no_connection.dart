import 'package:brain_cancer_detection_v1/core/util/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../core/util/widgets/home_scaffold.dart';



class NoConnectionPage extends StatelessWidget {
  const NoConnectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeScaffold(
      widget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
                'assets/images/no_connection.png',
                color: HexColor(mainColor),
                height: responsiveValue(context, 200),
                width: responsiveValue(context, 200),
            ),
          ),
          Text(
              appTranslation(context).checkInternet,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w700,
                color: HexColor(mainColor),
                ),
          ),

        ],
      ),
    );
  }
}
