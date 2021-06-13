import 'package:flutter/material.dart';

class DataCard extends StatelessWidget {
  const DataCard({
    Key? key,
    required this.fields,
  }) : super(key: key);

  final List<DataField> fields;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: fields,
      ),
    );
  }
}

class DataField extends StatelessWidget {
  const DataField({Key? key, required this.name, required this.value})
      : super(key: key);

  final String name;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(name),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
