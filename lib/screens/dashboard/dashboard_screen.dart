import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:medi_vault/models/user_model.dart';
import 'package:medi_vault/screens/dashboard/analytics/analytics_screen.dart';
import 'package:medi_vault/screens/dashboard/information/information_screen.dart';
import 'package:medi_vault/widgets/my_drawer.dart';
import 'package:medi_vault/widgets/user_header.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  List<Widget> _tabs = [
    Tab(
      text: "Analytics",
    ),
    Tab(
      text: "Information",
    ),
  ];

  late TabController _tabController;

  late UserModel user;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Medi Vault"),
      ),
      drawer: MyDrawer(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 24,
          ),
          child: Column(
            children: [
              UserHeader(isEditScreen: false),
              SizedBox(
                height: 10,
              ),
              TabBar(
                tabs: _tabs,
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.black,
                labelPadding: EdgeInsets.symmetric(horizontal: 8),
                dragStartBehavior: DragStartBehavior.down,
              ),
              Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    AnalyticsScreen(),
                    InformationScreen(),
                  ],
                  controller: _tabController,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
