import 'package:async_loader/async_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:markarian_sales/api/api_service.dart';
import 'package:markarian_sales/listitems/sale_paid_list_item.dart';
import 'package:markarian_sales/login_pk/login.dart';
import 'package:markarian_sales/model/login_model.dart';
import 'package:markarian_sales/model/sale_latest_10_model.dart';
import 'package:markarian_sales/services/commom_service.dart';
import 'package:markarian_sales/services/sale_lastest10_service.dart';

class PaymentPage extends StatefulWidget{
  PaymentPage(this.userId,{Key key}):super(key:key);
  final userId;
  @override
  State<StatefulWidget> createState() =>_SalePaidPageState();

}

class _SalePaidPageState extends State<PaymentPage> with AutomaticKeepAliveClientMixin{

  LoginResult _userLoggedIn=new LoginResult();
  List<SalePayment> salePaid=List<SalePayment>();
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

  Widget getListView(List<SalePayment> items){
    return new ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) =>
        new SalePaidListItem(items[index])
    );
  }
  Future<void> _getUser() async{
    getUserInfo().then((result){
      setState(() {
        _userLoggedIn=result;
      });
          if(_userLoggedIn==null){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );

          }
        });
  }



  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var _asyncLoader = new AsyncLoader(
      key: asyncLoaderState,
      initState: () async => await getSalePaids(widget.userId),
      renderLoad: () => Center(child: new CircularProgressIndicator()),
      renderError: ([error]) => getNoConnectionWidget(),
      renderSuccess: ({data}) => getListView(data),
    );
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'ប្រវត្តិការបង់ប្រាក់',
          ),
          backgroundColor: Colors.red,
        ),
      body: Scrollbar(
        child: RefreshIndicator(
            onRefresh: () => _handleRefresh(),
            child: _asyncLoader
        ),
      ),
    );
  }

}