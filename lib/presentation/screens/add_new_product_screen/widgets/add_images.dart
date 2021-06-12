import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trawus/presentation/screens/add_new_product_screen/components/text_form_fields.dart';
import 'package:trawus/presentation/widget/alert_dialog.dart';

// ignore: must_be_immutable
class AddImagesForNewProduct extends StatefulWidget {
  Function onPressedForNextButton;
  List<File> images;

  AddImagesForNewProduct({
    @required this.images,
    @required this.onPressedForNextButton,
  });

  @override
  _AddImagesForNewProductState createState() {
    return _AddImagesForNewProductState();
  }
}

class _AddImagesForNewProductState extends State<AddImagesForNewProduct> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${widget.images.length}/5",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 1,
            children: List.generate(
              5,
              (index) {
                if (widget.images != null) {
                  if (index > (widget.images.length - 1)) {
                    return addImageContainer();
                  } else {
                    return previewImage(widget.images[index]);
                  }
                }
                return addImageContainer();
              },
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        elevatedButton(
          icon: Icon(
            Icons.arrow_forward_ios,
            size: 18,
          ),
          onPressed: () {
            if (widget.images.length == 0) {
              errorDialog();
              return;
            }
            widget.onPressedForNextButton();
          },
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Widget addImageContainer() {
    return InkWell(
      onTap: _pickImage,
      child: Container(
        margin: EdgeInsets.all(5),
        height: 300,
        width: 300,
        decoration: BoxDecoration(color: Colors.black54),
        child: Center(
          child: Icon(
            Icons.add_a_photo_rounded,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
    );
  }

  Widget previewImage(File image) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.file(
          image,
          height: 300,
          width: 300,
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            alignment: Alignment.topRight,
            onPressed: () => _removeImage(image),
            icon: Icon(
              Icons.remove_circle_sharp,
              size: 30,
              color: Theme.of(context).errorColor,
            ),
          ),
        ),
      ],
    );
  }

  void _removeImage(File image) {
    setState(() {
      widget.images.removeWhere(
          (element) => element.absolute.path == image.absolute.path);
    });
  }

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 50);
    final pickedImageFile = File(pickedImage.path);
    setState(() {
      widget.images.add(pickedImageFile);
    });
  }

  void errorDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialogBox(
            title: "Error",
            message: "Please Select at least one image for the product",
            buttonText: "close",
            context: context));
  }
}
