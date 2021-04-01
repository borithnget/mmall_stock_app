import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:markarian_sales/api/api.dart';
import 'package:markarian_sales/home/bottom_nav/tab_item.dart';
import 'package:markarian_sales/home/sub_menu/stock_balance/cart_store/cart_class_first.dart';
import 'package:markarian_sales/login_pk/login.dart';
import 'package:markarian_sales/model/commom_model.dart';
import 'package:markarian_sales/model/inventory_model.dart';
import 'package:markarian_sales/model/login_model.dart';
import 'package:markarian_sales/model/product_model.dart';
import 'package:markarian_sales/services/commom_service.dart';
import 'package:badges/badges.dart';
import 'package:chips_choice/chips_choice.dart';

class StockbalanceClass extends StatefulWidget {
  StockbalanceClass({this.color, this.title, this.onPush});
  final MaterialColor color;
  final String title;
  final ValueChanged<int> onPush;
  int _countSelectedProduct = 0;
  //int tag=0;
  List<ProductCheckOut> _productCheckOutLists = new List<ProductCheckOut>();

  @override
  _StockbalanceClassState createState() => _StockbalanceClassState();
}

class _StockbalanceClassState extends State<StockbalanceClass> {
  LoginResult _userLoggedIn = new LoginResult();
  int itemsCount = 0;
  List<Inventory> items = new List<Inventory>();
  int tag = 0;
  List<String> options = [
    '1 set',
    '3 sets',
    '5 sets',
  ];
  List<String> unitIdOptions = new List<String>();
  List<Product> checkoutProducts = new List<Product>();
  String selectedReportList;

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUserInfo().then((result) {
      setState(() {
        _userLoggedIn = result;
        if (result == null) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
            (Route<dynamic> route) => false,
          );
        } else {
          initialUserCart(_userLoggedIn.id);
        }
      });
    });

    initialStockBalance();
  }

  void initialStockBalance() async {
    getStockBalance(100, 1).then((response) {
      setState(() {
        items = response.model;
        itemsCount = response.pageSize;
        //print('count item $itemsCount');
      });
    });
  }

  void initialUserCart(String id) async {
    getCartItembyUser(id).then((response) {
      setState(() {
        checkoutProducts = response.model;
      });
    });
  }

  Future<void> _getStockBalanceData() async {
    setState(() {
      print("refreshing");
      initialStockBalance();
      initialUserCart(_userLoggedIn.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: widget.color,
          elevation: 0.0,
          title: Text(
            "ទំនិញក្នុងស្តុក",
            //style: TextStyle(color: Colors.black),
          ),
          // leading: new IconButton(
          //   icon: new Icon(
          //     Icons.arrow_back_ios_outlined,
          //     color: Color(0xFF2B3C57),
          //   ),
          //   onPressed: () {
          //     if (Navigator.canPop(context)) {
          //       Navigator.pop(context);
          //     } else {
          //       SystemNavigator.pop();
          //     }
          //   },
          // ),
          actions: <Widget>[
            Badge(
              position: BadgePosition.topEnd(top: 0, end: 10),
              animationDuration: Duration(milliseconds: 300),
              animationType: BadgeAnimationType.slide,
              //badgeContent: Text(widget._countSelectedProduct.toString(),style: TextStyle(color: Colors.white)),
              badgeContent: Text(checkoutProducts.length.toString(),
                  style: TextStyle(color: Colors.white)),
              child: IconButton(
                    icon: new Icon(
                      Icons.local_grocery_store,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      //print("Store");
                      //Navigator.pushNamed(context,"/cart");
                      //Navigator.of(context).pushNamed(TabItem.home.toString());
                      if(checkoutProducts.length>0){
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => CartClassFirst()),
                        // );
                        Navigator.push( context, MaterialPageRoute( builder: (context) => CartClassFirst()), ).then((value) => setState(() {
                          initialUserCart(_userLoggedIn.id);
                        }));
                      }else{
                        showAlertDialogLoginFail(context);
                      }

                    }),
            ),
          ],
        ),
      ),
      body: Container(
        color: Color(0xFFE5E5E5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 58.12,
              color: Color(0xFFE5E5E5),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 11.12,
                  bottom: 10,
                  left: 20,
                  right: 20,
                ),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color: Colors.white),
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
                          padding:
                              const EdgeInsets.only(left: 13.22, right: 13.22),
                          child: TextField(
                            maxLines: 1,
                            decoration: new InputDecoration.collapsed(
                              hintText: 'ស្វែងរកទំនិញ',
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                fontSize: 15.0,
                                color: Color(0xFFA3A3A3),
                              ),
                            ),
                            onChanged: (text) {
                              //print("filter text change $text");

                              getStockBalanceByAutoSuggust(100, 1, text)
                                  .then((response) {
                                setState(() {
                                  items = response.model;
                                  itemsCount = response.pageSize;
                                });
                              });
                            },
                          ),
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Divider(height: 1, color: Color(0xFFEEEEEE)),
            Expanded(
              //child: initProductStockBalanceList()
              child:items.length!=0? RefreshIndicator(
                  child:ListView.builder(
                      padding: EdgeInsets.only(top: 5),
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        //return userList(context, index,items[index]);
                        Inventory _inventory=items[index];
                        var productName=_inventory.product_code;

                        return Column(
                          children: [
                            Container(
                              color: Colors.black12,
                              width: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Center(
                                    child: Container(
                                      width: 63,
                                      height: 63,
                                      margin: EdgeInsets.only(left: 16, right: 15),
                                      //child: planetThumbnail
                                      child: new Container(
                                        child:FadeInImage.assetNetwork(
                                            placeholder: 'assets/markarianmall_pf.jpg',
                                            image: Api.imageMainUrl+_inventory.product_image,
                                            fit:BoxFit.cover

                                        ),
                                        //child: new Image.network(Api.imageMainUrl+_inventory.product_image,fit:BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 15, bottom: 9.51, right: 16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Text(
                                                productName,
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              Spacer(),
                                              Text(
                                                _inventory.total_quantity.toString().split('.')[0],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    color: Color(0xFFFA242C)),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: FractionallySizedBox(
                                                    child: Text(
                                                      _inventory.product_size_name==null?"":_inventory.product_size_name,
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 14, color: Color(0xFF7B7B81)),
                                                    ),
                                                  ),
                                                ),
                                                Flexible(
                                                  child: FractionallySizedBox(
                                                    child: FlatButton(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(19.95),
                                                      ),
                                                      color: Color(0xFFFA242C),
                                                      onPressed: () {
                                                        //addProductToCart(_inventory);

                                                        getProductDetailResponse(_inventory.product_id, _inventory.product_detail_id==null?"":_inventory.product_detail_id).then((response){

                                                          setState(() {
                                                            options=new List<String>();
                                                            unitIdOptions=new List<String>();

                                                            for(final unit in response.model.productUnits){
                                                              options.add(unit.unitName);
                                                              unitIdOptions.add(unit.unitTypeId);
                                                            }
                                                          });

                                                          showModalBottomSheet<void>(
                                                            context: context,
                                                            builder: (BuildContext context) {
                                                              String _diProductDesc=_inventory.product_code;
                                                              if(_inventory.product_size_name!=null)
                                                                  _diProductDesc=_diProductDesc +' - '+_inventory.product_size_name;
                                                              else
                                                                _diProductDesc=_diProductDesc+" - "+response.model.productName;
                                                              return Container(
                                                                height: 200,
                                                                color: Colors.white,
                                                                child: Center(
                                                                  child: Column(
                                                                    //mainAxisAlignment: MainAxisAlignment.,
                                                                    mainAxisSize: MainAxisSize.min,
                                                                    children: <Widget>[
                                                                      //const Text('Modal BottomSheet'),
                                                                      Container(
                                                                        child: Row(
                                                                          children: [
                                                                            ClipRRect(
                                                                              borderRadius: BorderRadius.circular(3),
                                                                              child: FadeInImage.assetNetwork(
                                                                                  placeholder: 'assets/markarianmall_pf.jpg',
                                                                                  image: Api.imageMainUrl+_inventory.product_image,
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
                                                                                      _diProductDesc,
                                                                                      maxLines: 2,
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      style: TextStyle(
                                                                                        fontSize: 14,
                                                                                        fontWeight: FontWeight.w400,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      MultiSelectChip(
                                                                        options,
                                                                        onSelectionChanged: (index,selectedList) {
                                                                          setState(() {
                                                                            selectedReportList = selectedList;
                                                                            tag=index;
                                                                          });
                                                                          //print("after selected ${selectedReportList} index ${tag}");
                                                                        },
                                                                      ),
                                                                      ListTile(
                                                                        //contentPadding: EdgeInsets.all(<some value here>),//change for side padding
                                                                        title: Row(
                                                                          children: <Widget>[
                                                                            Expanded(
                                                                                child: RaisedButton(
                                                                                  onPressed: () {
                                                                                    _inventory.unit = unitIdOptions[tag];
                                                                                    //addProductToCart(_inventory);

                                                                                    PostAddItemToCart item = new PostAddItemToCart();
                                                                                    item.UnitTypeId = unitIdOptions[tag];
                                                                                    item.ProductId = _inventory.product_id;
                                                                                    item.ProductDetailId = _inventory.product_detail_id;
                                                                                    item.CreateBy = _userLoggedIn.id;
                                                                                    item.QtyBalance = 0;
                                                                                    item.Price = 0;
                                                                                    item.DiscountPercentage = 0;
                                                                                    item.Discount = 0;

                                                                                    //print("Product Detail id ${item.ProductDetailId}");

                                                                                    postAddItemtoCartResponse(item).then((value) {
                                                                                      //print(value);
                                                                                      initialUserCart(_userLoggedIn.id);
                                                                                    });

                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  child: Text("បន្ថែមចូលកន្រ្តក"),
                                                                                  color: Colors.indigo,
                                                                                  textColor: Colors.white,
                                                                                )),
                                                                                Expanded(
                                                                                    child: RaisedButton(
                                                                                  onPressed: () => Navigator.pop(context),
                                                                                  child: Text("បិទ"),
                                                                                  color: Colors.redAccent,
                                                                                  textColor: Colors.white,
                                                                                )),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            });
                                                          },
                                                          child: Text(
                                                            "បញ្ចូលក្នុងកន្រ្តក",
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(height: 1, color: Color(0xFFEEEEEE)),
                              ],
                            );
                          }),
                      onRefresh: _getStockBalanceData
              )
                  : Center(child: CircularProgressIndicator()),
            )
          ],
        ),
      ),
    );
  }

  final planetThumbnail = new Container(
    child: new Image(
      image: new AssetImage('assets/markarianmall_pf.jpg'),
    ),
  );

  Widget initProductStockBalanceList() {
    return FutureBuilder<InventoryResponse>(
        future: getStockBalance(100, 1),
        builder: (context, snapshot) {
          //callAPI();
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text("Error ${snapshot.error}");
            }

            return ListView.builder(
                padding: EdgeInsets.only(top: 5),
                itemCount: snapshot.data.pageSize,
                itemBuilder: (BuildContext context, int index) {
                  return userList(context, index, snapshot.data.model[index]);
                });

            //return Text('Title from Post JSON : ${snapshot.data.itemsCount}');

          } else
            return CircularProgressIndicator();
        });
  }

  Widget userList(BuildContext context, int index, Inventory _inventory) {
    return Column(
      children: [
        Container(
          color: Colors.black12,
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Container(
                  width: 63,
                  height: 63,
                  margin: EdgeInsets.only(left: 16, right: 15),
                  //child: planetThumbnail
                  child: new Container(
                    child: FadeInImage.assetNetwork(
                        placeholder: 'assets/markarianmall_pf.jpg',
                        image: Api.imageMainUrl + _inventory.product_image,
                        fit: BoxFit.cover),
                    //child: new Image.network(Api.imageMainUrl+_inventory.product_image,fit:BoxFit.cover),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 9.51, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Text(
                            _inventory.product_code,
                            style: TextStyle(fontSize: 15),
                          ),
                          Spacer(),
                          Text(
                            _inventory.total_quantity.toString().split('.')[0],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color(0xFFFA242C)),
                          ),
                        ],
                      ),
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: FractionallySizedBox(
                                child: Text(
                                  _inventory.product_size_name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 14, color: Color(0xFF7B7B81)),
                                ),
                              ),
                            ),
                            Flexible(
                              child: FractionallySizedBox(
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(19.95),
                                  ),
                                  color: Color(0xFFFA242C),
                                  onPressed: () {
                                    //addProductToCart(_inventory);

                                    showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          height: 400,
                                          color: Colors.white,
                                          child: Center(
                                            child: Column(
                                              //mainAxisAlignment: MainAxisAlignment.,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                //const Text('Modal BottomSheet'),
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3),
                                                        child: Image.network(
                                                          Api.imageMainUrl +
                                                              _inventory
                                                                  .product_image,
                                                          height: 63,
                                                          width: 63,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 17),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                _inventory
                                                                        .product_code +
                                                                    ' - ' +
                                                                    _inventory
                                                                        .product_size_name,
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 17,
                                                              ),
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Expanded(
                                                                    child: Row(
                                                                      children: [
                                                                        Text(
                                                                          '\$',
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            color:
                                                                                Color(0xFFFA242C),
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        Text(
                                                                          'x ${tag}',
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                11,
                                                                            color:
                                                                                Color(0xFF6E6E6E),
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
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                MultiSelectChip(
                                                  options,
                                                  onSelectionChanged:
                                                      (index, selectedList) {
                                                    setState(() {
                                                      selectedReportList =
                                                          selectedList;
                                                      tag = index;
                                                    });
                                                  },
                                                ),
                                                Text(selectedReportList
                                                    .toString()),
                                                ListTile(
                                                  //contentPadding: EdgeInsets.all(<some value here>),//change for side padding
                                                  title: Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                          child: RaisedButton(
                                                        onPressed: () {},
                                                        child: Text(
                                                            "បន្ថែមចូលកន្រ្តក"),
                                                        color: Colors.indigo,
                                                        textColor: Colors.white,
                                                      )),
                                                      Expanded(
                                                          child: RaisedButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child: Text("បិទ"),
                                                        color: Colors.redAccent,
                                                        textColor: Colors.white,
                                                      )),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Text(
                                    "បញ្ចូលក្នុងកន្រ្តក",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(height: 1, color: Color(0xFFEEEEEE)),
      ],
    );
  }

  void setSelectedUnit(int tag) {
    setState(() {
      tag = tag;
    });
    print(tag);
  }

  void addProductToCart(Inventory _inventory) {
    widget._productCheckOutLists.add(new ProductCheckOut(
        ProductId: _inventory.product_id,
        ProductDetailId: _inventory.product_detail_id,
        UnitId: _inventory.unit));
    showBadge(widget._productCheckOutLists.length);
  }

  void showBadge(int number) {
    setState(() {
      widget._countSelectedProduct = number;
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
      content: Text("គ្មានទំនិញ។​"),
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

class MultiSelectChip extends StatefulWidget {
  final List<String> reportList;
  final Function(int, String) onSelectionChanged;
  MultiSelectChip(this.reportList, {this.onSelectionChanged});
  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  String selectedChoice = "";
  int selectedIndex = 0;
  _buildChoiceList() {
    List<Widget> choices = List();
    widget.reportList.asMap().forEach((index, item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          selected: selectedChoice == item,
          onSelected: (selected) {
            setState(() {
              selectedChoice = item;
              selectedIndex = index;
              widget.onSelectionChanged(index, selectedChoice);
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
