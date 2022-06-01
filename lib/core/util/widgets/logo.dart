import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../constants.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Image.asset(
          'assets/images/BrainCancerLogo.png',
          width: pxToDp(350.0),
          height: pxToDp(350.0),
          color: AppCubit
              .get(context)
              .isDark ? HexColor(regularGrey) : HexColor(mainColor),
        );
      },
    );
  }
}
