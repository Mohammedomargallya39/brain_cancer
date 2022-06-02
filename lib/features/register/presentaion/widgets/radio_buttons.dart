import 'package:brain_cancer_detection_v1/core/util/cubit/state.dart';
import 'package:brain_cancer_detection_v1/features/register/presentaion/widgets/register_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../core/util/constants.dart';
import '../../../../core/util/cubit/cubit.dart';

class RadioButton extends StatelessWidget {
  const RadioButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit,AppState>(
      builder: (context, state) => Row(
        children: [
          Expanded(
            child: RadioListTile<SingingCharacter>(
                title: Text(
                    appTranslation(context).patient
                ),
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
                title: Text(
                    appTranslation(context).doctor
                ),
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
    );
  }
}
