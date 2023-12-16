import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

class AddCar extends StatefulWidget {
  const AddCar({super.key});

  @override
  State<AddCar> createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  // Function to select images
  void selectImages() async {
    List<XFile>? selectedImages = await ImagePicker().pickMultiImage();

    // ignore: unnecessary_null_comparison
    if (selectedImages != null) {
      setState(() {
        imageFileList = selectedImages;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      color: HexColor('#055f91'),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: imageFileList!.isEmpty,
                child: SizedBox(
                  width: double.infinity,
                  height: 350,
                  child: Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          selectImages();
                        },
                        child: Center(
                          child: Image.asset(
                            'assets/add_car.jpg',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Visibility(
                  visible: imageFileList!.isNotEmpty,
                  child: SizedBox(
                    width: double.infinity,
                    height: 350,
                    child: GridView.builder(
                      itemCount: imageFileList!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Image.file(
                          File(imageFileList![index].path),
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                // height: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                  child: Column(
                    children: [
                      const CustomTextForm(hintText: 'COLOUR'),
                      const SizedBox(height: 10),
                      const CustomTextForm(hintText: 'CAR MODEL'),
                      const SizedBox(height: 10),
                      const CustomTextForm(hintText: 'SEATER'),
                      const SizedBox(height: 10),
                      const CustomTextForm(hintText: 'RENTAL PRICE'),
                      const SizedBox(height: 30),
                      Container(
                        width: 130,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: HexColor('#055f91'),
                        ),
                        child: TextButton(
                          child: const Text(
                            'ADD CAR',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextForm extends StatelessWidget {
  final String hintText;
  const CustomTextForm({
    super.key,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15.0),
          ),
          hintText: hintText,
          filled: true, //<-- SEE HERE
          fillColor: Colors.grey.shade300, //<-- SEE HERE
          hintStyle: const TextStyle(color: Colors.grey)),
    );
  }
}
