import 'package:flutter/material.dart';
import 'package:trawus/Models/enums/categories.dart';
import 'package:trawus/constants.dart';
import 'package:trawus/domain/helpers/provider/categories_provider.dart';
import 'package:trawus/presentation/widget/alert_dialog.dart';

// ignore: must_be_immutable
class CategorySelectorPage extends StatelessWidget {
  Function onTap;
  Categories selectedCategory;

  CategorySelectorPage({@required this.onTap, @required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    final categoryList = CategoriesProvider()?.categories;
    final int totalCount = categoryList.length;
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(
        totalCount,
        (index) {
          bool categoryIsSelected = false;
          if (selectedCategory != null) {
            categoryIsSelected =
                categoryList[index].category == selectedCategory;
          }
          return GestureDetector(
            onTap: () => onTap(categoryList[index].category),
            onLongPress: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialogBox(
                      title: "Details",
                      message: categoryList[index].details,
                      buttonText: "close",
                      context: context));
            },
            child: Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(
                  width: categoryIsSelected? 3 : 1,
                  color: categoryIsSelected? primaryColor : blackColor,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    categoryList[index].iconUrl,
                    height: 60,
                    width: 100,
                  ),
                  Divider(),
                  Text(categoryList[index].title,
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: categoryIsSelected? FontWeight.w700: FontWeight.normal,
                        color: categoryIsSelected? primaryColor : blackColor
                      )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
