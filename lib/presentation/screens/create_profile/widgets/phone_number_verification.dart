import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:trawus/constants.dart';
import 'package:trawus/domain/Firebase/auth/user_authentications.dart';
import 'package:trawus/presentation/screens/add_new_product_screen/components/text_form_fields.dart';

class PhoneNumberVerification extends StatefulWidget {
  Function renderNextForm;
  int index = 0;
  bool showButton = false;

  PhoneNumberVerification(this.renderNextForm);

  @override
  _PhoneNumberVerificationState createState() =>
      _PhoneNumberVerificationState();
}

class _PhoneNumberVerificationState extends State<PhoneNumberVerification> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();
  String _verificationId;
  final SmsAutoFill _autoFill = SmsAutoFill();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text("Verify Phone number", style: TextStyle(color: blackColor),),
      ),
      body: Padding(
          padding: EdgeInsets.all(16),
          child: widget.index == 0 ? phoneNumberInputForm() : verifyOTP()),
    );
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void setVerificationID(String verificationId) {
    this._verificationId = verificationId;
  }

  Widget phoneNumberInputForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          onChanged: (value) {
            // ignore: null_aware_in_condition
            if (value?.isNotEmpty) {
              widget.showButton = true;
            } else {
              widget.showButton = false;
            }
            setState(() {});
          },
          onTap: () async =>
              {_phoneNumberController.text = await _autoFill.hint},
          controller: _phoneNumberController,
          decoration: const InputDecoration(
              labelText: 'Phone number (+xx xxx-xxx-xxxx)'),
        ),
        SizedBox(
          height: 15,
        ),
        Center(
          child: elevatedButton(
            onPressed: () async {
              bool verificationSuccessful = await UserAuth.verifyPhoneNumber(
                  showSnackBar, setVerificationID, _phoneNumberController.text);
              if (verificationSuccessful) {
                setState(() {
                  widget.index++;
                });
              }
            },
            icon: Icon(Icons.sms, size: 18),
          ),
        ),
      ],
    );
  }

  Widget verifyOTP() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _smsController,
          decoration: const InputDecoration(labelText: 'Verification code'),
        ),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          child: Text(
            "change Phone number?",
            style: TextStyle(
              color: primaryColor,
            ),
          ),
          onTap: () {
            setState(() {
              widget.index--;
            });
          },
        ),
        const SizedBox(
          height: 15,
        ),
        Center(
          child: elevatedButton(
            onPressed: () async {
              final linkingSuccessful = await UserAuth.linkPhoneNumberWithUser(
                sms: _smsController.text,
                verificationId: _verificationId,
                showSnackBar: showSnackBar,
              );
              if (linkingSuccessful) {
                widget.renderNextForm();
              } else {
                setState(() {
                  widget.index--;
                });
              }
            },
            icon: Icon(Icons.arrow_forward_ios, size: 18),
          ),
        ),
      ],
    );
  }
}
