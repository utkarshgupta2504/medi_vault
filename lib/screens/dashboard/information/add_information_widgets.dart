import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medi_vault/models/medication_model.dart';
import 'package:medi_vault/routes/app_router.gr.dart';
import 'package:medi_vault/utils/common_functions.dart';
import 'package:medi_vault/utils/global.dart';

class AddMedication extends StatefulWidget {
  const AddMedication({Key? key}) : super(key: key);

  @override
  _AddMedicationState createState() => _AddMedicationState();
}

class _AddMedicationState extends State<AddMedication> {
  TextEditingController medicineNameController = TextEditingController();
  TextEditingController reasonController = TextEditingController();

  bool isNameError = false;
  bool isReasonError = false;

  @override
  Widget build(BuildContext context) {
    return _alertOutline(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTextField(
            key: "Name",
            textEditingController: medicineNameController,
          ),
          if (isNameError) _errorMessage("Enter a Medicine Name"),
          _buildTextField(
            key: "Reason",
            textEditingController: reasonController,
          ),
          if (isReasonError) _errorMessage("Enter a Reason"),
        ],
      ),
      onSubmit: () {
        bool flag = true;

        if (medicineNameController.text.trim().isEmpty) {
          setState(() {
            flag = false;
            isNameError = true;
          });
        }

        if (reasonController.text.trim().isEmpty) {
          setState(() {
            flag = false;
            isReasonError = true;
          });
        }

        if (flag) {
          MedicationModel medicationModel = MedicationModel(
            medicineName: medicineNameController.text,
            reason: reasonController.text,
          );

          updateInformationList(Global.medicationInformation, medicationModel);

          AutoRouter.of(context).root.pop();
          showSnackbar("Added Successfully");
        }
      },
    );
  }
}

class AddDisesase extends StatefulWidget {
  const AddDisesase({Key? key}) : super(key: key);

  @override
  _AddDisesaseState createState() => _AddDisesaseState();
}

class _AddDisesaseState extends State<AddDisesase> {
  @override
  Widget build(BuildContext context) {
    return _alertOutline(
      child: Container(),
      onSubmit: () {
        AutoRouter.of(context).root.pop();
        showSnackbar("Added Successfully");
      },
    );
  }
}

class AddAllergy extends StatefulWidget {
  const AddAllergy({Key? key}) : super(key: key);

  @override
  _AddAllergyState createState() => _AddAllergyState();
}

class _AddAllergyState extends State<AddAllergy> {
  @override
  Widget build(BuildContext context) {
    return _alertOutline(
      child: Container(),
      onSubmit: () {
        AutoRouter.of(context).root.pop();
        showSnackbar("Added Successfully");
      },
    );
  }
}

class AddVaccination extends StatefulWidget {
  const AddVaccination({Key? key}) : super(key: key);

  @override
  _AddVaccinationState createState() => _AddVaccinationState();
}

class _AddVaccinationState extends State<AddVaccination> {
  @override
  Widget build(BuildContext context) {
    return _alertOutline(
      child: Container(),
      onSubmit: () {
        AutoRouter.of(context).root.pop();
        showSnackbar("Added Successfully");
      },
    );
  }
}

Widget _alertOutline(
    {required Widget child, required void Function() onSubmit}) {
  return AlertDialog(
    title: Column(
      children: [
        Text("Add Entry"),
        Divider(
          thickness: 2,
        ),
        child,
      ],
    ),
    actions: [
      ElevatedButton(
        onPressed: onSubmit,
        child: Text("Add"),
      ),
    ],
  );
}

Widget _buildDateSelector({
  required String key,
  required DateTime? date,
  required BuildContext context,
  required void Function(DateTime?) setDate,
}) {
  return Column(
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
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ListTile(
          title: Text(date == null
              ? "Select Date"
              : DateFormat("MMMM dd, yyyy").format(date)),
          trailing: Icon(Icons.calendar_today),
          onTap: () async {
            DateTime? tempDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(DateTime.now().year - 150),
              lastDate: DateTime.now(),
            );

            // AppLogger.print(tempDate.toString());

            setDate(tempDate);
          },
        ),
      ),
    ],
  );
}

Widget _buildTextField(
    {required String key,
    required TextEditingController textEditingController}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            keyboardType: TextInputType.text,
            controller: textEditingController,
            decoration: InputDecoration(),
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 14.0,
            ),
          ),
        ),
      ],
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
