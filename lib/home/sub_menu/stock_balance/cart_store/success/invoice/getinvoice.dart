import 'package:async_loader/async_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:markarian_sales/api/api_service.dart';
import 'package:markarian_sales/model/commom_model.dart';
import 'package:markarian_sales/model/sale_detail_model.dart';

class GetInvoice extends StatefulWidget {
  final String saleId;
  GetInvoice(this.saleId,{Key key}):super(key: key);
  @override
  _GetInvoiceState createState() => _GetInvoiceState();
}

class _GetInvoiceState extends State<GetInvoice> {

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

  Widget getInvoiceDetailView(SaleModel sale){
    var _customer=sale.customerName==null?"":sale.customerName;
    var _customerContactPhone="";
    for(final cc in sale.customerContactPhones){
      if(cc.phoneNumber!=null){
        _customerContactPhone=_customerContactPhone+cc.phoneNumber;
      }

    }
    _customer=_customer+" "+_customerContactPhone+" "+sale.customer.noted;
    var remark="សម្គាល់: ​";
    if(sale.description==null)
      remark=remark+"គ្មាន";
    else
      remark=remark+ sale.description;

    return new SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              height: 56,
              padding: EdgeInsets.only(left: 17, right: 17),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Image.asset(
                      'assets/markarian_invoice.png',
                      height: 56,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'វិក័យបត្រ័',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 17, right: 17, top: 34),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          sale.strCreatedDate,
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          sale.invoiceNo==null?"":sale.invoiceNo,
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    Text(
                      _customer,
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    Row(
                      children: [
                        Text(
                          remark,
                          style: TextStyle(
                              color: Color(0xFF7B7B81), fontSize: 15),
                        ),
                        // Text('('+sale.customer.noted==null?"":sale.customer.noted +')',
                        //     style: TextStyle(fontSize: 15)),
                      ],
                    ),
                    SizedBox(
                      height: 29,
                    ),
                    Text(sale.saleDetails.length.toString() + ' ទំនិញ', style: TextStyle(fontSize: 15)),
                    Divider(
                      thickness: 2,
                      height: 15,
                      color: Color(0xFF282828),
                    ),
                    Container(
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: sale.saleDetails.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return listItemOnPrice(context, index,sale.saleDetails[index]);
                        },
                      ),
                    ),
                    Container(
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 4,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return totalList(context, index,sale);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 2,
              height: 15,
              color: Color(0xFF282828),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35, right: 35, bottom: 44),
              child: Column(
                children: [
                  Text(
                    'ទំនិញទិញហើយមិនអាចប្តូរប្រាក់វិញបានទេ។ សូមអរគុណ។',
                    style: TextStyle(fontSize: 13),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    '#103, សំរោងអណ្ដែត, សង្តាត់ គោកឃ្លាំង, ខណ្ឌ សែនសុខ​, រាជធានីភ្នំពេញ',
                    style: TextStyle(fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Tel: 095 454 584/ 087 454 501'
                        '\nwww.markarianmall.com',
                    style: TextStyle(fontSize: 13, color: Color(0xFFFA242C)),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
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
      initState: () async=> await getSaleDetailById(widget.saleId),
      renderLoad: () => Center(child: new CircularProgressIndicator()),
      renderError: ([error]) => getNoConnectionWidget(),
      renderSuccess: ({data}) => getInvoiceDetailView(data),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: Colors.red,
          elevation: 0.0,
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
      ),
      body: _asyncLoader
    );
  }

  Widget listItemOnPrice(BuildContext context, int index,SaleDetail dSale ) {
    var _itemPrice = dSale.price - dSale.discountAmount;
    var productDescription=dSale.product.productCode;
    if(dSale.productSizeName==null){
      productDescription=productDescription+" - "+dSale.product.productName;
    }else
      productDescription=productDescription+" - "+dSale.productSizeName;
    return Container(
      height: 43,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 5,
                child: Text(
                  productDescription,
                  style: TextStyle(fontSize: 12),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'x'+dSale.quantity.toStringAsFixed(0),
                  style: TextStyle(fontSize: 12, color: Color(0xFF7B7B81)),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  '\$${dSale.price.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 12, color: Color(0xFF7B7B81)),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  '\$${_itemPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 12, color: Color(0xFF7B7B81)),
                ),
              )
            ],
          ),
          Divider(
            height: 15,
            color: Color(0xFFEEEEEE),
          ),
        ],
      ),
    );
  }

  Widget totalList(BuildContext context, int index,SaleModel sale) {
    final oCcy = new NumberFormat("#,##0.00", "en_US");
    dynamic _grandTotalUSD = 0, _grandTotalKHR = 0, _outstandingUSD = 0;
    _grandTotalUSD=(sale.amount-sale.discount)+sale.deliveryAmount;
    _grandTotalKHR=_grandTotalUSD*sale.exchangeRate;
    return Container(
      height: 28,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 218,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      totalTxt[index],
                      style: TextStyle(
                        fontSize: 15,
                        color:
                            index == 0 ? Color(0xFFFA242C) : Color(0xFF7B7B81),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      index==0?sale.discount.toStringAsFixed(2):
                          index==1?sale.deliveryAmount.toStringAsFixed(2):
                              index==2?_grandTotalUSD.toStringAsFixed(2):
                      index==3?oCcy.format(_grandTotalKHR):
                      price[index],
                      style: TextStyle(
                        fontSize: 15,
                        color:
                            index == 0 ? Color(0xFFFA242C) : Color(0xFF7B7B81),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //total detail
  List<String> totalTxt = [
    "បញ្ចុះតម្លៃ(\$):",
    "តម្លៃដឹកជញ្ជូន(\$):",
    "សរុប(\$):",
    "សរុប(រៀល):",
  ];

  List<String> price = ['1.00', '0.00', '36.00', '24.000.00'];
}
