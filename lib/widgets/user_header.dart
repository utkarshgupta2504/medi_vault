import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medi_vault/models/user_model.dart';
import 'package:medi_vault/utils/global.dart';
import 'package:medi_vault/utils/preferences.dart';

import 'circle_image.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({
    Key? key,
    required this.user,
    required this.isEditScreen,
    this.showPicker,
  }) : super(key: key);

  final UserModel user;
  final bool isEditScreen;
  final Function? showPicker;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            DateFormat("MMMM dd, yyyy\nEEEE").format(DateTime.now()),
            textAlign: TextAlign.center,
          ),
        ),
        Stack(
          children: [
            CircleImage(
              size: 50,
              imageString: Preference.getString(Global.profilePhoto, def: null),
            ),
            if (isEditScreen)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.blueGrey,
                  ),
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: IconButton(
                      iconSize: 15,
                      // padding: EdgeInsets.all(10),
                      color: Colors.white,
                      icon: Icon(
                        Icons.camera_alt,
                      ),
                      onPressed: () {
                        showPicker!(context);
                      },
                    ),
                  ),
                ),
              ),
          ],
        ),
        Expanded(
          child: Text(
            user.name ?? "--",
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
