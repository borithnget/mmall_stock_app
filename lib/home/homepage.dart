import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:markarian_sales/home/dashboard_last10/dashboard_last10.dart';
import 'package:markarian_sales/home/drawer.dart';
import 'package:markarian_sales/home/tablecontrollorder/control_order.dart';
import 'package:markarian_sales/login_pk/login.dart';
import 'package:markarian_sales/model/login_model.dart';
import 'package:markarian_sales/services/commom_service.dart';

class HomeScreen extends StatefulWidget {
  String title;
  HomeScreen({this.title});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
// TabController to control and switch tabs
  TabController _tabController;
  LoginResult _userLoggedIn=new LoginResult();
  // Current Index of tab
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    getUserInfo().then((result){

      setState(() {
        _userLoggedIn=result;
        if(_userLoggedIn==null){
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
                (Route<dynamic> route) => false,
          );
        }
      });
    });

    _tabController =
        new TabController(vsync: this, length: 2, initialIndex: _currentIndex);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: DrawerClass(),
      ),
      backgroundColor: Colors.white,
      body: Dftc(),
    );
  }

  //defaulttabcontroller
  Widget Dftc() {
    return DefaultTabController(
      length: 2,
      child: new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Container(
            height: 32,
            width: 32,
            margin: EdgeInsets.all(6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xFFF9F3F3)),
            child: IconButton(
              icon: Icon(
                Icons.menu,
                color: Color(0xFFFB4744),
              ),
              onPressed: () {
                _scaffoldKey.currentState.openDrawer();
              },
            ),
          ),
          centerTitle: true,
          title: Text(
            "Dashboard",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Color(0xFF303139),
            ),
          ),
          elevation: 0.0,
          bottom: PreferredSize(
            child: TabBar(
                isScrollable: true,
                unselectedLabelColor: Color(0xFF16191F),
                indicatorColor: Color(0xFFFA242C),
                labelColor: Color(0xFFFA242C),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 3,
                tabs: [
                  Tab(
                    child: Text(
                      'ផ្ទាំងប្រតិបត្តិការ ការកម៉្មង់ ១០ ចុងក្រោយ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'ផ្ទាំងគ្រប់គ្រងការកម្ម៉ង់',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ]),
            preferredSize: Size.fromHeight(50.0),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            DashboardLast10(),
            ControlOrderTable(),
          ],
        ),
      ),
    );
  }
}
