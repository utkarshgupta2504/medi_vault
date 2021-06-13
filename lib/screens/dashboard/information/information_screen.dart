import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:medi_vault/models/allergy_model.dart';
import 'package:medi_vault/models/disease_model.dart';
import 'package:medi_vault/models/medication_model.dart';
import 'package:medi_vault/models/vaccination_model.dart';
import 'package:medi_vault/routes/app_router.gr.dart';
import 'package:medi_vault/screens/dashboard/information/add_information_widgets.dart';
import 'package:medi_vault/screens/dashboard/information/data_card_widget.dart';
import 'package:medi_vault/utils/common_functions.dart';
import 'package:medi_vault/utils/global.dart';
import 'package:medi_vault/utils/image_utils.dart';
import 'package:medi_vault/utils/preferences.dart';

DateFormat formatter = DateFormat("MMMM dd, yyyy");

class InformationScreen extends StatefulWidget {
  const InformationScreen({Key? key}) : super(key: key);

  @override
  _InformationScreenState createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          ListTile(
            title: Text("Doctor Prescription"),
            subtitle: Text("Prescriptions provided by the doctor"),
            trailing: ElevatedButton(
              child: Text("Add"),
              onPressed: () {
                _showPicker(context,
                    preferenceKey: Global.prescriptionInformation);
              },
            ),
            onTap: () {
              AutoRouter.of(context).root.push(
                    ImagesDisplayScreenRoute(
                        imagesList:
                            Preference.hasKey(Global.prescriptionInformation)
                                ? jsonDecode(Preference.getString(
                                    Global.prescriptionInformation)!)
                                : [],
                        title: "Doctor Prescriptions"),
                  );
            },
          ),
          ListTile(
            title: Text("Medical History"),
            subtitle: Text("Keep track of your medical records"),
            trailing: ElevatedButton(
              child: Text("Add"),
              onPressed: () {
                _showPicker(context, preferenceKey: Global.historyInformation);
              },
            ),
            onTap: () {
              AutoRouter.of(context).root.push(
                    ImagesDisplayScreenRoute(
                        imagesList: Preference.hasKey(Global.historyInformation)
                            ? jsonDecode(Preference.getString(
                                Global.historyInformation)!)
                            : [],
                        title: "Medical History"),
                  );
            },
          ),
          ListTile(
            title: Text("Medication"),
            subtitle: Text("Currently used medicines"),
            trailing: ElevatedButton(
              child: Text("Add"),
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) => AddMedication(),
                );
              },
            ),
            onTap: () {
              AutoRouter.of(context).root.push(InformationDetailScreenRoute(
                    createCard: (data) {
                      MedicationModel medicationModel =
                          MedicationModel.fromJson(data);
                      return DataCard(
                        fields: [
                          DataField(
                            name: "Name:",
                            value: medicationModel.medicineName!,
                          ),
                          DataField(
                            name: "Reason:",
                            value: medicationModel.reason!,
                          ),
                        ],
                      );
                    },
                    informationList:
                        getInformationList(Global.medicationInformation),
                    title: "Medications",
                  ));
            },
          ),
          ListTile(
            title: Text("Known Diseases"),
            subtitle: Text("Diseases you have presently, or had in the past"),
            trailing: ElevatedButton(
              child: Text("Add"),
              onPressed: () {},
            ),
            onTap: () {
              AutoRouter.of(context).root.push(InformationDetailScreenRoute(
                    createCard: (data) {
                      DiseaseModel diseaseModel = DiseaseModel.fromJson(data);
                      return DataCard(
                        fields: [
                          DataField(
                            name: "Name:",
                            value: diseaseModel.disease!,
                          ),
                          DataField(
                            name: "From:",
                            value: formatter.format(diseaseModel.fromDate!),
                          ),
                          DataField(
                            name: "To:",
                            value: formatter.format(diseaseModel.toDate!),
                          ),
                        ],
                      );
                    },
                    informationList:
                        getInformationList(Global.diseaseInformation),
                    title: "Known Diseases",
                  ));
            },
          ),
          ListTile(
            title: Text("Allergies"),
            subtitle: Text("Items you are allergic to"),
            trailing: ElevatedButton(
              child: Text("Add"),
              onPressed: () {},
            ),
            onTap: () {
              AutoRouter.of(context).root.push(InformationDetailScreenRoute(
                    createCard: (data) {
                      AllergyModel allergyModel = AllergyModel.fromJson(data);
                      return DataCard(
                        fields: [
                          DataField(
                            name: "Item:",
                            value: allergyModel.item!,
                          ),
                          DataField(
                            name: "Reaction:",
                            value: allergyModel.reaction!,
                          ),
                        ],
                      );
                    },
                    informationList:
                        getInformationList(Global.allergyInformation),
                    title: "Allergies",
                  ));
            },
          ),
          ListTile(
            title: Text("Vaccinations"),
            subtitle: Text("Vaccinations you have received"),
            trailing: ElevatedButton(
              child: Text("Add"),
              onPressed: () {},
            ),
            onTap: () {
              AutoRouter.of(context).root.push(InformationDetailScreenRoute(
                    createCard: (data) {
                      VaccinationModel vaccinationModel =
                          VaccinationModel.fromJson(data);
                      return DataCard(
                        fields: [
                          DataField(
                            name: "Name:",
                            value: vaccinationModel.tradeName!,
                          ),
                          DataField(
                            name: "Date:",
                            value: formatter.format(vaccinationModel.date!),
                          ),
                          DataField(
                            name: "Against:",
                            value: vaccinationModel.against!,
                          ),
                          DataField(
                            name: "Immunization:",
                            value: vaccinationModel.immunizationType!,
                          ),
                        ],
                      );
                    },
                    informationList:
                        getInformationList(Global.vaccinationInformation),
                    title: "Vaccinations",
                  ));
            },
          ),
        ],
      ),
    );
  }

  void _showPicker(context, {String? preferenceKey}) {
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
                        await _getFromGallery(preferenceKey: preferenceKey);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () async {
                      await _getFromCamera(preferenceKey: preferenceKey);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _getFromGallery({String? preferenceKey}) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null)
      await _cropImage(pickedFile.path, preferenceKey: preferenceKey);
  }

  _getFromCamera({String? preferenceKey}) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null)
      await _cropImage(pickedFile.path, preferenceKey: preferenceKey);
  }

  /// Crop Image
  Future<Null> _cropImage(filePath, {String? preferenceKey}) async {
    File? croppedImage = await ImageCropper.cropImage(
      sourcePath: filePath,
      maxWidth: 1080,
      maxHeight: 1080,
    );
    if (croppedImage != null) {
      File? image = croppedImage;
      List<dynamic> prevImages = Preference.hasKey(preferenceKey!)
          ? jsonDecode(Preference.getString(preferenceKey)!)
          : [];
      prevImages.add(ImageUtility.base64String(image.readAsBytesSync()));
      Preference.setString(preferenceKey, jsonEncode(prevImages));

      showSnackbar("Image Added Successfully!");
    }
  }
}
