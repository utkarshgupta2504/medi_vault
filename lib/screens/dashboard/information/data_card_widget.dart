import 'package:flutter/material.dart';

class DataCard extends StatelessWidget {
  const DataCard({
    Key? key,
    required this.fields,
  }) : super(key: key);

  final List<DataField> fields;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: fields
                .asMap()
                .entries
                .map<Column>((entry) => Column(
                      children: [
                        entry.value,
                        if (entry.key != fields.length - 1) Divider(),
                      ],
                    ))
                .toList(),
          ),
        ),
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
          Text(
            name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
