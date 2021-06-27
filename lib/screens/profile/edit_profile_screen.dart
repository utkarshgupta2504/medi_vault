import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medi_vault/models/user_model.dart';
import 'package:medi_vault/providers/user_provider.dart';
import 'package:medi_vault/routes/app_router.gr.dart';
import 'package:medi_vault/utils/app_logger.dart';
import 'package:medi_vault/utils/global.dart';
import 'package:medi_vault/utils/image_utils.dart';
import 'package:medi_vault/utils/preferences.dart';
import 'package:medi_vault/widgets/circle_image.dart';
import 'package:intl/intl.dart';
import 'package:medi_vault/widgets/user_header.dart';
import 'package:provider/provider.dart';

const List<String> genderList = ['--Select--', 'Male', 'Female'];

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key? key, this.isStarting = false}) : super(key: key);

  final bool isStarting;

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController heightController;
  late TextEditingController weightController;

  DateTime? dob;

  String gender = genderList[0];

  late File profilePicture;

  late UserModel user;

  Map<String, bool> errors = {
    "name": false,
    "dob": false,
    "gender": false,
    "height": false,
    "weight": false,
  };

  validate() {
    bool flag = true;

    AppLogger.print(dob.toString());

    setState(() {
      if (nameController.text.isEmpty) {
        flag = false;
        errors["name"] = true;
      }

      if (weightController.text.isEmpty) {
        flag = false;
        errors["weight"] = true;
      }

      try {
        double.parse(weightController.text);
      } catch (e) {
        flag = false;
        errors["weight"] = true;
      }

      if (heightController.text.isEmpty) {
        flag = false;
        errors["height"] = true;
      }

      try {
        double.parse(heightController.text);
      } catch (e) {
        flag = false;
        errors["height"] = true;
      }

      if (gender == genderList[0]) {
        flag = false;
        errors['gender'] = true;
      }

      if (dob == null || dob.toString() == "null") {
        flag = false;
        errors["dob"] = true;
      }
    });

    return flag;
  }

  @override
  void initState() {
    super.initState();

    user = Preference.hasKey(Global.userProfileDetails)
        ? UserModel.fromJson(
            Preference.getString(Global.userProfileDetails, def: null))
        : UserModel();

    AppLogger.print(user.toString());

    nameController = TextEditingController(text: user.name);
    heightController = TextEditingController(
        text: user.height != null ? user.height.toString() : "0.0");
    weightController = TextEditingController(
        text: user.weight != null ? user.weight.toString() : "0.0");

    gender = user.gender ?? genderList[0];

    dob = user.dob;
  }

  @override
  Widget build(BuildContext context) {
    // AppLogger.print("Edit screen, isStarting: ${widget.isStarting}");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isStarting ? "Set Profile" : "Edit Profile"),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 24,
          ),
          child: Column(
            children: [
              UserHeader(isEditScreen: true, showPicker: _showPicker),
              Container(
                color: Colors.grey[100],
                child: SizedBox(
                  height: 25,
                ),
              ),
              Expanded(
                child: Container(
                  // color: Colors.white,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: SingleChildScrollView(
                    // controller: _scrollController,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[200]!,
                          ),
                          BoxShadow(
                            color: Colors.grey[200]!,
                          ),
                          BoxShadow(
                            color: Colors.grey[200]!,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 15,
                          ),

                          _buildItem(
                              "Name", user.name == null ? null : user.name),
                          errors["name"]!
                              ? _errorMessage("Please Enter a Name")
                              : SizedBox(
                                  height: 0,
                                ),
                          _buildItem(
                              "Gender", user.gender == null ? null : user.name),
                          errors["gender"]!
                              ? _errorMessage("Please Select a Gender")
                              : SizedBox(
                                  height: 0,
                                ),
                          _buildItem(
                              "Date of Birth",
                              dob == null
                                  ? null
                                  : dob!.toIso8601String().substring(0, 10)),
                          errors["dob"]!
                              ? _errorMessage("Please Enter a Date of Birth")
                              : SizedBox(
                                  height: 0,
                                ),
                          _buildItem(
                              "Height (cms)",
                              user.height == null
                                  ? null
                                  : user.height.toString()),
                          errors["height"]!
                              ? _errorMessage("Please Enter a valid Height")
                              : SizedBox(
                                  height: 0,
                                ),
                          _buildItem(
                              "Weight (kgs)",
                              user.weight == null
                                  ? null
                                  : user.weight.toString()),
                          errors["weight"]!
                              ? _errorMessage("Please Enter a Valid Weight")
                              : SizedBox(
                                  height: 0,
                                ),

                          SizedBox(height: 16),
                          // if (user.subs_type.length < 4)
                          ElevatedButton(
                            child: Text("Save"),
                            onPressed: () {
                              if (validate()) {
                                Preference.setString(
                                    Global.userProfileDetails,
                                    jsonEncode({
                                      "name": nameController.text,
                                      "dob": dob!
                                          .toIso8601String()
                                          .substring(0, 10),
                                      "gender": gender,
                                      "weight": double.tryParse(
                                          weightController.text)!,
                                      "height": double.tryParse(
                                          heightController.text)!,
                                    }));

                                Provider.of<UserProvider>(context,
                                        listen: false)
                                    .getUser();

                                setState(() {});

                                Preference.setBool(Global.profileSet, true);

                                if (!widget.isStarting) {
                                  AutoRouter.of(context).root.pop();
                                } else {
                                  AutoRouter.of(context)
                                      .root
                                      .replace(DashboardScreenRoute());
                                }
                              } else {
                                AppLogger.print(
                                    "Validation failed! ${errors.toString()}");
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _errorMessage(String message) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 10),
      child: Text(
        message,
        style: TextStyle(
          color: Colors.redAccent,
          fontSize: 10,
        ),
      ),
    );
  }

  Widget _buildItem(String key, String? value) {
    return Column(
      // key: key == "Name" ? inputFieldKey : null,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            key,
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
              fontSize: 12.0,
            ),
          ),
        ),
        key == "Date of Birth"
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: ListTile(
                  title: Text(value == null && user.dob == null
                      ? "Select Date"
                      : DateFormat("MMMM dd, yyyy")
                          .format(DateTime.parse(value!))),
                  trailing: Icon(Icons.calendar_today),
                  onTap: () async {
                    DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: dob ?? DateTime.now(),
                      firstDate: DateTime(DateTime.now().year - 150),
                      lastDate: DateTime.now(),
                    );

                    // AppLogger.print(date.toString());

                    setState(() {
                      dob = date;
                    });
                  },
                ))
            : key == "Gender"
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: DropdownButton<String?>(
                      value: gender,
                      items: genderList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          gender = value!;
                        });
                      },
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      keyboardType:
                          (key == "Height (cms)" || key == "Weight (kgs)")
                              ? TextInputType.number
                              : TextInputType.text,
                      controller: key == "Name"
                          ? nameController
                          : key == "Height (cms)"
                              ? heightController
                              : key == "Weight (kgs)"
                                  ? weightController
                                  : null,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
        key == "Date of Birth"
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(
                  thickness: 2,
                ),
              )
            : SizedBox(height: 10),
      ],
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () async {
                        await _getFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () async {
                      await _getFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) await _cropImage(pickedFile.path);
  }

  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) await _cropImage(pickedFile.path);
  }

  /// Crop Image
  Future<Null> _cropImage(filePath) async {
    File? croppedImage = await ImageCropper.cropImage(
        sourcePath: filePath,
        maxWidth: 1080,
        maxHeight: 1080,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0));
    if (croppedImage != null) {
      profilePicture = croppedImage;
      Preference.setString(Global.profilePhoto,
          ImageUtility.base64String(profilePicture.readAsBytesSync()));
      setState(() {});
    }
  }
}
