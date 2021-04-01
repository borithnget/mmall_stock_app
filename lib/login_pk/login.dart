import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:markarian_sales/home/app.dart';
import 'package:markarian_sales/home/homepage.dart';
import 'package:markarian_sales/model/login_model.dart';
import 'package:markarian_sales/services/commom_service.dart';
import 'package:markarian_sales/services/login_service.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _usernameController=new TextEditingController(text: "");
  final _passwordController=new TextEditingController(text:"");
  LoginResult _userLoggedIn=new LoginResult();

  showAlertDialogLoginFail(BuildContext context){
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () => Navigator.pop(context, false),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Login Fail"),
      content: Text("Invalid User"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    super.initState();

    getUserInfo().then((result){
      //print(result.id);
      _userLoggedIn=result;
      if(_userLoggedIn==null)
        print("cannot save shared preference.");
      else {
        //print("saved shared preference ${_userLoggedIn.id} .");
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => App()),
              (Route<dynamic> route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    final logo = Hero(
      tag: 'logo',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/markarianmall_pf.jpg'),
      ),
    );

    /*
    final username = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: 'myname123',
      controller: _usernameController,
      decoration: InputDecoration(
        hintText: 'Username',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    */


    final password = TextFormField(
      controller: _passwordController,
      autofocus: false,
      //initialValue: '1234',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          print('Username ${_usernameController.text}');
          /*
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
          */
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Login', style: TextStyle(color: Colors.white)),
      ),
    );


    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            //username,
            TextFormField(
              controller: _usernameController,
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              //initialValue: 'myname123',
              decoration: InputDecoration(
                hintText: 'Username',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            //loginButton,
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                onPressed: () {
                  //print('Username ${_usernameController.text} Password ${_passwordController.text}');

                  Login login=Login(
                    Username: _usernameController.text,
                    Password: _passwordController.text
                  );
                  createLogin(login).then((response){
                    if(response.body==""){
                      //print("Invalid User");
                      showAlertDialogLoginFail(context);
                    }else{

                      final loginResult=loginResultFromJson(response.body);
                      //print("userid ${loginResult.id}");
                      saveUserInfo(loginResult);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => App()),
                            (Route<dynamic> route) => false,
                      );
                    }

                    /*
                    if(response.statusCode>200){
                      print(response.body);
                    }
                    */

                  }).catchError((error){
                    print('error : $error');
                    showAlertDialogLoginFail(context);
                  });
                },
                padding: EdgeInsets.all(12),
                color: Colors.lightBlueAccent,
                child: Text('Login', style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }
}
