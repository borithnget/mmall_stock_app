import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:markarian_sales/home/all_menu/payment_pakage/payment_activity.dart';
import 'package:markarian_sales/login_pk/login.dart';
import 'package:markarian_sales/model/commom_model.dart';
import 'package:markarian_sales/model/login_model.dart';
import 'package:markarian_sales/model/sale_latest_10_model.dart';
import 'package:markarian_sales/model/sale_payment_model.dart';
import 'package:markarian_sales/services/commom_service.dart';

import '../../../app.dart';

class PaymentingDetail extends StatefulWidget {
  final Sale sale;
  final bool _isFromPayment;
  PaymentingDetail(this.sale,this._isFromPayment, {Key key}) : super(key: key);

  @override
  PaymentingState createState() => PaymentingState();
}

class PaymentingState extends State<PaymentingDetail> {
  final _paymentUSDController = new TextEditingController(text: "");
  final _paymentKHRController = new TextEditingController(text: "");
  LoginResult _userLoggedIn = new LoginResult();

  List<String> titleItem = [
    'លេខកូដកម្ម៉ង់:',
    'ទឹកប្រាក់សរុប​ ដុល្លារ:',
    'ទឹកប្រាក់សរុប​ រៀល:',
    'ទឹកប្រាក់មិនទាន់បង់សរុប​ ដុល្លារ:',
    'ទឹកប្រាក់មិនទាន់បង់សរុប​ រៀល:',
    'ទឹកប្រាក់ដែលទទួល​ (\$):',
    'ទឹកប្រាក់ដែលទទួល​ (៛):',
    'ទឹកប្រាក់ដែលនៅសល់​ (\$):',
    'ទឹកប្រាក់ដែលនៅសល់​ (៛):'
  ];

  @override
  void initState() {
    super.initState();
    getUserInfo().then((result) {
      setState(() {
        _userLoggedIn = result;
        if (_userLoggedIn == null) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
            (Route<dynamic> route) => false,
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'ការបង់ប្រាក់',
          style: TextStyle(
              color: Color(0xFF303139),
              fontWeight: FontWeight.w700,
              fontSize: 17),
        ),
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back_ios_outlined,
            color: Color(0xFF2B3C57),
          ),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              SystemNavigator.pop();
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding:
            //       EdgeInsets.only(top: 11.5, left: 12, right: 12, bottom: 11.5),
            //   child: Text(
            //     'ALL DATA TABLE',
            //     style: TextStyle(color: Color(0xFF8E8E93), fontSize: 12),
            //   ),
            // ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(
                  color: Color(0xFFC6C6C9),
                  width: 0.5,
                ),
                top: BorderSide(
                  color: Color(0xFFC6C6C9),
                  width: 0.5,
                ),
              )),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 9,
                itemBuilder: (BuildContext context, int i) {
                  return ItemPaymenting(context, i, widget.sale);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, top: 27),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 40,
                    child: RaisedButton(
                      elevation: 0.0,
                      color: Color(0xFF1DA7EA),
                      onPressed: () {
                        //print("Usd ${_paymentUSDController.text} , khr ${_paymentKHRController.text}");
                        submitPaymentAPI(false, widget.sale.id);
                      },
                      child: Text(
                        'រក្សារទុក',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  SizedBox(
                    height: 40,
                    child: RaisedButton(
                      elevation: 0.0,
                      color: Color(0xFFFFC542),
                      onPressed: () {
                        submitPaymentAPI(true, widget.sale.id);
                      },
                      child: Text(
                        'រក្សារទុក និងបិទការបង់ប្រាក់',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget ItemPaymenting(BuildContext context, int index, Sale sale) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 5.5, bottom: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titleItem[index],
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF8E8E93),
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Visibility(
                  visible: index == 5
                      ? false
                      : index == 6
                          ? false
                          : index == 7
                              ? false
                              : index == 8
                                  ? false
                                  : true,
                  child: Text(
                    index == 0
                        ? sale.saleNumber
                        : index == 1
                            ? sale.totalAmount.toString()
                            : index == 2
                                ? sale.totalAmountKHR.toString()
                                : index == 3
                                    ? sale.totalOutstandingUSD.toString()
                                    : index == 4
                                        ? sale.totalOutstandingKHR.toString()
                                        : "",
                    style: TextStyle(
                      fontSize: 17,
                      color: index == 0 ? Color(0xFF007AFF) : Colors.black,
                    ),
                  ),
                ),
                Visibility(
                    visible: index == 5 ? true : false,
                    child: Container(
                      child: TextFormField(
                        controller: _paymentUSDController,
                        autofocus: false,
                        keyboardType: TextInputType.number,
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyle(color: Colors.black),
                        decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(5.0),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                        ),
                      ),
                    )),
                Visibility(
                    visible: index == 6 ? true : false,
                    child: Container(
                      child: TextFormField(
                        controller: _paymentKHRController,
                        autofocus: false,
                        keyboardType: TextInputType.number,
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyle(color: Colors.black),
                        decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(5.0),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                        ),
                      ),
                    )),
                Visibility(
                  visible: index == 7
                      ? true
                      : index == 8
                          ? true
                          : false,
                  child: Text(
                    index == 7
                        ? sale.totalOutstandingUSD.toString()
                        : index == 8
                            ? sale.totalOutstandingKHR.toString()
                            : "",
                    style: TextStyle(
                      fontSize: 17,
                      color: index == 0 ? Color(0xFF007AFF) : Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
              ],
            ),
          ),
          Visibility(
            visible: index == 8 ? false : true,
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Divider(
                height: 1,
                thickness: 1,
                color: Color(0xFFC6C6C9),
              ),
            ),
          )
        ],
      ),
    );
  }

  void submitPaymentAPI(bool _isAmountAdjustment, String _saleId) {
    double receivedInUSD = _paymentUSDController.text.isEmpty
        ? 0
        : double.parse(_paymentUSDController.text);
    double receivedinKHR = _paymentKHRController.text.isEmpty
        ? 0
        : double.parse(_paymentKHRController.text);
    //print("Usd ${receivedInUSD} , khr ${receivedinKHR}");
    PutSalePayment putSalePayment = new PutSalePayment(
        ReceivedUSD: receivedInUSD,
        ReceivedReal: receivedinKHR,
        AmountAdjustmentUSD: 0,
        AmountAdjustmentReal: 0,
        IsAmountAdjustment: _isAmountAdjustment,
        UserId: _userLoggedIn.id);

    putSalePaymentResponse(putSalePayment, _saleId).then((response) {
      print(response.body);
      if (response.body == "") {
        showAlertDialogFail(context, response.body);
      } else {
        final apiResponse = apiResponseFromJson(response.body);
        if (apiResponse.didError) {
          showAlertDialogFail(context, "ប្រតិបត្តិការមិនបានជោគជ័យ។");
        } else {
          if(widget._isFromPayment){
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => PaymentActivity()),
              (Route<dynamic> route) => false,
            );
          }else{
            Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => new App()));
          }
        }
      }
    });
  }

  showAlertDialogFail(BuildContext context, String _message) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () => Navigator.pop(context, false),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Fail"),
      content: Text(_message),
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
}
