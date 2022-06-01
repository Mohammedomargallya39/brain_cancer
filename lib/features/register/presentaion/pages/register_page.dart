import 'package:flutter/cupertino.dart';
import '../../../../core/util/widgets/back_scaffold.dart';
import '../../../../core/util/widgets/hide_keyboard_page.dart';
import '../widgets/register_widget.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackScaffold(
      body: HideKeyboardPage(
        child: RegisterWidget(),
      ),
    );
  }
}
