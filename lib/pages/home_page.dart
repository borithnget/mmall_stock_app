import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loadmore/loadmore.dart';
import 'package:markarian_sales/home/all_menu/our_order_and_make_new_order/our_order/order_details/detail_item_select/view_sale_detail.dart';
import 'package:markarian_sales/home/all_menu/our_order_and_make_new_order/our_order/order_details/order_details.dart';
import 'package:markarian_sales/login_pk/login.dart';
import 'package:markarian_sales/model/login_model.dart';
import 'package:markarian_sales/model/sale_latest_10_model.dart';
import 'package:markarian_sales/services/commom_service.dart';
import 'package:markarian_sales/services/sale_lastest10_service.dart';
import 'package:markarian_sales/utils/conection_state_singleton.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class HomePage extends StatefulWidget {
  HomePage({this.color, this.title, this.onPush});
  final MaterialColor color;
  final String title;
  final ValueChanged<int> onPush;

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
  String _range;
  LoginResult _userLoggedIn = new LoginResult();
  List<Sale> saleLists = new List<Sale>();
  int _pageSize = 0;
  String _dateFrom = '', _dateTo = '';

  StreamSubscription _connectionChangeStream;
  bool isOffline = false;
  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOffline = !hasConnection;
      if(isOffline){
        //_getSaleListByUserAndDateRange();
      }
      print("internet connection $isOffline");
    });
  }

  ScrollController _scrollController = new ScrollController();
  @override
  void initState() {
    super.initState();
    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    _connectionChangeStream =
        connectionStatus.connectionChange.listen(connectionChanged);

    _range = DateFormat('dd/MM/yyyy').format(DateTime.now().subtract(Duration(days: 12))).toString() +
        ' - ' +
        DateFormat('dd/MM/yyyy').format(DateTime.now()).toString();
    _dateFrom = DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 12))).toString();
    _dateTo = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
    //
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
        else{
         initialSaleListByUserAndDateRange();
        }
      });
    });

  }

  // void initialSaleListByUserAndDateRange() async{
  //   getSaleListbyUserAndDateRange(_userLoggedIn.id, _dateFrom, _dateTo).then((result){
  //     setState(() {
  //       saleLists=result.model;
  //       _pageSize=result.pageSize;
  //     });
  //   });
  // }

  // Future<void> _getSaleListByUserAndDateRange() async{
  //   setState(() {
  //     _range = DateFormat('dd/MM/yyyy').format(DateTime.now().subtract(Duration(days: 12))).toString() +
  //         ' - ' +
  //         DateFormat('dd/MM/yyyy')
  //             .format(DateTime.now())
  //             .toString();
  //     _dateFrom=DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 12))).toString();
  //     _dateTo=DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
  //     initialSaleListByUserAndDateRange();
  //   });
  // }

  // void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
  //   setState(() {
  //     if (args.value is PickerDateRange) {
  //       setState(() {
  //         _range =
  //             DateFormat('dd/MM/yyyy').format(args.value.startDate).toString() +
  //                 ' - ' +
  //                 DateFormat('dd/MM/yyyy')
  //                     .format(args.value.endDate ?? args.value.startDate)
  //                     .toString();
  //         _dateFrom =
  //             DateFormat('yyyy-MM-dd').format(args.value.startDate).toString();
  //         _dateTo = DateFormat('yyyy-MM-dd')
  //             .format(args.value.endDate ?? args.value.startDate)
  //             .toString();
  //       });
  //     }
  //   });
  //   //print(_range);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          widget.title,
        ),
        backgroundColor: widget.color,
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
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 13),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: RefreshIndicator(
          onRefresh: _refreshLocalGallery,
          child: Column(
            children: [
              Container(
                color: Colors.white,
                padding:
                    EdgeInsets.only(top: 11.12, left: 20, right: 20, bottom: 28),
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
                                onSubmitted: (value){
                                  _filterSaleListByCustomerNameandSaleNumber(value);
                                },
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
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 14),
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
                                              Icons.keyboard_arrow_down_outlined,
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
                                  getSaleListbyUserAndDateRange(_userLoggedIn.id, _dateFrom, _dateTo).then((result) {
                                    setState(() {
                                      saleLists = result.model;
                                      _pageSize = result.pageSize;
                                    });
                                  });
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
              Expanded(
                child:saleLists.length==0?getNoDataWidget() :ListView.builder(
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemCount: saleLists.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    if (index == saleLists.length) {
                      return SizedBox(
                        height: 50,
                        child: CupertinoActivityIndicator(),
                      );
                    }
                    return orderDetailHomePage(
                        context, index, saleLists[index]);
                  },
                ),
                // child: RefreshIndicator(
                //   onRefresh: _refreshLocalGallery,
                //
                // ),
              ),
            ],
          ),

          //onRefresh: _refreshLocalGallery,
        )

      ),
    );
  }

  Future<Null> _refreshLocalGallery() async{
    //print('refreshing stocks...');
    _getSaleListByUserAndDateRange();

  }
  Widget orderDetailHomePage(BuildContext context, int index, Sale sale) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ViewSaleDetail(sale.id)),
            );
          },
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              sale.strCreatedDate,
                              style: TextStyle(
                                color: Color(0xFF16191F),
                                fontSize: 12,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              sale.saleNumber,
                              style: TextStyle(
                                color: Color(0xFF16191F),
                                fontSize: 12,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              sale.customerName == null
                                  ? ""
                                  : sale.customerName,
                              style: TextStyle(
                                color: Color(0xFF16191F),
                                fontSize: 12,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "\$ " + sale.amount.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Color(0xFF16191F),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                                Flexible(
                                  child: Container(
                                    padding: EdgeInsets.all(1.5),
                                    margin: EdgeInsets.only(left: 3),
                                    decoration: BoxDecoration(
                                        color: sale.owe <= 0
                                            ? Colors.orange
                                            : Color(0xFFFF575F),
                                        borderRadius: BorderRadius.circular(1)),
                                    child: Text(
                                      sale.strPaymentStatus,
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.white),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(),
                      flex: 1,
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.person_outline,
                                  size: 14,
                                ),
                                Flexible(
                                  child: Container(
                                    child: Text(
                                      sale.soldBy,
                                      style: TextStyle(
                                        color: Color(0xFF16191F),
                                        fontSize: 12,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.car_rental,
                                  size: 14,
                                ),
                                Flexible(
                                  child: Container(
                                    child: Text(
                                      sale.orderPlatformName +
                                          " : " +
                                          sale.orderPlatformDetailName,
                                      style: TextStyle(
                                        color: Color(0xFF16191F),
                                        fontSize: 12,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Flexible(
                                  child: Container(
                                    padding: EdgeInsets.all(1.5),
                                    // decoration: sale.saleStatus == "cancelled"
                                    //     ? BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(1))
                                    //     : BoxDecoration(color: Colors.grey[350],borderRadius: BorderRadius.circular(1)),
                                    decoration: BoxDecoration(
                                        color: sale.saleStatus == "cancelled"
                                            ? Colors.red
                                            : Colors.grey[350],
                                        borderRadius: BorderRadius.circular(1)),
                                    child: Text(
                                      sale.showSaleStatus,
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: Color(0xFF16191F)),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
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
        enablePastDates: true,
        onSelectionChanged: _onSelectionChanged,
        selectionMode: DateRangePickerSelectionMode.range,
      ),
    );
  }
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        setState(() {
          _range =
              DateFormat('dd/MM/yyyy').format(args.value.startDate).toString() +
                  ' - ' +
                  DateFormat('dd/MM/yyyy')
                      .format(args.value.endDate ?? args.value.startDate)
                      .toString();
          _dateFrom =
              DateFormat('yyyy-MM-dd').format(args.value.startDate).toString();
          _dateTo = DateFormat('yyyy-MM-dd')
              .format(args.value.endDate ?? args.value.startDate)
              .toString();
        });
      }
    });
    //print(_range);
  }
  void initialSaleListByUserAndDateRange() async{
    getSaleListbyUserAndDateRange(_userLoggedIn.id, _dateFrom, _dateTo).then((result){
      setState(() {
        saleLists=result.model;
        _pageSize=result.pageSize;
      });
    });
  }
  void _filterSaleListByCustomerNameandSaleNumber(String term){
    getSaleListbyFilterSaleNumberCustomername(_userLoggedIn.id, term).then((result){
      setState(() {
        saleLists=result.model;
        _pageSize=result.pageSize;
      });
    });
  }
  Future<void> _getSaleListByUserAndDateRange() async{
    setState(() {
      _range = DateFormat('dd/MM/yyyy').format(DateTime.now().subtract(Duration(days: 12))).toString() +
          ' - ' +
          DateFormat('dd/MM/yyyy')
              .format(DateTime.now())
              .toString();
      _dateFrom=DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 12))).toString();
      _dateTo=DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
      initialSaleListByUserAndDateRange();
    });
  }
  Future<bool> _handleLoadMore() async{
    // fetch data async
    initialSaleListByUserAndDateRange();
    return true;
  }
  Future _loadData() async {
    // perform fetching data delay
    await new Future.delayed(new Duration(seconds: 2));
    // update data and loading status
    print("load more");
    setState(() {
      getSaleListbyUserAndDateRange(_userLoggedIn.id, _dateFrom, _dateTo).then((result){
        setState(() {
          saleLists.addAll(result.model);
          _pageSize=_pageSize+result.pageSize;
          //isLoading=false;
        });
      });

    });
  }
  Widget getNoDataWidget(){
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 60.0,
          child: new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage('assets/panda_gif.gif'),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),

        new Text("គ្មានទិន្នន័យ"),
        new FlatButton(
            color: Colors.red,
            child: new Text("ធ្វើអោយថ្មី", style: TextStyle(color: Colors.white),),
            onPressed: () => _getSaleListByUserAndDateRange()
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
