import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/util/widgets/home_scaffold.dart';
import '../widgets/results_widget.dart';



class ResultPage extends StatelessWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomeScaffold(widget: ResultsWidget(),);
  }
}
