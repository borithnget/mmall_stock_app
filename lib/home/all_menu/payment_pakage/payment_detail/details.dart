import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:markarian_sales/home/all_menu/payment_pakage/paymenting/paymenting.dart';
import 'package:markarian_sales/model/sale_latest_10_model.dart';

class DetailPayment extends StatefulWidget {
  final Sale sale;

  DetailPayment(this.sale, {Key key}) : super(key: key);

  @override
  _DetailPaymentState createState() => _DetailPaymentState();
}

class _DetailPaymentState extends State<DetailPayment> {
  List<String> titleItem = [
    'កាលបរិច្ឆេទ',
    'លេខកូដកម្ម៉ង់',
    'លេខវិក័យបត្រ័',
    'អតិថិជន',
    'ទឹកប្រាក់សរុប ដុល្លារ',
    'ទឹកប្រាក់មិនទាន់បង់សរុប ដុល្លារ',
  ];

  final Sale sale;

  _DetailPaymentState({Key key, @required this.sale});

  @override
  Widget build(BuildContext context) {
    print("detail payment ${widget.sale.id}");

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'មើលលម្អិតការបង់ប្រាក់',
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
            //       EdgeInsets.only(top: 35.12, left: 12, right: 12, bottom: 9.5),
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
                itemCount: 6,
                itemBuilder: (BuildContext context, int i) {
                  return ItemDetailPayment(context, i, widget.sale);
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
                    child: RaisedButton.icon(
                      elevation: 0.0,
                      color: Color(0xFF1DA7EA),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PaymentingDetail(widget.sale,true)),
                        );
                      },
                      label: Text(
                        'បង់ប្រាក់',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      icon: Icon(
                        Icons.attach_money_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  SizedBox(
                    height: 40,
                    child: RaisedButton.icon(
                      elevation: 0.0,
                      color: Color(0xFFFA242C),
                      onPressed: () {},
                      label: Text(
                        'លុបការកម្ម៉ង់',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      icon: Icon(Icons.delete_outlined, color: Colors.white),
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

  Widget ItemDetailPayment(BuildContext context, int index, Sale sale) {
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
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (index == 1) {
                        print('view sale detail');
                      } else if (index == 3) {
                        print('view buyer detail');
                      }
                    });
                  },
                  child: Text(
                    index == 0
                        ? sale.strCreatedDate
                        : index == 1
                            ? sale.saleNumber
                            : index == 2
                                ? sale.invoiceNo
                                : index == 3
                                    ? sale.customerName
                                    : index == 4
                                        ? sale.totalAmount.toString()
                                        : index == 5
                                            ? sale.totalOutstandingUSD
                                                .toString()
                                            : "",
                    style: TextStyle(
                      fontSize: 17,
                      color: index == 1
                          ? Color(0xFF007AFF)
                          : index == 3
                              ? Color(0xFF007AFF)
                              : Colors.black,
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
            visible: index == 5 ? false : true,
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
}
