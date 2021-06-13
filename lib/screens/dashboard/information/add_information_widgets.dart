import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medi_vault/models/allergy_model.dart';
import 'package:medi_vault/models/disease_model.dart';
import 'package:medi_vault/models/medication_model.dart';
import 'package:medi_vault/models/vaccination_model.dart';
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
  TextEditingController _diseaseController = TextEditingController();
  DateTime? toDate;
  DateTime? fromDate;

  bool isNameError = false;
  bool isFromDateError = false;
  bool isToDateError = false;

  @override
  Widget build(BuildContext context) {
    return _alertOutline(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTextField(
            key: "Disease Name",
            textEditingController: _diseaseController,
          ),
          if (isNameError) _errorMessage("Enter a disease name"),
          _buildDateSelector(
            key: "Date From",
            date: fromDate,
            context: context,
            setDate: (DateTime? date) {
              setState(() {
                fromDate = date;
              });
            },
          ),
          if (isFromDateError) _errorMessage("Select a date"),
          _buildDateSelector(
            key: "Date To",
            date: toDate,
            context: context,
            setDate: (DateTime? date) {
              setState(() {
                toDate = date;
              });
            },
          ),
          if (isToDateError) _errorMessage("Select a date"),
        ],
      ),
      onSubmit: () {
        bool flag = true;

        if (_diseaseController.text.trim().isEmpty) {
          setState(() {
            flag = false;
            isNameError = true;
          });
        }

        if (fromDate == null) {
          setState(() {
            flag = false;
            isFromDateError = true;
          });
        }

        if (toDate == null) {
          setState(() {
            flag = false;
            isToDateError = true;
          });
        }

        if (flag) {
          DiseaseModel diseaseModel = DiseaseModel(
            disease: _diseaseController.text,
            fromDate: fromDate,
            toDate: toDate,
          );
          updateInformationList(Global.diseaseInformation, diseaseModel);
          AutoRouter.of(context).root.pop();
          showSnackbar("Added Successfully");
        }
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
  TextEditingController itemNameController = TextEditingController();
  TextEditingController reactionController = TextEditingController();

  bool isNameError = false;
  bool isReactionError = false;

  @override
  Widget build(BuildContext context) {
    return _alertOutline(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTextField(
            key: "Name",
            textEditingController: itemNameController,
          ),
          if (isNameError) _errorMessage("Enter a Medicine Name"),
          _buildTextField(
            key: "Reaction",
            textEditingController: reactionController,
          ),
          if (isReactionError) _errorMessage("Enter a Reaction"),
        ],
      ),
      onSubmit: () {
        bool flag = true;

        if (itemNameController.text.trim().isEmpty) {
          setState(() {
            flag = false;
            isNameError = true;
          });
        }

        if (reactionController.text.trim().isEmpty) {
          setState(() {
            flag = false;
            isReactionError = true;
          });
        }

        if (flag) {
          AllergyModel allergyModel = AllergyModel(
            item: itemNameController.text,
            reaction: reactionController.text,
          );

          updateInformationList(Global.medicationInformation, allergyModel);

          AutoRouter.of(context).root.pop();
          showSnackbar("Added Successfully");
        }
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
  TextEditingController _tradeNameController = TextEditingController();
  TextEditingController _againstController = TextEditingController();
  TextEditingController _immunizationController = TextEditingController();

  DateTime? date;

  bool isTradeNameError = false;
  bool isDateError = false;
  bool isAgainstError = false;
  bool isImmunizationError = false;

  @override
  Widget build(BuildContext context) {
    return _alertOutline(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTextField(
              key: "Trade Name", textEditingController: _tradeNameController),
          if (isTradeNameError) _errorMessage("Enter a trade name"),
          _buildDateSelector(
            key: "Date",
            date: date,
            context: context,
            setDate: (DateTime? d) {
              setState(() {
                date = d;
              });
            },
          ),
          if (isDateError) _errorMessage("Select a Date"),
          _buildTextField(
              key: "Against", textEditingController: _againstController),
          if (isAgainstError) _errorMessage("Enter a disease name"),
          _buildTextField(
            key: "Immunization",
            textEditingController: _immunizationController,
          ),
          if (isImmunizationError) _errorMessage("Enter an Immunizaion Type"),
        ],
      ),
      onSubmit: () {
        bool flag = true;

        if (_againstController.text.trim().isEmpty) {
          setState(() {
            isAgainstError = true;
            flag = false;
          });
        }

        if (_tradeNameController.text.trim().isEmpty) {
          setState(() {
            isTradeNameError = true;
            flag = false;
          });
        }

        if (_immunizationController.text.trim().isEmpty) {
          setState(() {
            isImmunizationError = true;
            flag = false;
          });
        }

        if (date == null) {
          setState(() {
            isDateError = true;
            flag = false;
          });
        }

        if (flag) {
          VaccinationModel vaccinationModel = VaccinationModel(
            against: _againstController.text,
            date: date,
            immunizationType: _immunizationController.text,
            tradeName: _tradeNameController.text,
          );

          updateInformationList(
              Global.vaccinationInformation, vaccinationModel);

          AutoRouter.of(context).root.pop();
          showSnackbar("Added Successfully");
        }
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
      Divider(),
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
            keyboardType: TextInputType.multiline,
            controller: textEditingController,
            decoration: InputDecoration(),
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 14.0,
            ),
            maxLines: 4,
            minLines: 1,
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
