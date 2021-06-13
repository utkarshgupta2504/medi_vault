import 'package:flutter/material.dart';
import 'package:medi_vault/models/medication_model.dart';
import 'package:medi_vault/models/vaccination_model.dart';
import 'package:medi_vault/widgets/no_data_widget.dart';
import 'package:medi_vault/widgets/user_header.dart';

class InformationDetailScreen extends StatelessWidget {
  const InformationDetailScreen(
      {Key? key,
      required this.createCard,
      required this.informationList,
      required this.title})
      : super(key: key);

  final String title;
  final Widget Function(dynamic) createCard;
  final List<dynamic>? informationList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 24,
            ),
            UserHeader(isEditScreen: false),
            Expanded(
              child: informationList == null || informationList!.isEmpty
                  ? NoDataWidget()
                  : Container(
                      color: Colors.grey[200],
                      child: ListView(
                        children:
                            informationList!.map((e) => createCard(e)).toList(),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
