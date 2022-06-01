import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../features/setting/presentation/widgets/choose_between_two_options.dart';
import '../constants.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';
import 'main_scaffold.dart';

class HomeScaffold extends StatelessWidget {
  final Widget widget;

  const HomeScaffold({Key? key, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return SafeArea(
          child: MainScaffold(
            scaffold: Scaffold(
              body: widget,
            ),
          ),
        );
      },
    );
  }
}
