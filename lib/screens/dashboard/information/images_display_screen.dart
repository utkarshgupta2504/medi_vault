import 'package:flutter/material.dart';
import 'package:medi_vault/utils/image_utils.dart';
import 'package:medi_vault/widgets/no_data_widget.dart';
import 'package:medi_vault/widgets/user_header.dart';

class ImagesDisplayScreen extends StatelessWidget {
  const ImagesDisplayScreen(
      {Key? key, required this.title, required this.imagesList})
      : super(key: key);

  final String title;
  final List<dynamic>? imagesList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 24,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: UserHeader(isEditScreen: false),
          ),
          SizedBox(
            height: 16,
          ),
          imagesList == null || imagesList!.isEmpty
              ? Expanded(
                  child: NoDataWidget(),
                )
              : Expanded(
                  child: Container(
                    color: Colors.grey[300],
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: ListView(
                      children: imagesList!
                          .map(
                            (e) => Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 8.0),
                              child: Card(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                    vertical: 8.0,
                                  ),
                                  child: Image.memory(
                                      ImageUtility.dataFromBase64String(e)),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
