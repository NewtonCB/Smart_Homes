import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:renting_app/posting_page/post_controller.dart';
import 'package:renting_app/dashboard/presentation/pages/home/widgets/bottom_nav.dart';

class PostingPage extends StatefulWidget {
  @override
  _PostingPageState createState() => _PostingPageState();
}

class _PostingPageState extends State<PostingPage> {
  final PostingPageController controller = Get.put(PostingPageController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7EBE1),
      appBar: AppBar(
        backgroundColor: const Color(0xffF7EBE1),
        title: const Text('Post Property'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white60, Colors.grey],
              ),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    final TextEditingController nameController = TextEditingController(text: controller.name.value);
                    nameController.selection = TextSelection.fromPosition(TextPosition(offset: nameController.text.length));
                    return TextFormField(
                      controller: nameController,
                      onChanged: (value) => controller.name.value = value,
                      decoration: InputDecoration(
                        labelText: 'Your Name',
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                    );
                  }),
                  const SizedBox(height: 10),
                  Obx(() {
                    final TextEditingController phoneController = TextEditingController(text: controller.phoneNumber.value);
                    phoneController.selection = TextSelection.fromPosition(TextPosition(offset: phoneController.text.length));
                    return TextFormField(
                      controller: phoneController,
                      onChanged: (value) => controller.phoneNumber.value = value,
                      decoration: InputDecoration(
                        labelText: ' Your Phone Number',
                        prefixIcon: const Icon(Icons.phone),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a phone number';
                        }
                        final RegExp phoneRegex = RegExp(r'^\+255\d{9}$');
                        if (!phoneRegex.hasMatch(value)) {
                          return 'Please enter a valid phone number (+255XXXXXXXXX)';
                        }
                        return null;
                      },
                    );
                  }),
                  const SizedBox(height: 10),
                  Obx(() {
                    final TextEditingController titleController = TextEditingController(text: controller.title.value);
                    titleController.selection = TextSelection.fromPosition(TextPosition(offset: titleController.text.length));
                    return TextFormField(
                      controller: titleController,
                      onChanged: (value) => controller.title.value = value,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        prefixIcon: const Icon(Icons.title),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    );
                  }),
                  const SizedBox(height: 10),
                  Obx(() {
                    final TextEditingController descriptionController = TextEditingController(text: controller.description.value);
                    descriptionController.selection = TextSelection.fromPosition(TextPosition(offset: descriptionController.text.length));
                    return TextFormField(
                      controller: descriptionController,
                      onChanged: (value) => controller.description.value = value,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        prefixIcon: const Icon(Icons.description),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                    );
                  }),
                  const SizedBox(height: 10),
                  Obx(() {
                    final TextEditingController rentAmountController = TextEditingController(text: controller.rentAmount.value);
                    rentAmountController.selection = TextSelection.fromPosition(TextPosition(offset: rentAmountController.text.length));
                    return TextFormField(
                      controller: rentAmountController,
                      onChanged: (value) => controller.rentAmount.value = value,
                      decoration: InputDecoration(
                        labelText: 'Rent Amount',
                        prefixIcon: const Icon(Icons.attach_money),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the rent amount';
                        }
                        return null;
                      },
                    );
                  }),
                  const SizedBox(height: 10),
                  Obx(() {
                    return DropdownButtonFormField<String>(
                      value: controller.rentPeriod.value,
                      decoration: InputDecoration(
                        labelText: 'Rent Period',
                        prefixIcon: const Icon(Icons.calendar_today),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onChanged: (String? newValue) {
                        controller.rentPeriod.value = newValue!;
                      },
                      items: <String>['Per Day', 'Per Week', 'Per Month', 'Per Year']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    );
                  }),
                  const SizedBox(height: 10),
                  Obx(() {
                    return DropdownButtonFormField<String>(
                      value: controller.selectedDistrict.value,
                      decoration: InputDecoration(
                        labelText: 'District',
                        prefixIcon: const Icon(Icons.location_city),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onChanged: (String? newValue) {
                        controller.selectedDistrict.value = newValue!;
                      },
                      items: <String>['Ilala', 'Kinondoni', 'Temeke', 'Ubungo', 'Kigamboni']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    );
                  }),
                  const SizedBox(height: 20),
                  Obx(() {
                    return controller.location.value.latitude == 0 && controller.location.value.longitude == 0
                        ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:const Color(0xff06113c),
                      ),
                      onPressed: () async {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return Center(
                              child: LoadingAnimationWidget.staggeredDotsWave(
                                color: const Color(0xff06113c),
                                size: 50,
                              ),
                            );
                          },
                        );

                        await controller.getCurrentLocation();

                        Navigator.of(context).pop();
                      },
                      child: const Text(
                          'Get Current Location',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                        : Text('Location: (${controller.location.value.latitude}, ${controller.location.value.longitude})');
                  }),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:const Color(0xff06113c),
                    ),
                    onPressed: controller.pickImages,
                    child: const Text(
                        'Pick Images from Gallery',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(() => GridView.builder(
                    shrinkWrap: true,
                    itemCount: controller.selectedImages.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      XFile image = controller.selectedImages[index];
                      return Stack(
                        children: [
                          Image.file(
                            File(image.path),
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            right: 0,
                            child: IconButton(
                              icon: const Icon(Icons.remove_circle),
                              onPressed: () {
                                controller.selectedImages.removeAt(index);
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  )),
                  const SizedBox(height: 20),
                  Obx(() {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Selected Amenities:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Wrap(
                          spacing: 10,
                          children: List.generate(
                            controller.amenities.length,
                                (index) => Chip(
                              label: Text(controller.amenities[index]),
                              onDeleted: () => controller.removeAmenity(index),
                              deleteIcon: const Icon(Icons.cancel),
                              deleteIconColor: Colors.red,
                            ),
                          ).toList(),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:const Color(0xff06113c),
                          ),
                          onPressed: () async {
                            List<String>? selectedAmenities = await showDialog<List<String>>(
                              context: context,
                              builder: (BuildContext context) {
                                return AmenitiesDialog(
                                  selectedAmenities: List<String>.from(controller.amenities),
                                );
                              },
                            );

                            if (selectedAmenities != null) {
                              controller.amenities.value = selectedAmenities;
                            }
                          },
                          child: const Text(
                              'Select Amenities',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    );
                  }),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:const Color(0xff06113c),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          bool confirm = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: const Color(0xffF7EBE1),
                                title: const Text('Confirm Post'),
                                content: const Text('Are you sure you want to post this?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(false),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(true),
                                    child: const Text('Confirm'),
                                  ),
                                ],
                              );
                            },
                          );
                          if (confirm) {
                            await controller.uploadPost(context);
                          } else {
                            print('Post discarded');
                          }
                        }
                      },

                      child: const Text('Upload',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: const FloatingActionButtonWithBottomNav(),
    );

  }
}

class AmenitiesDialog extends StatefulWidget {
  final List<String> selectedAmenities;

  AmenitiesDialog({required this.selectedAmenities});

  @override
  _AmenitiesDialogState createState() => _AmenitiesDialogState();
}

class _AmenitiesDialogState extends State<AmenitiesDialog> {
  late List<String> tempAmenities;

  @override
  void initState() {
    super.initState();
    tempAmenities = widget.selectedAmenities;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Amenities'),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            CheckboxListTile(
              title: const Text('WiFi'),
              value: tempAmenities.contains('WiFi'),
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    tempAmenities.add('WiFi');
                  } else {
                    tempAmenities.remove('WiFi');
                  }
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Master Bedroom'),
              value: tempAmenities.contains('Master Bedroom'),
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    tempAmenities.add('Master Bedroom');
                  } else {
                    tempAmenities.remove('Master Bedroom');
                  }
                });
              },
            ),
            // Add more amenities as needed
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(null),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(tempAmenities),
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
