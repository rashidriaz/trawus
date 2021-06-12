import 'package:flutter/material.dart';
import 'package:trawus/Models/enums/categories.dart';
import 'package:trawus/Models/location_address.dart';
import 'package:trawus/presentation/screens/add_new_product_screen/components/text_form_fields.dart';
import 'package:trawus/presentation/widget/alert_dialog.dart';
import 'input_location_for_products.dart';

// ignore: must_be_immutable
class SelectLocations extends StatelessWidget {
  Categories category;
  LocationAddress location1;
  LocationAddress location2;
  Function onPressedForNextButton;
  Function selectLocation1Function;
  Function selectLocation2Function;

  SelectLocations(
      {@required this.onPressedForNextButton,
      @required this.location1,
      @required this.location2,
      @required this.category,
      @required this.selectLocation1Function,
      @required this.selectLocation2Function});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Select source Location:",
            style: Theme.of(context).textTheme.caption,
          ),
          InputLocationForProduct(selectLocation1Function, location1),
          const SizedBox(
            height: 15,
          ),
          if (this.category == Categories.domestic_trips ||
              this.category == Categories.international_trips)
            Column(children: [
              Text(
                "Select source Location:",
                style: Theme.of(context).textTheme.caption,
              ),
              InputLocationForProduct(selectLocation2Function, location2),
            ]),
          const SizedBox(
            height: 15,
          ),
          elevatedButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
              onPressed: () {
                bool latitudeIsSame = location1.coordinates.latitude ==
                    location2.coordinates.latitude;
                bool longitudeIsSame = location1.coordinates.longitude ==
                    location2.coordinates.longitude;
                if ((latitudeIsSame && longitudeIsSame) &&
                    (category == Categories.domestic_trips ||
                        category == Categories.international_trips)) {
                  errorDialog(context);
                  return;
                }
                onPressedForNextButton();
              })
        ],
      ),
    );
  }

  void errorDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialogBox(
            title: "Error",
            message:
                "Please Select Different Locations for Source and destination",
            buttonText: "close",
            context: context));
  }
}
