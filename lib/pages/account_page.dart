import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:markarian_sales/login_pk/login.dart';
import 'package:markarian_sales/main.dart';
import 'package:markarian_sales/model/commom_model.dart';
import 'package:markarian_sales/model/login_model.dart';
import 'package:markarian_sales/model/profile.dart';
import 'package:markarian_sales/pages/payment_page.dart';
import 'package:markarian_sales/services/commom_service.dart';
import 'package:markarian_sales/test/app_data.dart';

class AccountPage extends StatefulWidget{
  // AccountPage({this.color,this.title,this.onPush});
  // final MaterialColor color;
  // final String title;
  // final ValueChanged<int> onPush;

  @override
  State<StatefulWidget> createState() =>_UserProfilePageState();

}

class _UserProfilePageState extends State<AccountPage> with AutomaticKeepAliveClientMixin {
  Profile profile;
  LoginResult _userLoggedIn=LoginResult();
  EmployeeModel _employee=EmployeeModel();
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    profile = AppData.profiles[0];

    super.initState();
    getUserInfo().then((result){
      setState(() {
        _userLoggedIn=result;
        getEmployeeDetailResponse(_userLoggedIn.id);
      });
    });
  }

  void getEmployeeDetailResponse(String userid) async{
    getEmployeeDetailbyUserIdResponse(userid).then((response){
      setState(() {
        _employee=response.model;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LocalGalleryTab(_employee,_userLoggedIn.id),

    );
  }

}

class HeaderSection extends StatelessWidget {
  final EmployeeModel profile;
  HeaderSection({
    this.profile,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _fullname=(profile.firstName==null?"":profile.firstName)+" "+(profile.lastName==null?"":profile.lastName);
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 110,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              image: DecorationImage(image:NetworkImage('https://1409791524.rsc.cdn77.org/data/images/full/570093/red-velvet-irene-s-return-to-the-public-eye-draws-mixed-reactions.jpg'), fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: 20),
          Container(
            alignment: Alignment.center,
            child: Text(
              _fullname,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ),
          // SizedBox(height: 20),
          // Container(
          //   margin: EdgeInsets.symmetric(horizontal: 20),
          //   alignment: Alignment.center,
          //   child: Text(
          //     profile.subtitle,
          //     textAlign: TextAlign.center,
          //   ),
          // ),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      profile.totalSale.toString(),
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text('ចំនួនលក់')
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      profile.totalSaleAmount.toString(),
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text('ទឹកប្រាក់')
                  ],
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}

class LocalGalleryTab extends StatefulWidget {
  EmployeeModel profile;
  final String userId;
  LocalGalleryTab(this.profile,this.userId, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LocalGalleryState();
  }
}

class _LocalGalleryState extends State<LocalGalleryTab> {

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: new Center(
      child: new RefreshIndicator(
        // child: ListView(
        //   children: List.generate(50,  (f) => Text("Item $f")),
        // ),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 750),
              transitionBuilder: (Widget child, Animation<double> animation) => SlideTransition(
                child: child,
                position: Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0)).animate(animation),
              ),
              child: HeaderSection(widget.profile),
            ),
            SizedBox(height: 40),
            Card( //                           <-- Card widget
              child: ListTile(
                leading: Icon(Icons.payment_outlined),
                title: Text('គណនេយ្យរបស់ខ្ញុំ'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentPage(widget.userId)),
                  );
                },
              ),
            ),
            Card( //                           <-- Card widget
              child: ListTile(
                leading: Icon(Icons.payment_outlined),
                title: Text('ប្រវត្តិការបង់ប្រាក់'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentPage(widget.userId)),
                  );
                },
              ),
            ),
            Card( //                           <-- Card widget
              child: ListTile(
                leading: Icon(Icons.report),
                title: Text('របាយការណ៍'),
                onTap: () {
                  print('Star');
                },
              ),
            ),
            Card( //                           <-- Card widget
              child: ListTile(
                leading: Icon(Icons.logout),
                title: Text('ចាកចេញ'),
                onTap: () {
                  print('Star');
                  showAlertDialog(context);
                },
              ),
            )

          ],
        ),
        onRefresh: _refreshLocalGallery,
      ),
    ));
  }

  Future<Null> _refreshLocalGallery() async{
    //print('refreshing stocks...');
    getEmployeeDetailbyUserIdResponse(widget.userId).then((response){
      setState(() {
        widget.profile=response.model;
      });
    });
  }

  Widget HeaderSection(EmployeeModel profile){
    var _fullname=(profile.firstName==null?"":profile.firstName)+" "+(profile.lastName==null?"":profile.lastName);
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 110,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              image: DecorationImage(image:NetworkImage('https://1409791524.rsc.cdn77.org/data/images/full/570093/red-velvet-irene-s-return-to-the-public-eye-draws-mixed-reactions.jpg'), fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: 20),
          Container(
            alignment: Alignment.center,
            child: Text(
              _fullname,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      profile.totalSale.toString(),
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text('ចំនួនលក់')
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      profile.totalSaleAmount.toString(),
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text('ទឹកប្រាក់')
                  ],
                ),

              ],
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
      onPressed:  () => Navigator.of(context, rootNavigator: true).pop(),
    );
    Widget continueButton = FlatButton(
      child: Text("បាទ/ចាស៎"),
      onPressed:  () {

        saveUserInfo(null);

        Navigator.of(context, rootNavigator: true).pop();
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => LoginPage()),
        //       (Route<dynamic> route) => false,
        // );
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => LoginPage(),
        //   ),
        // );
        // runApp(MyApp());
        Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => new LoginPage()));
        // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        //     LoginPage()), (Route<dynamic> route) => false);
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
    //show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );


  }
}