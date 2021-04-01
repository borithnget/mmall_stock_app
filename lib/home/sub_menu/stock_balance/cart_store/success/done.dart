import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:markarian_sales/home/sub_menu/stock_balance/cart_store/success/invoice/getinvoice.dart';
import 'package:markarian_sales/home/sub_menu/stock_balance/stock_balance_class.dart';

class CheckOutSuccess extends StatefulWidget {
  final saleId;

  CheckOutSuccess(this.saleId,{Key key}):super(key: key);

  @override
  _CheckOutSuccessState createState() => _CheckOutSuccessState();
}

class _CheckOutSuccessState extends State<CheckOutSuccess> with AutomaticKeepAliveClientMixin {

  var text = "បង្កើតការកម្ម៉ង់ដោយជោគជ័យ";

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              height: 145,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/success_gif.gif",
                    height: 200,
                    width: 200,
                  ),
                  Text(
                    text,
                    style: TextStyle(
                        fontSize: 21,
                        color: Color(0xFF16191F),
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          // Spacer(),
          Container(
            height: 138,
            width: double.maxFinite,
            padding: EdgeInsets.only(left: 25, right: 25),
            child: Column(
              children: [
                ButtonTheme(
                  minWidth: 364.0,
                  height: 50.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  buttonColor: Color(0xFFFA242C),
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GetInvoice(widget.saleId)),
                      );
                    },
                    child: Text(
                      "បោះពុម្ពវិក័យបត្រ",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                ButtonTheme(
                  minWidth: 364.0,
                  height: 50.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    side: BorderSide(color: Color(0xFFFA242C)),
                  ),
                  buttonColor: Colors.white,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => StockbalanceClass()),
                            (Route<dynamic> route) => false,
                      );
                    },
                    child: Text(
                      "ត្រលប់ទៅកាន់ស្តុក",
                      style: TextStyle(
                        color: Color(0xFFFA242C),
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
