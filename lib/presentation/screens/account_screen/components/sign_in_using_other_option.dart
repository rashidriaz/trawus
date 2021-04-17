import 'package:flutter/material.dart';
import 'package:trawus/presentation/screens/account_screen/widgets/sign_in_with_facebook_button.dart';
import 'package:trawus/presentation/screens/account_screen/widgets/sign_in_with_google_button.dart';

import 'account_screen_divider.dart';

Container signInUsingOtherOption(BuildContext context) {
  final displaySize = MediaQuery.of(context).size;
  return Container(
    width: displaySize.width > 700 ? 500 : double.infinity,
    alignment: Alignment.center,
    child: Column(
      children: [
        accountScreenDivider(),
        SignInWithGoogleButton(),
        SignInWithFacebookButton()
      ],
    ),
  );
}
