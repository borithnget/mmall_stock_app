import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:markarian_sales/home/dashboard_last10/detail_item_dashboard/detail.dart';
import 'package:markarian_sales/model/sale_latest_10_model.dart';
import 'package:markarian_sales/services/sale_lastest10_service.dart';

class Last10Class extends StatefulWidget {
  @override
  _Last10ClassState createState() => _Last10ClassState();
}

class _Last10ClassState extends State<Last10Class> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 13),
            child: Container(
              width: double.maxFinite,
              height: 30,
              child: CupertinoSegmentedControl<int>(
                borderColor: Color(0xFFFA242C),
                children: NameWidgets,
                selectedColor: Color(0xFFFA242C),
                onValueChanged: (int val) {
                  setState(() {
                    sharedValue = val;
                  });
                },
                groupValue: sharedValue,
              ),
            ),
          ),
          Container(
            child: bodies[sharedValue],
          ),
        ],
      ),
    );
  }

  //DataTopDashboard
  int sharedValue = 0;
  final Map<int, Widget> NameWidgets = const <int, Widget>{
    0: Text(
      'កម្ម៉ងមិនទាន់បង់ប្រាក់',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
    1: Text(
      'ការបង់ប្រាក់',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
    2: Text(
      'អតិថិជនថ្មី',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
  };
  List<Widget> bodies = [
    giveUnpaidorders("Unpaid orders"),
    givePayment("Payment"),
    giveNewcustomers("New customers")
  ];
  static Widget giveUnpaidorders(String yourText) {
    return latest10OutstandingSaleWidget();
  }

  static Widget givePayment(String yourText) {
    return latest10SalePaymentWidget();
  }

  static Widget giveNewcustomers(String yourText) {
    return latest10SaleCustomerWidget();
  }

  static Widget latest10OutstandingSaleWidget(){
    return FutureBuilder<SaleResponse>(
        future: getSaleOutstandingLatest10(),
        builder: (context, snapshot) {
          //callAPI();
          if(snapshot.connectionState == ConnectionState.done) {

            if(snapshot.hasError){
              return Text("Error");
            }

            //return Text('Title from Post JSON : ${snapshot.data.itemsCount}');
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 45,
                    color: Color(0xFFFA242C),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          flex: 3,
                          child: Container(
                            width: 133,
                            alignment: Alignment.center,
                            child: Text(
                              'កាលបរិច្ជេទ',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        VerticalDivider(
                          color: Colors.white,
                        ),
                        Flexible(
                          flex: 3,
                          child: Container(
                            width: 139,
                            alignment: Alignment.center,
                            child: Text(
                              'អតិថិជន',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        VerticalDivider(
                          color: Colors.white,
                        ),
                        Flexible(
                          flex: 3,
                          child: Container(
                            width: 101,
                            alignment: Alignment.center,
                            child: Text(
                              'ទឹកប្រាក់សរុប(\$)',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return TopDataDashboard(ctxt, index,snapshot.data.model[index]);
                    },
                  ),
                ],
              ),
            );
          }
          else
            return CircularProgressIndicator();
        }
    );
  }
  static Widget latest10SalePaymentWidget(){
    return FutureBuilder<SalePaymentResponse>(
        future: getSalePaymentLatest10(),
        builder: (context, snapshot) {
          //callAPI();
          if(snapshot.connectionState == ConnectionState.done) {

            if(snapshot.hasError){
              return Text("Error");
            }

            //return Text('Title from Post JSON : ${snapshot.data.itemsCount}');
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 45,
                    color: Color(0xFFFA242C),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          flex: 3,
                          child: Container(
                            width: 133,
                            alignment: Alignment.center,
                            child: Text(
                              'កាលបរិច្ជេទ',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        VerticalDivider(
                          color: Colors.white,
                        ),
                        Flexible(
                          flex: 3,
                          child: Container(
                            width: 139,
                            alignment: Alignment.center,
                            child: Text(
                              'អតិថិជន',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        VerticalDivider(
                          color: Colors.white,
                        ),
                        Flexible(
                          flex: 3,
                          child: Container(
                            width: 101,
                            alignment: Alignment.center,
                            child: Text(
                              'ទឹកប្រាក់សរុប(\$)',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return dataRowSalePaymentWidget(ctxt, index,snapshot.data.model[index]);
                    },
                  ),
                ],
              ),
            );
          }
          else
            return CircularProgressIndicator();
        }
    );
  }
  static Widget latest10SaleCustomerWidget(){
    return FutureBuilder<SaleCustomerLatest10>(
        future: getSaleCustomerLatest10(),
        builder: (context, snapshot) {
          //callAPI();
          if(snapshot.connectionState == ConnectionState.done) {

            if(snapshot.hasError){
              return Text("Error");
            }

            //return Text('Title from Post JSON : ${snapshot.data.itemsCount}');
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 45,
                    color: Color(0xFFFA242C),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          flex: 3,
                          child: Container(
                            width: 133,
                            alignment: Alignment.center,
                            child: Text(
                              'អតិថិជន',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        VerticalDivider(
                          color: Colors.white,
                        ),
                        Flexible(
                          flex: 3,
                          child: Container(
                            width: 139,
                            alignment: Alignment.center,
                            child: Text(
                              'កម្ម៉ង់សរុប',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        VerticalDivider(
                          color: Colors.white,
                        ),
                        Flexible(
                          flex: 3,
                          child: Container(
                            width: 101,
                            alignment: Alignment.center,
                            child: Text(
                              'ទឹកប្រាក់សរុប(\$)',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return dataRowSaleCustomerWidget(ctxt, index,snapshot.data.model[index]);
                    },
                  ),
                ],
              ),
            );
          }
          else
            return CircularProgressIndicator();
        }
    );
  }

}

//unpaid payment and New customers item
Widget TopDataDashboard(BuildContext context, int index,Sale sale) {
  return GestureDetector(
    onTap: () {
      print("Top data : " + index.toString());
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Details()),
      );
    },
    child: Column(
      children: [
        Container(
          height: 44,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 3,
                child: Container(
                  width: 133,
                  padding: EdgeInsets.only(left: 8, right: 8),
                  alignment: Alignment.center,
                  child: Text(
                    sale.strCreatedDate,
                    style: TextStyle(fontSize: 13),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Container(
                  width: 139,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    sale.customerName==null?"":sale.customerName,
                    style: TextStyle(fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Container(
                  width: 101,
                  alignment: Alignment.center,
                  child: Text(
                    sale.totalAmount.toString(),
                    style: TextStyle(fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: Color(0xFFFA242C),
          thickness: 1,
          height: 1,
        ),
      ],
    ),
  );
}
Widget dataRowSalePaymentWidget(BuildContext context, int index,SalePayment salePayment) {
  return GestureDetector(
    onTap: () {
      print("Top data : " + index.toString());
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Details()),
      );
    },
    child: Column(
      children: [
        Container(
          height: 44,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 3,
                child: Container(
                  width: 133,
                  padding: EdgeInsets.only(left: 8, right: 8),
                  alignment: Alignment.center,
                  child: Text(
                    salePayment.strPaidData,
                    style: TextStyle(fontSize: 13),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Container(
                  width: 139,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    salePayment.customerName,
                    style: TextStyle(fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Container(
                  width: 101,
                  alignment: Alignment.center,
                  child: Text(
                    salePayment.paidAmount.toString(),
                    style: TextStyle(fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: Color(0xFFFA242C),
          thickness: 1,
          height: 1,
        ),
      ],
    ),
  );
}
Widget dataRowSaleCustomerWidget(BuildContext context, int index,Customer customer) {
  return GestureDetector(
    onTap: () {
      print("Top data : " + index.toString());
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Details()),
      );
    },
    child: Column(
      children: [
        Container(
          height: 44,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 3,
                child: Container(
                  width: 133,
                  padding: EdgeInsets.only(left: 8, right: 8),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    customer.customerName==null?"":customer.customerName,
                    style: TextStyle(fontSize: 13),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Container(
                  width: 139,
                  alignment: Alignment.center,
                  child: Text(
                    customer.totalOrders.toString(),
                    style: TextStyle(fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Container(
                  width: 101,
                  alignment: Alignment.center,
                  child: Text(
                    customer.totalOrderAmounts.toString(),
                    style: TextStyle(fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: Color(0xFFFA242C),
          thickness: 1,
          height: 1,
        ),
      ],
    ),
  );
}
