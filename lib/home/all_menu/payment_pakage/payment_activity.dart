import 'package:async_loader/async_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:markarian_sales/home/all_menu/payment_pakage/payment_detail/details.dart';
import 'package:markarian_sales/home/all_menu/payment_pakage/paymenting/paymenting.dart';
import 'package:markarian_sales/login_pk/login.dart';
import 'package:markarian_sales/model/login_model.dart';
import 'package:markarian_sales/model/sale_latest_10_model.dart';
import 'package:markarian_sales/services/commom_service.dart';
import 'package:markarian_sales/services/sale_lastest10_service.dart';

class PaymentActivity extends StatefulWidget {
  // PaymentActivity({this.color, this.title, this.onPush});
  // final MaterialColor color;
  // final String title;
  // final ValueChanged<int> onPush;

  @override
  _PaymentActivityState createState() => _PaymentActivityState();
}

class _PaymentActivityState extends State<PaymentActivity> with AutomaticKeepAliveClientMixin{
  LoginResult _userLoggedIn = new LoginResult();
  String userId = "";
  final GlobalKey<AsyncLoaderState> asyncLoaderState = new GlobalKey<AsyncLoaderState>();

  Widget getNoConnectionWidget(){
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

        new Text("No Internet Connection"),
        new FlatButton(
            color: Colors.red,
            child: new Text("Retry", style: TextStyle(color: Colors.white),),
            onPressed: () => asyncLoaderState.currentState.reloadState())
      ],
    );
  }
  Future<Null> _handleRefresh() async {
    asyncLoaderState.currentState.reloadState();
    return null;
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // getUserInfo().then((result) {
    //   _userLoggedIn = result;
    //   if (_userLoggedIn == null) {
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(builder: (context) => LoginPage()),
    //     );
    //   }
    //   setState(() {
    //     userId = result.id;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    var _asyncLoader = new AsyncLoader(
      key: asyncLoaderState,
      initState: () async => await getUserInfo(),
      renderLoad: () => Center(child: new CircularProgressIndicator()),
      renderError: ([error]) => getNoConnectionWidget(),
      renderSuccess: ({data}) => AllPaymentTabLayout(data.id),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.red,
        title: Text(
          'ការបង់ប្រាក់',
        ),

      ),
      // body: Padding(
      //   padding: EdgeInsets.only(top: 5.12),
      //   child: AllPaymentTabLayout(userId),
      // ),
      body: Scrollbar(
        child: RefreshIndicator(
            onRefresh: () => _handleRefresh(),
            child: _asyncLoader
        ),
      ),
    );
  }

  Widget AllPaymentTabLayout(String userId) {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              toolbarHeight: 67,
              pinned: true,
              elevation: 0.0,
              backgroundColor: Colors.white,
              actions: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: 15,
                      right: 15,
                    ),
                    child: Container(
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
                                    focusColor: Colors.blueGrey),
                                autofocus: false,
                              ),
                            ),
                            flex: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ];
        },
        body: AllPaymentListDetail(userId));
  }

  //paymentList Detail
  Widget PaymentListDetails(BuildContext context, int index, Sale sale) {
    return GestureDetector(
      onTap: () {
        print("Approval Data : " + index.toString());
        // if (DefaultTabController.of(context).index != 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailPayment(sale)),
        );
        // }
        // else {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => PaymentingDetail(sale)),
        //   );
        // }
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
                    alignment: Alignment.center,
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

  Widget AllPaymentListDetail(String userId) {
    //print("In all payment ${userId}");
    return FutureBuilder<SaleResponse>(
        future: getAllSaleOutstandingPaymentByUser(userId),
        builder: (context, snapshot) {
          //callAPI();
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text("Error ${snapshot.error}");
            }

            //return Text('Title from Post JSON : ${snapshot.data.itemsCount}');
            return SingleChildScrollView(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    Divider(
                      color: Color(0xFFEEEEEE),
                      thickness: 1,
                      height: 1,
                    ),
                    Container(
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
                            itemCount: snapshot.data.pageSize,
                            itemBuilder: (BuildContext context, int i) {
                              return PaymentListDetails(
                                  context, i, snapshot.data.model[i]);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else
            return CircularProgressIndicator();
        });
  }

  //new test

}
