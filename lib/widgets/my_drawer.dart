import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:medi_vault/routes/app_router.gr.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              ListView(
                shrinkWrap: true,
                children: [
                  drawerItem(
                    "Edit Profile",
                    () {
                      AutoRouter.of(context).push(EditProfileScreenRoute());
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  drawerItem(String text, Function onClickItem) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: ListTile(
            title: Text(
              text,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            onTap: () => onClickItem(),
          ),
        ),
        Divider(
          color: Colors.grey,
          height: 7,
          thickness: 0.5,
          indent: 15,
          endIndent: 15,
        ),
      ],
    );
  }
}
