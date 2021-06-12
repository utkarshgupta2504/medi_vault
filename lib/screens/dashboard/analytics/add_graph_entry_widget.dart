import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medi_vault/models/graph_data_model.dart';
import 'package:medi_vault/utils/app_logger.dart';

class AddGraphEntryWidget extends StatefulWidget {
  const AddGraphEntryWidget({
    Key? key,
    required this.units,
    required this.onSave,
    required this.chartData,
  }) : super(key: key);

  final String units;
  final Function onSave;
  final GraphDataModel? chartData;

  @override
  _AddEntryWidgetState createState() => _AddEntryWidgetState();
}

class _AddEntryWidgetState extends State<AddGraphEntryWidget> {
  DateTime? date;
  late TextEditingController _textEditingController;

  bool showDateError = false;
  bool showValueError = false;

  @override
  void initState() {
    super.initState();

    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Text("Add Entry"),
          Divider(
            height: 5,
            thickness: 2,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ListTile(
              title: Text(date == null
                  ? "Select Date"
                  : DateFormat("MMMM dd, yyyy").format(date!)),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                DateTime? tempDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(Duration(days: 6)),
                  lastDate: DateTime.now(),
                );

                // AppLogger.print(tempDate.toString());

                setState(() {
                  date = tempDate;
                });
              },
            ),
          ),
          if (showDateError) _errorMessage("Please select a date"),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: _textEditingController,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                Text(
                  widget.units,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          if (showValueError) _errorMessage("Please enter a valid value"),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            bool flag = true;

            if (date == null) {
              showDateError = true;
              flag = false;
            }

            if (_textEditingController.text.isEmpty) {
              showValueError = true;
              flag = false;
            }

            if (double.tryParse(_textEditingController.text) == null) {
              showValueError = true;
              flag = false;
            }

            if (flag) {
              Map<DateTime, double>? prevValues = widget.chartData!.data;

              AppLogger.print("Previous Values: ${prevValues.toString()}");

              if (prevValues == null) {
                prevValues = {
                  date!: double.tryParse(_textEditingController.text)!,
                };
              } else {
                prevValues[date!] =
                    double.tryParse(_textEditingController.text)!;
              }

              AppLogger.print("New Values: ${prevValues.toString()}");

              widget.onSave(GraphDataModel(data: prevValues));

              Navigator.pop(context);
            }
          },
          child: Text("Add"),
        ),
      ],
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
}
