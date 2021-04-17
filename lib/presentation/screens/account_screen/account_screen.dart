import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:trawus/presentation/screens/account_screen/widgets/render_form.dart';
import 'package:trawus/presentation/widget/main_logo.dart';

import 'components/sign_in_using_other_option.dart';

class Account extends StatelessWidget {
  static const routeName = "/accountScreen";

  @override
  Widget build(BuildContext context) {
    final displaySize = MediaQuery.of(context).size;
    double sizedBoxHeight = kIsWeb ? 0 : (displaySize.height * 0.05);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: sizedBoxHeight,
            ),
            const MainLogo(),
            SizedBox(
              height: displaySize.height * 0.02,
            ),
            RenderForm(),
            signInUsingOtherOption(context),
          ],
        ),
      ),
    );
  }
}
