import 'package:flutter/material.dart';
import 'package:trawus/presentation/screens/add_new_product_screen/components/text_form_fields.dart';

// ignore: must_be_immutable
class NewProductDetails extends StatefulWidget {
  String title;
  String description;
  double price;
  Function onSavedTitle;
  Function onSavedDescription;
  Function onSavedPrice;
  Function onTapForNextButton;

  NewProductDetails({
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.onSavedTitle,
    @required this.onSavedDescription,
    @required this.onSavedPrice,
    @required this.onTapForNextButton,
  });

  @override
  _NewProductDetails createState() {
    return _NewProductDetails();
  }
}

class _NewProductDetails extends State<NewProductDetails> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Form(key: _formKey, child: getFormFields()),
          const SizedBox(
            height: 40,
          ),
          Center(
            child: elevatedButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  final formIsValid = _formKey.currentState.validate();
                  if (!formIsValid) {
                    return;
                  }
                  _formKey.currentState.save();
                  widget.onTapForNextButton();
                }),
          ),
        ],
      ),
    );
  }

  Widget getFormFields() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30,
          ),
          titleTextFormField(widget.title, widget.onSavedTitle),
          const SizedBox(
            height: 30,
          ),
          descriptionTextFormField(
              widget.description, widget.onSavedDescription),
          const SizedBox(
            height: 30,
          ),
          priceTextFormField(widget.price, widget.onSavedPrice),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
