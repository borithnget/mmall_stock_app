import 'package:async_loader/async_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:markarian_sales/api/api.dart';
import 'package:markarian_sales/api/api_service.dart';
import 'package:markarian_sales/home/all_menu/payment_pakage/paymenting/paymenting.dart';
import 'package:markarian_sales/home/sub_menu/stock_balance/cart_store/success/invoice/getinvoice.dart';
import 'package:markarian_sales/model/commom_model.dart';
import 'package:markarian_sales/model/login_model.dart';
import 'package:markarian_sales/model/sale_detail_model.dart';
import 'package:markarian_sales/model/sale_latest_10_model.dart';
import 'package:markarian_sales/services/commom_service.dart';
import 'package:markarian_sales/utils/commom_functions.dart';

class ViewSaleDetail extends StatefulWidget {
  ViewSaleDetail(this.id, {Key key}) : super(key: key);
  String id;
  @override
  _ViewSaleDetailState createState() => _ViewSaleDetailState();
}

class _ViewSaleDetailState extends State<ViewSaleDetail> with AutomaticKeepAliveClientMixin{
  SaleModel _sale = SaleModel();
  dynamic _grandTotalUSD = 0, _grandTotalKHR = 0, _outstandingUSD = 0;
  final _deleteReasonController = new TextEditingController(text: '');
  LoginResult _userLoggedIn = LoginResult();
  bool _validateReason = false;
  String _remark = "";
  String _customerContactPhone = "";

  List<String> title = [
    'លេខកូដលក់',
    'កាលបរិឆ្ឆេទ',
    'កម្ម៉ង់តាមរយៈ',
    'ឈ្មោះភ្លែតវ៉ម ',
    'ឈ្មោះអតិថិជន',
    'លេខទូរសព្ទ',
  ];

  List<String> titleDeliver = [
    'ដឹកជញ្ជូនដោយ',
    'កាលបរិច្ឆេទដឹកជញ្ជូន',
    'ទំនាក់ទំនង',
    'លេខទូរសព្ទ ',
  ];

  List<String> titleItem = [
    'តម្លៃសរុប (\$) :',
    'បញ្ចុះតម្លៃ (\$) :',
    'តម្លៃដឹកជញ្ជូន (\$) :',
    'អត្រាប្ដូរប្រាក់ជា (រៀល) :',
    'តម្លៃសរុបចុងក្រោយជា (\$) :',
    'តម្លៃសរុបចុងក្រោយជា (រៀល) :',
    'ទឹកប្រាក់បានបង់ជា (\$) :',
    'ទឹកប្រាក់បានបង់ជា (រៀល) :',
    'ទឹកប្រាក់ដែលនៅសល់ជា (\$) :',
    'ទឹកប្រាក់ដែលនៅសល់ជា (រៀល) :',
  ];
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
    // TODO: implement initState
    super.initState();
    getUserInfo().then((result) {
      setState(() {
        _userLoggedIn = result;
      });
    });

