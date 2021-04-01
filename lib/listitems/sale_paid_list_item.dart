
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:markarian_sales/model/sale_latest_10_model.dart';

class SalePaidListItem extends StatelessWidget{
  final SalePayment item;
  SalePaidListItem(this.item);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var customer=item.customerName==null?"":item.customerName;
    customer=customer+"(\$ "+item.paidAmount.toStringAsFixed(2)+" , "+item.paidAmountInReal.toStringAsFixed(2) +" រ)";
    return new Card(
      shape: RoundedRectangleBorder(),
      child: Padding(
          padding: new EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(customer, style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18.0
              ),
              ),

              new Text(item.strPaidData+"("+ item.saleNumber+")", style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15.0
              ),
              ),
            ],
          )),
    );
  }


}