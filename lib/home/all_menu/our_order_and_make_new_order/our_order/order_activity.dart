import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:markarian_sales/home/all_menu/our_order_and_make_new_order/our_order/order_details/order_details.dart';
import 'package:markarian_sales/login_pk/login.dart';
import 'package:markarian_sales/model/login_model.dart';
import 'package:markarian_sales/model/sale_latest_10_model.dart';
import 'package:markarian_sales/services/commom_service.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class OrderActivity extends StatefulWidget {
  @override
  OrderActivityState createState() => OrderActivityState();
}

class OrderActivityState extends State<OrderActivity> {
  String _range;
  LoginResult _userLoggedIn=new LoginResult();
  List<Sale> saleLists=new List<Sale>();
  @override
  void initState() {
    _range = '';
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
        else{

        }
      });
    });

  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range =
            DateFormat('dd/MM/yyyy').format(args.value.startDate).toString() +
                ' - ' +
                DateFormat('dd/MM/yyyy')
                    .format(args.value.endDate ?? args.value.startDate)
                    .toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 15.4),
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                print('tis is');
              },
              child: Text(
                'កម្ម៉ង់ថ្មី',
                style: TextStyle(
                    color: Color(0xFF007AFF),
                    fontWeight: FontWeight.w700,
                    fontSize: 13),
              ),
            ),
          ),
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              color: Color(0xFF303139),
            ),
            Text(
              'បញ្ជីការកម្ម៉ង់',
              style: TextStyle(
                  color: Color(0xFF303139),
                  fontWeight: FontWeight.w700,
                  fontSize: 17),
            ),
          ],
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
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(
                    top: 11.12, left: 20, right: 20, bottom: 28),
                child: Column(
                  children: [
                    Container(
                      height: 37,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          color: Color(0xFFE4E3E3)),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.71),
                            child: Icon(
                              Icons.search_sharp,
                              color: Color(0xFFA3A3A3),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 13.22, right: 13.22),
                              child: TextField(
                                maxLines: 1,
                                decoration: new InputDecoration.collapsed(
                                  hintText: 'ស្វែងរក',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    fontSize: 15.0,
                                    color: Color(0xFFA3A3A3),
                                  ),
                                ),
                              ),
                            ),
                            flex: 1,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              child: Container(
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Color(0xFF8F9297)),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 7),
                                      child: Icon(
                                        Icons.calendar_today,
                                        size: 24,
                                      ),
                                    ),
                                    VerticalDivider(
                                      width: 1,
                                      color: Color(0xFFAFAFAF),
                                    ),
                                    Expanded(
                                      child: Container(
                                        width: double.maxFinite,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 14),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                _range,
                                                style: TextStyle(
                                                  color: Color(0xFF16191F),
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.clip,
                                              ),
                                            ),
                                            Icon(
                                              Icons
                                                  .keyboard_arrow_down_outlined,
                                              color: Color(0xFFAFAFAF),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return dialogWidget(context);
                                    });
                              },
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Container(
                            height: 45,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xFFE4E3E3)),
                            child: Ink(
                              decoration: ShapeDecoration(
                                color: Color(0xFFE4E3E3),
                                shape: CircleBorder(),
                              ),
                              child: IconButton(
                                icon: Icon(Icons.search),
                                color: Color(0xFFA3A3A3),
                                onPressed: () {
                                  print("Search date");
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              //list
              Container(
                height: 45,
                color: Color(0xFFFA242C),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Container(
                        width: 117,
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
                        width: 129,
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
                        width: 128,
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
                  return OrderListDetails(ctxt, index);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget OrderListDetails(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        print("Top data : " + index.toString());
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OrderDetail()),
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
                    width: 117,
                    padding: EdgeInsets.only(left: 8, right: 8),
                    alignment: Alignment.center,
                    child: Text(
                      '25/01/2021 15:35 PM',
                      style: TextStyle(fontSize: 13),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Container(
                    width: 129,
                    alignment: Alignment.center,
                    child: Text(
                      'VannDa',
                      style: TextStyle(fontSize: 13),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Container(
                    width: 128,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '17.00',
                          style: TextStyle(fontSize: 13),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Color(0xFFFF575F)),
                          padding: EdgeInsets.all(1),
                          child: Text(
                            'PENDING',
                            style: TextStyle(fontSize: 8, color: Colors.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
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

  Widget dialogWidget(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: SfDateRangePicker(
        headerHeight: 100,
        view: DateRangePickerView.month,
        headerStyle: DateRangePickerHeaderStyle(
            backgroundColor: Color(0xFF7fcd91),
            textAlign: TextAlign.center,
            textStyle: TextStyle(
              fontStyle: FontStyle.normal,
              fontSize: 25,
              letterSpacing: 5,
              color: Color(0xFFff5eaea),
            )),
        enablePastDates: false,
        onSelectionChanged: _onSelectionChanged,
        selectionMode: DateRangePickerSelectionMode.range,
      ),
    );
  }
}