    _intitalSaleDetail();

  }

  void _intitalSaleDetail() async{
    //print("sale id ${widget.id}");
    getSaleDetailResponse(widget.id).then((response){
      //print(response.toJson());

      setState(() {
        _sale=response.model;
        if(_sale!=null){
          _grandTotalUSD=(_sale.amount-_sale.discount)+_sale.deliveryAmount;
          _grandTotalKHR=_grandTotalUSD*_sale.exchangeRate;
          _outstandingUSD=_grandTotalUSD- (_sale.revicedFromCustomer + (_sale.receivedInReal/_sale.exchangeRate));
          _remark=_remark+_sale.description;
          for(final sw in _sale.saleWorkflows){
            _remark=_remark+sw.remark+",";
          }
          for(final cc in _sale.customerContactPhones){
            if(cc.phoneNumber!=null){
              _customerContactPhone=_customerContactPhone+cc.phoneNumber;
            }

          }
        }

      });
    });
  }

  Widget getSaleDetailView(SaleModel sale){
    //setState(() {
      _sale=sale;
      if(sale!=null){
        _grandTotalUSD=(sale.amount-sale.discount)+sale.deliveryAmount;
        _grandTotalKHR=_grandTotalUSD*sale.exchangeRate;
        _outstandingUSD=_grandTotalUSD- (sale.revicedFromCustomer + (sale.receivedInReal/sale.exchangeRate));
        // for(final sw in sale.saleWorkflows){
        //   _remark=_remark+sw.remark+",";
        // }
        // for(final cc in sale.customerContactPhones){
        //   if(cc.phoneNumber!=null){
        //     _customerContactPhone=_customerContactPhone+cc.phoneNumber;
        //   }
        //
        // }
      }
    //});
    return new SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 293,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      child:sale==null? Text("Loading...") : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return listDetail(context, index,sale);
                        },
                      ),
                    ),
                  ),
                  Divider(
                    color: Color(0xFFEEEEEE),
                    height: 1,
                  ),
                  Container(
                    height: 54,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'បង់ប្រាក់តាមរយៈ',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF16191F)),
                        ),
                        Text(sale.paymentTypeName == null
                            ? ""
                            : sale.paymentTypeName),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 19),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'សម្គាល់',
                    style:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    color: Color(0xFFEEEEEE),
                  ),
                  Text(
                    _remark,
                    style: TextStyle(color: Color(0xFFFB4A50), fontSize: 15),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 19),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'អាស័យដ្ឋាន',
                    style:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    color: Color(0xFFEEEEEE),
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xFFFA242C),
                        radius: 20,
                        child: Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 9,
                      ),
                      Expanded(
                        child: Text(
                          sale.customer==null?"":sale.customer.noted,
                          style: TextStyle(
                              color: Color(0xFF16191F), fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 19),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ពត៌មានការដឹកជញ្ជូន',
                    style:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    color: Color(0xFFEEEEEE),
                  ),
                  Container(
                    height: 167,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return detailDeliver(context, index,sale);
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 17),
                  height: 43,
                  child: Text(
                    'មុខទំនិញ (${sale.saleDetails==null?0:sale.saleDetails.length})',
                    style:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                Divider(
                  height: 1,
                  color: Color(0xFFEEEEEE),
                ),
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: sale.saleDetails==null?0:sale.saleDetails.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return detailItemCart(ctxt, index,sale);
                        },
                      ),
                      Container(
                        height: 354,
                        padding: EdgeInsets.symmetric(
                            horizontal: 15, vertical: 19),
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return detailItem(context, index,sale);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var _asyncLoader=new AsyncLoader(
      key:asyncLoaderState,
      initState: () async=> await getSaleDetailById(widget.id),
      renderLoad: () => Center(child: new CircularProgressIndicator()),
      renderError: ([error]) => getNoConnectionWidget(),
      renderSuccess: ({data}) => getSaleDetailView(data),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text(
          'មើលការលក់លម្អិត',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 17),
        ),
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.white,
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
      body: _asyncLoader ,
      bottomNavigationBar: new BottomAppBar(
          child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Visibility(
              visible: _sale.saleStatus == "cancelled" ? false : true,
              child: IconButton(
                  icon: Icon(Icons.mode_edit),
                  disabledColor: Colors.green,
                  onPressed: () {})),
          Visibility(
            visible: _sale.saleStatus == "cancelled" ? false : true,
            child: IconButton(
                icon: Icon(Icons.restore_from_trash),
                disabledColor: Colors.green,
                onPressed: () {
                  showDeleteBottomSheet(_sale);
                }),
          ),
          Visibility(
            visible: _sale.saleStatus == "cancelled"
                ? false
                : _outstandingUSD > 0
                    ? true
                    : false,
            child: IconButton(
                icon: Icon(Icons.attach_money_outlined),
                disabledColor: Colors.green,
                onPressed: () {
                  Sale _pSale = Sale();
                  _pSale.id = _sale.id;
                  _pSale.saleNumber = _sale.saleNumber;
                  _pSale.totalAmount = _grandTotalUSD;
                  _pSale.totalAmountKHR = _grandTotalKHR;
                  _pSale.totalOutstandingUSD = _outstandingUSD;
                  _pSale.totalOutstandingKHR =
                      _outstandingUSD * _sale.exchangeRate;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PaymentingDetail(_pSale, false)),
                  );
                }),
          ),
          IconButton(
              icon: Icon(Icons.print),
              disabledColor: Colors.green,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GetInvoice(_sale.id)),
                );
              }),
          IconButton(
              icon: Icon(Icons.location_history),
              disabledColor: Colors.green,
              onPressed: () {}),
        ],
      )),
    );
  }

  //list Sale Master detail
  Widget listDetail(BuildContext context, int index,SaleModel sale) {
    return Container(
      height: 40,
      child:sale==null?Text("Loading..."): Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                title[index],
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF16191F)),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                index == 0
                    ? sale.saleNumber
                    : index == 1
                        ? sale.strCreatedDate
                        : index == 2
                            ? sale.orderPlatformName
                            : index == 3
                                ? sale.orderPlatformDetailName
                                : index == 4
                                    ? sale.customerName
                                    : index == 5
                                        ? _customerContactPhone
                                        : "",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //detail deliver
  Widget detailDeliver(BuildContext context, int index,SaleModel sale) {
    SDDelivery delivery = sale.saleDeliveries[0];
    return Container(
      height: 41.75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                titleDeliver[index],
                style: TextStyle(fontSize: 15, color: Color(0xFF16191F)),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                index == 0
                    ? delivery.delivery_name
                    : index == 1
                        ? delivery.delivery_date == null
                            ? ""
                            : delivery.delivery_date
                        : index == 2
                            ? delivery.contact_person_name == null
                                ? ""
                                : delivery.contact_person_name
                            : index == 3
                                ? delivery.contact_person_phone == null
                                    ? ""
                                    : delivery.contact_person_phone
                                : "",
                style: TextStyle(color: Color(0xFFFB4A50), fontSize: 15),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //list of detail item
  Widget detailItem(BuildContext context, int index,SaleModel sale) {
    return Container(
      height: 35.4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                titleItem[index],
                style: TextStyle(fontSize: 15, color: Color(0xFF16191F)),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                index == 0
                    ? sale.amount.toStringAsFixed(2)
                    : index == 1
                        ? sale.discount.toStringAsFixed(2)
                        : index == 2
                            ? sale.deliveryAmount.toStringAsFixed(2)
                            : index == 3
                                ? sale.exchangeRate.toStringAsFixed(2)
                                : index == 4
                                    ? _grandTotalUSD.toStringAsFixed(2)
                                    : index == 5
                                        ? _grandTotalKHR.toStringAsFixed(2)
                                        : index == 7
                                            ? sale.receivedInReal
                                                .toStringAsFixed(2)
                                            : index == 6
                                                ? sale.revicedFromCustomer
                                                    .toStringAsFixed(2)
                                                : index == 8
                                                    ? _outstandingUSD
                                                        .toStringAsFixed(2)
                                                    : 0
                                                        .toStringAsFixed(2)
                                                        .toString(),
                style: TextStyle(color: Color(0xFFFB4A50), fontSize: 15),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //item add from cart
  Widget detailItemCart(BuildContext context, int index,SaleModel sale) {
    SaleDetail saleDetail = sale.saleDetails[index];
    var _itemPrice = saleDetail.price - saleDetail.discountAmount;
    var _itemDescription = saleDetail.product.productCode;
    if (saleDetail.productSizeName == null)
      _itemDescription =
          _itemDescription + " - " + saleDetail.product.productName;
    else
      _itemDescription = _itemDescription + " - " + saleDetail.productSizeName;

    return Container(
      child: InkWell(
        child: Card(
          elevation: 0.5,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 17, horizontal: 17),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/markarianmall_pf.jpg',
                    image: Api.imageMainUrl + saleDetail.product.productImage,
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 17, right: 17, bottom: 17),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _itemDescription,
                        style:
                            TextStyle(color: Color(0xFF16191F), fontSize: 14),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // Text(
                                    //   'ឯកតា : ',
                                    //   style: TextStyle(
                                    //       fontSize: 11,
                                    //       color: Color(0xFF6E6E6E)),
                                    //   overflow: TextOverflow.ellipsis,
                                    //   maxLines: 1,
                                    // ),
                                    // Flexible(
                                    //   child: Text(
                                    //     saleDetail.unitTypeId,
                                    //     style: TextStyle(
                                    //         color: Color(0xFF6E6E6E),
                                    //         fontSize: 11),
                                    //     overflow: TextOverflow.ellipsis,
                                    //     maxLines: 1,
                                    //   ),
                                    // ),
                                    Flexible(
                                      child: RichText(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        text: TextSpan(
                                          text: 'ឯកតា : ',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Color(0xFF6E6E6E)),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: saleDetail.unitTypeId,
                                              style: TextStyle(
                                                  color: Color(0xFF6E6E6E),
                                                  fontSize: 11),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // Text(
                                    //   'ចំនួន	: ',
                                    //   style: TextStyle(
                                    //       fontSize: 11,
                                    //       color: Color(0xFF6E6E6E)),
                                    //   overflow: TextOverflow.ellipsis,
                                    //   maxLines: 1,
                                    // ),
                                    // Flexible(
                                    //   child: Text(
                                    //     saleDetail.quantity.toStringAsFixed(0),
                                    //     style: TextStyle(
                                    //         color: Color(0xFF6E6E6E),
                                    //         fontSize: 11),
                                    //     overflow: TextOverflow.ellipsis,
                                    //     maxLines: 1,
                                    //   ),
                                    // ),
                                    Flexible(
                                      child: RichText(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        text: TextSpan(
                                          text: 'ចំនួន	: ',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Color(0xFF6E6E6E)),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: saleDetail.quantity
                                                  .toStringAsFixed(0),
                                              style: TextStyle(
                                                  color: Color(0xFF6E6E6E),
                                                  fontSize: 11),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    //   Text(
                                    //     'តម្លៃលក់ (\$) : ',
                                    //     style: TextStyle(
                                    //         fontSize: 11,
                                    //         color: Color(0xFF6E6E6E)),
                                    //     overflow: TextOverflow.ellipsis,
                                    //     maxLines: 1,
                                    //   ),
                                    //   Flexible(
                                    //     child: Container(
                                    //       child: Text(
                                    //         saleDetail.price.toStringAsFixed(2),
                                    //         style: TextStyle(
                                    //             color: Color(0xFF6E6E6E),
                                    //             fontSize: 11),
                                    //         overflow: TextOverflow.ellipsis,
                                    //         maxLines: 1,
                                    //       ),
                                    //     ),
                                    //   ),
                                    Flexible(
                                      child: RichText(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        text: TextSpan(
                                          text: 'តម្លៃលក់ (\$) : ',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Color(0xFF6E6E6E)),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: saleDetail.price
                                                  .toStringAsFixed(2),
                                              style: TextStyle(
                                                  color: Color(0xFF6E6E6E),
                                                  fontSize: 11),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // Text(
                                    //   'បញ្ចុះតម្លៃ (\$) : ',
                                    //   style: TextStyle(
                                    //       fontSize: 11,
                                    //       color: Color(0xFF6E6E6E)),
                                    //   overflow: TextOverflow.ellipsis,
                                    //   maxLines: 1,
                                    // ),
                                    // Flexible(
                                    //   child: Container(
                                    //     child: Text(
                                    //       saleDetail.discountAmount
                                    //           .toStringAsFixed(2),
                                    //       style: TextStyle(
                                    //           color: Color(0xFF6E6E6E),
                                    //           fontSize: 11),
                                    //       overflow: TextOverflow.ellipsis,
                                    //       maxLines: 1,
                                    //     ),
                                    //   ),
                                    // ),
                                    Flexible(
                                      child: RichText(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        text: TextSpan(
                                          text: 'បញ្ចុះតម្លៃ (\$) : ',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Color(0xFF6E6E6E)),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: saleDetail.discountAmount
                                                  .toStringAsFixed(2),
                                              style: TextStyle(
                                                  color: Color(0xFF6E6E6E),
                                                  fontSize: 11),
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
                          //pending and price
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: Color(0xFFF0F0F0)),
                                  child: Text(
                                    saleDetail.productStatus,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Color(0xFFA3A3A3),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  '\$${_itemPrice.toStringAsFixed(2)}',
                                  style: TextStyle(
                                      color: Color(0xFFFA242C),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () {},
      ),
    );
  }

  void showDeleteBottomSheet(SaleModel sale) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 3,
                          width: 28,
                          child: Container(
                            color: Color(0xFFC4C4C4),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 27.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'តើអ្នកចង់លុបការកម្ម៉ង់នេះមែនទេ?',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            'សូមបំពេញហេតុផល៖',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 17,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          left: 27,
                          right: 27),
                      child: TextField(
                        controller: _deleteReasonController,
                        minLines: 5,
                        maxLines: 15,
                        autocorrect: false,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          //hintText: '',
                          errorText: _validateReason
                              ? "សូមធ្វើការបញ្ចូលហេតុផលដែលអ្នកចង់លុបការកម្ម៉ង់។"
                              : null,
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0)),
                            borderSide: BorderSide(color: Color(0xFF9A99A2)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0)),
                            borderSide: BorderSide(color: Color(0xFF9A99A2)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 41),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 27),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 5,
                            child: SizedBox(
                              width: 142,
                              height: 42,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                                color: Color(0xFF3A7BD5),
                                onPressed: () {
                                  setState(() {
                                    _validateReason =
                                        _deleteReasonController.text.isEmpty
                                            ? true
                                            : false;
                                  });
                                  if (!_validateReason) {
                                    PutSaleDeleteModel putSale =
                                        PutSaleDeleteModel(
                                            Remark:
                                                _deleteReasonController.text,
                                            SaleId: sale.id,
                                            UserId: '');
                                    putSaleDeleteResponse(putSale, sale.id)
                                        .then((response) {
                                      print('response ' + response.body);
                                      if (response.body.isNotEmpty) {
                                        Navigator.pop(context);
                                        setState(() {
                                          _intitalSaleDetail();
                                        });
                                      }
                                    });
                                  }
                                },
                                child: Text(
                                  'យល់ព្រម',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: SizedBox(),
                          ),
                          Expanded(
                            flex: 5,
                            child: SizedBox(
                              width: 142,
                              height: 42,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                                color: Color(0xFFFA242C),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'ទេ',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 37),
                  ],
                ),
              ),
            ));
  }

  String validateRemark(String value) {
    if (value.isEmpty) {
      return "សូមធ្វើការបញ្ចូលហេតុផលដែលអ្នកចង់លុបការកម្ម៉ង់។";
    }
    return null;
  }
}
