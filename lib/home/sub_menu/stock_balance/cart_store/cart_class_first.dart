import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:markarian_sales/api/api.dart';
import 'package:markarian_sales/appbar/custombar.dart';
import 'package:markarian_sales/home/sub_menu/stock_balance/cart_store/cart_class_second.dart';
import 'package:markarian_sales/login_pk/login.dart';
import 'package:markarian_sales/model/commom_model.dart';
import 'package:markarian_sales/model/common_response_model.dart';
import 'package:markarian_sales/model/login_model.dart';
import 'package:markarian_sales/model/product_model.dart';
import 'package:markarian_sales/services/commom_service.dart';

class CartClassFirst extends StatefulWidget {

  //final List<ProductCheckOut> productCheckOutItems;

  // CartClassFirst({Key key}):super(key:key);
  // CartClassFirst(this.productCheckOutItems,this.color,this.title,this.onPush, {Key key}) : super(key: key);
  // final MaterialColor color;
  // final String title;
  // final ValueChanged<int> onPush;
  @override
  _CartClassState createState() => _CartClassState();
}

class _CartClassState extends State<CartClassFirst> with AutomaticKeepAliveClientMixin{

  String _chosenValue;
  int typeDiscount=0;
  int count = 1;
  List<Product> checkoutProducts=new List<Product>();
  CheckOutProductResponse checkoutProductResponse=new CheckOutProductResponse();
  PostSaleModel postSale=PostSaleModel();

  double _subTotal=0,_grandTotalUSD=0,_grandTotalReal=0,_outstandingUSD=0,_outstandingReal=0,_receivedInReal=0,_receivedInUSD=0;
  double _discountAmount=0,_deliveryPrice=0,_exchangeRate=4000;

  final _discountAmountController=new TextEditingController(text:"0");
  final _deliveryAmountController=new TextEditingController(text:"0");
  final _exchangeRateController=new TextEditingController(text:"40000");
  final _receivedInUSDController=new TextEditingController(text:"0");
  final _receivedInRealController=new TextEditingController(text:"0");

  List<String> titletext = [
    "បញ្ចុះតម្លៃ (\$) :",
    "តម្លៃដឹកជញ្ជូន (\$) :",
    "អត្រាប្ដូរប្រាក់ទៅរៀល :",
    "ទឹកប្រាក់ទទូលជា (\$) :",
    "ទឹកប្រាក់ទទូលជា (KHR) :"
  ];

