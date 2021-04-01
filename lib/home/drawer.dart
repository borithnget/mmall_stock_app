import 'package:flutter/material.dart';
import 'package:markarian_sales/login_pk/login.dart';
import 'package:markarian_sales/model/login_model.dart';
import 'package:markarian_sales/services/commom_service.dart';
import 'all_menu/our_order_and_make_new_order/our_order/order_activity.dart';
import 'package:markarian_sales/home/all_menu/payment_pakage/payment_activity.dart';
import 'package:markarian_sales/home/sub_menu/stock_balance/stock_balance_class.dart';
import 'all_menu/our_order_and_make_new_order/our_order_and_make_new_order.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class DrawerClass extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("ផ្ទាំងគ្រប់គ្រង", Icons.house_rounded),
    new DrawerItem("ការបញ្ជារទិញ", Icons.shopping_cart),
    new DrawerItem("កម្ម៉ង់", Icons.shopping_bag),
    new DrawerItem("ទូទាត់ប្រាក់", Icons.money),
    new DrawerItem("ស្តុក", Icons.sticky_note_2),
    new DrawerItem("របាយការណ៏", Icons.report),
    new DrawerItem("អតិថិជន", Icons.people),
    new DrawerItem("E-Gallary", Icons.image),
    new DrawerItem("ការកំណត់", Icons.settings),
    new DrawerItem("ការកំណត់មុនសំរាប់ផលិតផល", Icons.settings_applications),
    new DrawerItem("Logout", Icons.logout),
  ];
  @override
  _DrawerClassState createState() => _DrawerClassState();
}

class _DrawerClassState extends State<DrawerClass> {
  int _selectedDrawerIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    //Navigator.of(context).pop();
    switch (index) {
      case 0:
        print('index 0');
        break;
      case 1:
        print('index 1');
        break;
      case 2:
        print('index 2');
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => BothOrder()));
        break;
      case 3:
        print('index 3');
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => PaymentActivity()));
        break;
      case 4:
        print('index 4');
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => StockbalanceClass()));
        break;
      case 5:
        print('index 5');
        break;
      case 6:
        print('index 6');
        break;
      case 7:
        print('index 7');
        break;
      case 8:
        print('index 8');
        break;
      case 9:
        print('index 9');
        break;
      case 10:
        //Log out
        //print('index 10 Log out.');
        showAlertDialog(context);
        break;
      default:
        break;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Drawer(
        child: drawer(),
      ),
    );
  }

  Widget drawer() {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
        Column(
          children: [
            new ListTile(
              leading: new Icon(d.icon,
                  color: i == _selectedDrawerIndex
                      ? Color(0xFFFFFFFF)
                      : Color(0xFF16191F)),
              title: new Text(
                d.title,
                style: TextStyle(
                    fontSize: 15,
                    color: i == _selectedDrawerIndex
                        ? Color(0xFFFFFFFF)
                        : Color(0xFF16191F)),
              ),
              selected: i == _selectedDrawerIndex,
              onTap: () => _onSelectItem(i),
              selectedTileColor: Color(0xFFFF575F),
              hoverColor: Colors.green,
              focusColor: Colors.red,
            ),
          ],
        ),
      );
    }
    return new Drawer(
      child: new Column(
        children: <Widget>[
          new PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(
              actions: [
                ButtonTheme(
                  buttonColor: Color(0xFFFA242C),
                  minWidth: 70.0,
                  height: 100.0,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
              automaticallyImplyLeading: false,
              backgroundColor: Color(0xFFFA242C),
            ),
          ),
          SingleChildScrollView(
            child: IntrinsicHeight(
              child: new Column(
                children: drawerOptions,
              ),
            ),
          )
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("ទេ"),
      onPressed:  () => Navigator.of(context).pop(),
    );
    Widget continueButton = FlatButton(
      child: Text("បាទ/ចាស៎"),
      onPressed:  () {
        saveUserInfo(null);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
              (Route<dynamic> route) => false,
        );
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("ចាកចេញ"),
      content: Text("តើអ្នកពិតជាចង់ចាកចេញពីកម្មវិធីមែនទេ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return alert;
    //   },
    // );
    showDialog(context: _scaffoldKey.currentContext ,builder: (context){
      return alert;
    });

  }

}