  List<valueTotal> dataTotal = [
    valueTotal("ទឹកប្រាក់សរុបចុងក្រោយជា (\$) :", '0.00'),
    valueTotal("ទឹកប្រាក់សរុបចុងក្រោយជា (KHR):", '0.00'),
    valueTotal("ទឹកប្រាក់នៅសល់ជា (\$) :", '0.00'),
    valueTotal("ទឹកប្រាក់នៅសល់ជា (KHR):", '0.00'),
  ];
  LoginResult _userLoggedIn=new LoginResult();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("cart ....");

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
          _initialCheckOutProduct();
        }
      });
    });

    // postProductCheckoutResponse(widget.productCheckOutItems).then((response){
    //   //print(response.body);
    //   if(response.body==""){
    //
    //   }else{
    //     setState(() {
    //       checkoutProductResponse=checkOutProductResponseFromJson(response.body);
    //       for(final product in checkoutProductResponse.model)
    //         {
    //           _subTotal=_subTotal+product.productUnit.price;
    //           calculateAmount();
    //         }
    //     });
    //   }
    //
    // }).catchError((error){
    //   print('error : $error');
    // });
  }

  void _initialCheckOutProduct() async{
    _subTotal=0;
    getCartItembyUser(_userLoggedIn.id).then((response){
      setState(() {
        checkoutProductResponse=response;
        checkoutProducts=checkoutProductResponse.model;
        for(final product in checkoutProducts)
        {
          _subTotal=_subTotal+product.productUnit.price;
          calculateAmount();
        }
      });
    });
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() { print('runstate $state'); });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'កន្រ្តក',
        ),
        backgroundColor: Colors.red,
      ),
      body: Container(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  //return itemList(widget.productCheckOutItems);

                  return Container(
                    color: Colors.white,
                    child: CustomScrollView(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      slivers: [
                        SliverToBoxAdapter(
                          child: Container(
                            height: 43,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color(0xFFF0F0F0),
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 17, right: 17),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: 'តារាងកម្ម៉ង់ទំនិញ (${checkoutProducts.length})',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Color(0xFF16191F),
                                              fontWeight: FontWeight.w700),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {

                              Product _product=checkoutProducts[index];

                              String _productDescription=_product.productCode;
                              if(_product.productDetail.productSizeName!=null)
                                _productDescription=_productDescription + " - "+(_product.productDetail.productSizeName==null?" ":_product.productDetail.productSizeName);
                              else
                                _productDescription=_productDescription+" - "+_product.productName;
                              return Container(
                                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 17),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color(0xFFF0F0F0),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(3),
                                            child: FadeInImage.assetNetwork(
                                                placeholder: 'assets/markarianmall_pf.jpg',
                                                image: Api.imageMainUrl+_product.productImage,
                                                fit:BoxFit.cover,
                                              height: 63,
                                              width: 63,
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.only(left: 17),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    _productDescription,
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 17,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              '\$'+_product.productUnit.price.toString(),
                                                              maxLines: 1,
                                                              overflow: TextOverflow.ellipsis,
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                color: Color(0xFFFA242C),
                                                                fontWeight: FontWeight.w700,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              'x${_product.productUnit.quantity.toString().split('.')[0]}',
                                                              maxLines: 1,
                                                              overflow: TextOverflow.ellipsis,
                                                              style: TextStyle(
                                                                fontSize: 11,
                                                                color: Color(0xFF6E6E6E),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      ClipOval(
                                                        child: Material(
                                                          child: InkWell(
                                                            onTap: () {
                                                              //print("hi ${_product.cartId}");
                                                              if(checkoutProducts.length==1){
                                                                showAlertDialogLoginFail(context);
                                                              }else{
                                                                PutCartRemoveItem putCartRemoveItem=new PutCartRemoveItem(
                                                                    CartId:_product.cartId,
                                                                    IsPlaceOrder: false,
                                                                    UpdateBy: _userLoggedIn.id
                                                                );
                                                                putCartRemoveItemResponse(_product.cartId, putCartRemoveItem).then((response){
                                                                  setState(() {
                                                                    _initialCheckOutProduct();
                                                                  });
                                                                });
                                                              }



                                                            },
                                                            child: SizedBox(
                                                              width: 24,
                                                              height: 24,
                                                              child: Image.asset(
                                                                  'assets/outline.png'),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: 40,
                                    // ),
                                    // SizedBox(
                                    //   height: 22,
                                    // ),
                                    // Column(
                                    //   mainAxisAlignment: MainAxisAlignment.start,
                                    //   crossAxisAlignment: CrossAxisAlignment.start,
                                    //   children: [
                                    //     RichText(
                                    //       text: TextSpan(
                                    //         text: "ឯកតាលក់ :",
                                    //         style: TextStyle(
                                    //             fontSize: 15, color: Color(0xFF16191F)),
                                    //         children: <TextSpan>[
                                    //           TextSpan(
                                    //             text: '*',
                                    //             style: TextStyle(
                                    //                 fontSize: 15, color: Color(0xFFFA242C)),
                                    //           ),
                                    //         ],
                                    //       ),
                                    //     ),
                                    //     Container(
                                    //       margin: EdgeInsets.only(top: 8),
                                    //       padding: EdgeInsets.only(left: 8, right: 8),
                                    //       decoration: BoxDecoration(
                                    //           borderRadius: const BorderRadius.all(
                                    //               Radius.circular(5.0)),
                                    //           border: Border.all(
                                    //             color: Color(0xFF8F9297),
                                    //             width: 1,
                                    //           ),
                                    //           color: Colors.white),
                                    //       child: DropdownButtonHideUnderline(
                                    //         child: DropdownButton<ProductUnit>(
                                    //           //value: _chosenValue,
                                    //           value: _selectedProductUnit,
                                    //           focusColor: Colors.black,
                                    //           style: TextStyle(color: Colors.black),
                                    //           iconEnabledColor: Color(0xFFAFAFAF),
                                    //           items: _productUnitItems,
                                    //           onChanged: (value) {
                                    //             setState(() {
                                    //               print(value.id);
                                    //               _selectedProductUnit = value;
                                    //             });
                                    //           },
                                    //           icon: Icon(Icons.keyboard_arrow_down),
                                    //           isExpanded: true,
                                    //         ),
                                    //       ),
                                    //       height: 45,
                                    //       width: double.maxFinite,
                                    //     ),
                                    //   ],
                                    // ),
                                  ],
                                ),
                              );
                            },
                            childCount: checkoutProductResponse.model==null?0:checkoutProductResponse.model.length,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                                child: Container(
                                  color: Colors.grey[200],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 20, left: 16, right: 16),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'តម្លៃសរុប (\$) :',
                                            style: TextStyle(
                                                fontSize: 15, color: Color(0xFF7B7B81)),
                                          ),
                                          Text(
                                            _subTotal.toString(),
                                            style: TextStyle(
                                                fontSize: 15, color: Color(0xFFFA242C)),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 22),
                                      padding: EdgeInsets.only(left: 16, right: 16),
                                      width: double.maxFinite,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // RichText(
                                          //   text: TextSpan(
                                          //     text: 'ប្រភេទបញ្ចុះតម្លៃ :',
                                          //     style: TextStyle(
                                          //         fontSize: 15, color: Color(0xFF16191F)),
                                          //     children: <TextSpan>[
                                          //       TextSpan(
                                          //         text: '*',
                                          //         style: TextStyle(
                                          //             fontSize: 15, color: Color(0xFFFA242C)),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
                                          // Container(
                                          //   width: double.maxFinite,
                                          //   child: Container(
                                          //     margin: EdgeInsets.only(top: 8),
                                          //     padding: EdgeInsets.only(left: 8, right: 8),
                                          //     decoration: BoxDecoration(
                                          //         borderRadius: const BorderRadius.all(
                                          //             Radius.circular(5.0)),
                                          //         border: Border.all(
                                          //           color: Color(0xFF8F9297),
                                          //           width: 1,
                                          //         ),
                                          //         color: Colors.white),
                                          //     child: DropdownButtonHideUnderline(
                                          //       child: DropdownButton(
                                          //         value: typeDiscount,
                                          //         focusColor: Colors.black,
                                          //         style: TextStyle(color: Colors.black),
                                          //         iconEnabledColor: Color(0xFFAFAFAF),
                                          //         items: <int>[
                                          //           0,
                                          //           1,
                                          //         ].map<DropdownMenuItem<int>>((int value) {
                                          //           return DropdownMenuItem<int>(
                                          //             value: value,
                                          //             child: Text(
                                          //               value == 0 ?'\$': '%' ,
                                          //               style: TextStyle(color: Colors.black),
                                          //             ),
                                          //           );
                                          //         }).toList(),
                                          //         hint: Text(
                                          //           "ប្រភេទ",
                                          //           style: TextStyle(
                                          //               color: Colors.grey,
                                          //               fontSize: 14,
                                          //               fontWeight: FontWeight.w500),
                                          //         ),
                                          //         onChanged: (int value) {
                                          //           setState(() {
                                          //             typeDiscount = value;
                                          //           });
                                          //         },
                                          //         icon: Icon(Icons.keyboard_arrow_down),
                                          //         isExpanded: true,
                                          //       ),
                                          //     ),
                                          //     height: 45,
                                          //     width: double.maxFinite,
                                          //   ),
                                          // ),
                                          //Discount Amount
                                          Container(
                                            width: double.maxFinite,
                                            child:Card(
                                              //margin: EdgeInsets.only(bottom: 28),
                                              child: Container(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    RichText(
                                                      text: TextSpan(
                                                        text: titletext[0],
                                                        style: TextStyle(fontSize: 15, color: Color(0xFF16191F)),
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text: '*',
                                                            style: TextStyle(fontSize: 15, color: Color(0xFFFA242C)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(top: 8),
                                                      decoration: BoxDecoration(
                                                          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                                                          border: Border.all(
                                                            color: Color(0xFF8F9297),
                                                            width: 1,
                                                          ),
                                                          color: Colors.white
                                                      ),
                                                      child: TextFormField(
                                                        controller: _discountAmountController,
                                                        keyboardType: TextInputType.number,
                                                        autofocus: false,
                                                        style: TextStyle(color: Color(0xFF16191F)),
                                                        decoration: InputDecoration(
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide.none,
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                color: Color(0xFF8F9297),
                                                                width: 1,
                                                              )),
                                                          enabled: true,
                                                          contentPadding: EdgeInsets.only(left: 12, right: 12),
                                                          hintText: '',
                                                          fillColor: Colors.white,
                                                        ),
                                                        onChanged: (value){
                                                          setState(() {
                                                            _discountAmount=double.parse(value);
                                                          });
                                                          calculateAmount();
                                                          //print("discount amount on change ${_discountAmount}");
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ) ,
                                          ),
                                          //Delivery Price
                                          Container(
                                            width: double.maxFinite,
                                            child:Card(
                                              //margin: EdgeInsets.only(bottom: 28),
                                              child: Container(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    RichText(
                                                      text: TextSpan(
                                                        text: titletext[1],
                                                        style: TextStyle(fontSize: 15, color: Color(0xFF16191F)),
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text: '*',
                                                            style: TextStyle(fontSize: 15, color: Color(0xFFFA242C)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(top: 8),
                                                      decoration: BoxDecoration(
                                                          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                                                          border: Border.all(
                                                            color: Color(0xFF8F9297),
                                                            width: 1,
                                                          ),
                                                          color: Colors.white
                                                      ),
                                                      child: TextFormField(
                                                        controller: _deliveryAmountController,
                                                        keyboardType: TextInputType.number,
                                                        autofocus: false,
                                                        style: TextStyle(color: Color(0xFF16191F)),
                                                        decoration: InputDecoration(
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide.none,
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                color: Color(0xFF8F9297),
                                                                width: 1,
                                                              )),
                                                          enabled: true,
                                                          contentPadding: EdgeInsets.only(left: 12, right: 12),
                                                          hintText: '',
                                                          fillColor: Colors.white,
                                                        ),
                                                        onChanged: (value){
                                                          setState(() {
                                                            _deliveryPrice=double.parse(value);
                                                          });
                                                          calculateAmount();
                                                          //print("delivery price amount on change ${_deliveryPrice}");
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ) ,
                                          ),
                                          //Exchange Rate
                                          Container(
                                            width: double.maxFinite,
                                            child:Card(
                                              //margin: EdgeInsets.only(bottom: 28),
                                              child: Container(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    RichText(
                                                      text: TextSpan(
                                                        text: titletext[2],
                                                        style: TextStyle(fontSize: 15, color: Color(0xFF16191F)),
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text: '*',
                                                            style: TextStyle(fontSize: 15, color: Color(0xFFFA242C)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(top: 8),
                                                      decoration: BoxDecoration(
                                                          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                                                          border: Border.all(
                                                            color: Color(0xFF8F9297),
                                                            width: 1,
                                                          ),
                                                          color: Colors.white
                                                      ),
                                                      child: TextFormField(
                                                        controller: _exchangeRateController,
                                                        keyboardType: TextInputType.number,
                                                        autofocus: false,
                                                        style: TextStyle(color: Color(0xFF16191F)),
                                                        decoration: InputDecoration(
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide.none,
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                color: Color(0xFF8F9297),
                                                                width: 1,
                                                              )),
                                                          enabled: true,
                                                          contentPadding: EdgeInsets.only(left: 12, right: 12),
                                                          hintText: '',
                                                          fillColor: Colors.white,
                                                        ),
                                                        onChanged: (value){
                                                          setState(() {
                                                            _exchangeRate=double.parse(value);
                                                          });
                                                          calculateAmount();
                                                          //print("discount amount on change ${_exchangeRate}");
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ) ,
                                          ),
                                          //Received In USD
                                          Container(
                                            width: double.maxFinite,
                                            child:Card(
                                              //margin: EdgeInsets.only(bottom: 28),
                                              child: Container(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    RichText(
                                                      text: TextSpan(
                                                        text: titletext[3],
                                                        style: TextStyle(fontSize: 15, color: Color(0xFF16191F)),
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text: '*',
                                                            style: TextStyle(fontSize: 15, color: Color(0xFFFA242C)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(top: 8),
                                                      decoration: BoxDecoration(
                                                          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                                                          border: Border.all(
                                                            color: Color(0xFF8F9297),
                                                            width: 1,
                                                          ),
                                                          color: Colors.white
                                                      ),
                                                      child: TextFormField(
                                                        controller: _receivedInUSDController,
                                                        keyboardType: TextInputType.number,
                                                        autofocus: false,
                                                        style: TextStyle(color: Color(0xFF16191F)),
                                                        decoration: InputDecoration(
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide.none,
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                color: Color(0xFF8F9297),
                                                                width: 1,
                                                              )),
                                                          enabled: true,
                                                          contentPadding: EdgeInsets.only(left: 12, right: 12),
                                                          hintText: '',
                                                          fillColor: Colors.white,
                                                        ),
                                                        onChanged: (value){
                                                          setState(() {
                                                            _receivedInUSD=double.parse(value);
                                                          });
                                                          //print("discount amount on change ${_exchangeRate}");
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ) ,
                                          ),
                                          //Received in Real
                                          Container(
                                            width: double.maxFinite,
                                            child:Card(
                                              //margin: EdgeInsets.only(bottom: 28),
                                              child: Container(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    RichText(
                                                      text: TextSpan(
                                                        text: titletext[4],
                                                        style: TextStyle(fontSize: 15, color: Color(0xFF16191F)),
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text: '*',
                                                            style: TextStyle(fontSize: 15, color: Color(0xFFFA242C)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(top: 8),
                                                      decoration: BoxDecoration(
                                                          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                                                          border: Border.all(
                                                            color: Color(0xFF8F9297),
                                                            width: 1,
                                                          ),
                                                          color: Colors.white
                                                      ),
                                                      child: TextFormField(
                                                        controller: _receivedInRealController,
                                                        keyboardType: TextInputType.number,
                                                        autofocus: false,
                                                        style: TextStyle(color: Color(0xFF16191F)),
                                                        decoration: InputDecoration(
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide.none,
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                color: Color(0xFF8F9297),
                                                                width: 1,
                                                              )),
                                                          enabled: true,
                                                          contentPadding: EdgeInsets.only(left: 12, right: 12),
                                                          hintText: '',
                                                          fillColor: Colors.white,
                                                        ),
                                                        onChanged: (value){
                                                          setState(() {
                                                            _receivedInReal=double.parse(value);
                                                          });
                                                          print("discount amount on change ${_receivedInReal}");
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ) ,
                                          ),

                                          //Grand Total in USD
                                          Container(
                                            margin: EdgeInsets.only(bottom: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    dataTotal[0].label,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 15,
                                                        color: Color(0xFF7B7B81)),
                                                  ),
                                                ),
                                                Text(
                                                  _grandTotalUSD.toString(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 15,
                                                      color: Color(0xFFFA242C)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          //Grand Total in Real
                                          Container(
                                            margin: EdgeInsets.only(bottom: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    dataTotal[1].label,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 15,
                                                        color: Color(0xFF7B7B81)),
                                                  ),
                                                ),
                                                Text(
                                                  _grandTotalReal.toString(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 15,
                                                      color: Color(0xFFFA242C)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          //Received in USD
                                          Container(
                                            margin: EdgeInsets.only(bottom: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    dataTotal[2].label,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 15,
                                                        color: Color(0xFF7B7B81)),
                                                  ),
                                                ),
                                                Text(
                                                  _receivedInUSD.toString(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 15,
                                                      color: Color(0xFFFA242C)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          //Received in Real
                                          Container(
                                            margin: EdgeInsets.only(bottom: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    dataTotal[3].label,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 15,
                                                        color: Color(0xFF7B7B81)),
                                                  ),
                                                ),
                                                Text(
                                                  _receivedInReal.toString(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 15,
                                                      color: Color(0xFFFA242C)),
                                                ),
                                              ],
                                            ),
                                          ),


                                          // Container(
                                          //   margin: EdgeInsets.only(top: 20, bottom: 10),
                                          //   height: 120,
                                          //   child: ListView.builder(
                                          //     physics: const NeverScrollableScrollPhysics(),
                                          //     itemCount: dataTotal.length,
                                          //     itemBuilder: (context, index) {
                                          //       return buildItemTotal(dataTotal[index]);
                                          //     },
                                          //   ),
                                          // )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );

                },
                childCount: 1,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        height: 60,
        padding: EdgeInsets.only(right: 16),
        child: Row(
          children: <Widget>[
            Spacer(),
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28.0),
              ),
              minWidth: 146,
              height: 40,
              color: Color(0xFFFA242C),
              onPressed: () {
                List<PostProductModel> products=List<PostProductModel>();

                postSale.UserId=_userLoggedIn.id;
                postSale.ExchangeRate=_exchangeRate;
                postSale.Discount=_discountAmount;
                postSale.DeliveryAmount=_deliveryPrice;
                postSale.ReceivedUSD=_receivedInUSD;
                postSale.ReceivedKHR=_receivedInReal;
                postSale.Amount=_subTotal;

                for(final cproduct in checkoutProducts){
                  products.add(new PostProductModel(
                    ProductId:cproduct.id,
                    Quantity: cproduct.productUnit.quantity,
                    Price: cproduct.productUnit.price,
                    ActualPrice: cproduct.productUnit.price,
                    UnitTypeId: cproduct.productUnit.unitTypeId,
                    DiscountAmount: 0,
                    DiscountPercentage: 0,
                    ProductDetailId: cproduct.productDetail.productDetailId
                  ));
                }
                postSale.Products=products;

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartClassSecond(postSale)),
                );
              },
              child: Text("បន្ទាប់",
                  style: TextStyle(fontSize: 14, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItemTotal(valueTotal total) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              total.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: Color(0xFF7B7B81)),
            ),
          ),
          Text(

            total.value,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: Color(0xFFFA242C)),
          ),
        ],
      ),
    );
  }

  Widget detail_textfield(BuildContext context, int i) {
    return Card(
      margin: EdgeInsets.only(bottom: 28),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: titletext[i],
                style: TextStyle(fontSize: 15, color: Color(0xFF16191F)),
                children: <TextSpan>[
                  TextSpan(
                    text: '*',
                    style: TextStyle(fontSize: 15, color: Color(0xFFFA242C)),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  border: Border.all(
                    color: Color(0xFF8F9297),
                    width: 1,
                  ),
                  color: Colors.white
              ),
              child: TextFormField(
                keyboardType: TextInputType.number,
                autofocus: false,

                style: TextStyle(color: Color(0xFF16191F)),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF8F9297),
                        width: 1,
                      )),
                  enabled: true,
                  contentPadding: EdgeInsets.only(left: 12, right: 12),
                  hintText: '',
                  fillColor: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void calculateAmount(){
    setState(() {
      _grandTotalUSD= (_subTotal-_discountAmount)+_deliveryPrice;
      _grandTotalReal=_grandTotalUSD*_exchangeRate;
    });
  }
  showAlertDialogLoginFail(BuildContext context){
    // set up the button
    Widget okButton = FlatButton(
      child: Text("បិទ"),
      onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("បង្ដើតការកម្ម៉ង់ថ្មី"),
      content: Text("កន្ត្រកទំនិញមិនអាចគ្មានទំនិញបានទេ។​"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}

class priceDetail {
  String label;
  String value;

  priceDetail(this.label, this.value);
}

class valueTotal {
  String label;
  String value;

  valueTotal(this.label, this.value);
}

