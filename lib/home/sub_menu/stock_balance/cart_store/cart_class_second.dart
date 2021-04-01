import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:markarian_sales/appbar/custombar.dart';
import 'package:markarian_sales/customdropdown/custom_dropdown.dart';
import 'package:markarian_sales/home/sub_menu/stock_balance/cart_store/cart_class_third.dart';
import 'package:markarian_sales/home/sub_menu/stock_balance/cart_store/item_secondcart/item.dart';
import 'package:markarian_sales/model/commom_model.dart';
import 'package:markarian_sales/services/commom_service.dart';

class CartClassSecond extends StatefulWidget {
  final PostSaleModel postSale;
  CartClassSecond(this.postSale, {Key key}) : super(key: key);

  @override
  _CartClassSecondState createState() => _CartClassSecondState();
}

class _CartClassSecondState extends State<CartClassSecond> {
  final _customerNameController = new TextEditingController(text: "");
  final _customerPhoneController = new TextEditingController(text: "");
  final _customerAddressController = new TextEditingController(text: "");
  //dropdown
  final List<TypeModel> _typeModelList = [
    TypeModel(type: 'Facebook Page', page: '0'),
    TypeModel(type: 'Youtube', page: '1'),
  ];

  List<OrderPlatform> _orderPlatformList = new List<OrderPlatform>();
  List<OrderPlatformDetail> _orderPlatformDetailList =
      new List<OrderPlatformDetail>();
  String _saleNumber = "";

  TypeModel _typeModelModel = TypeModel();
  OrderPlatform _selectedOrderPlatform = new OrderPlatform();
  OrderPlatformDetail _selectedOrderPlatformDetail = new OrderPlatformDetail();

  // List<DropdownMenuItem<TypeModel>> _typeDropdownList;
  List<DropdownMenuItem<OrderPlatform>> _orderPlatformDropdownList;
  List<DropdownMenuItem<OrderPlatformDetail>> _orderPlatformDetailDropdownList;

  List<DropdownMenuItem<TypeModel>> _buildTypeDropdown(List typeModelList) {
    List<DropdownMenuItem<TypeModel>> items = List();
    for (TypeModel typeModel in typeModelList) {
      items.add(DropdownMenuItem(
        value: typeModel,
        child: Text(typeModel.type),
      ));
    }
    return items;
  }

  List<DropdownMenuItem<OrderPlatform>> _buildOrderPlatformDropdown(
      List<OrderPlatform> orderPlatformList) {
    List<DropdownMenuItem<OrderPlatform>> items = List();
    for (final typeModel in orderPlatformList) {
      items.add(DropdownMenuItem(
        value: typeModel,
        child: Text(typeModel.orderPlatfromName),
      ));
    }
    return items;
  }

  List<DropdownMenuItem<OrderPlatformDetail>> _buildOrderPlatformDetailDropdown(
      List<OrderPlatformDetail> orderPlatformDetailList) {
    List<DropdownMenuItem<OrderPlatformDetail>> items = List();
    for (final typeModel in orderPlatformDetailList) {
      items.add(DropdownMenuItem(
        value: typeModel,
        child: Text(typeModel.orderPlatformDetailName),
      ));
    }
    return items;
  }

  _onChangeTypeModelDropdown(TypeModel typeModel) {
    setState(() {
      _typeModelModel = typeModel;
    });
  }

  _onChangeTypeModelDropdown1(OrderPlatform typeModel) {
    setState(() {
      _selectedOrderPlatform = typeModel;
    });
  }

  _onChangeTypeModelDropdown2(OrderPlatformDetail typeModel) {
    setState(() {
      _selectedOrderPlatformDetail = typeModel;
      //print(_selectedOrderPlatformDetail.orderPlatformDetailName);
    });
  }

  @override
  void initState() {
    super.initState();

    getSaleInitialPage2Response().then((result) {
      print(result.model.orderPlatforms.length);
      setState(() {
        _saleNumber = result.model.saleNumber;
        _orderPlatformList = result.model.orderPlatforms;
        _orderPlatformDetailList = result.model.orderPlatformDetails;

        // _typeDropdownList = _buildTypeDropdown(_typeModelList);
        _orderPlatformDropdownList =
            _buildOrderPlatformDropdown(_orderPlatformList);
        _orderPlatformDetailDropdownList =
            _buildOrderPlatformDetailDropdown(_orderPlatformDetailList);
        // _typeModelModel = _typeModelList[0];
        _selectedOrderPlatform = _orderPlatformList[0];
        _selectedOrderPlatformDetail = _orderPlatformDetailList[0];
      });
    });
  }
  //

  List<String> titledrop = [
    "កាលបរិច្ឆេទកម្ម៉ង់ :",
    "កម្ម៉ង់តាមរយ :",
    "ឈ្មោះភ្លែតវ៉ម :",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: MyCustomAppBar(
        height: 50,
        title: "បង្កើតការកម្ម៉ង់ថ្មី",
      ),
      body: Container(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return body();
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
                int _countCustomerValid=0;
                var ContactPhonses=[_customerPhoneController.text.toString()];
                //ContactPhonses.add(_customerPhoneController.text.toString());
                print(ContactPhonses);
                PostCustomerModel postCustomer=PostCustomerModel(
                  CustomerName: _customerNameController.text,
                  Address:_customerAddressController.text,
                  ContactPhones: ContactPhonses,
                );

                widget.postSale.SaleDate=selectedDate.toString();
                widget.postSale.OrderPlatformId=_selectedOrderPlatform.orderPlatformId;
                widget.postSale.OrderPlatformDetailId=_selectedOrderPlatformDetail.orderPlatformDetailId;
                widget.postSale.Customer=postCustomer;
                //print(widget.postSale.SaleDate);
                if(_customerNameController.text.isEmpty)
                  _countCustomerValid++;
                if(_customerAddressController.text.isEmpty)
                  _countCustomerValid++;

                if(_countCustomerValid>0){
                  showAlertDialogLoginFail(context);
                }else{
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartClassThird(widget.postSale)),
                  );
                }

              },
              child: Text("បន្ទាប់",
                  style: TextStyle(fontSize: 14, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget body() {
    return Container(
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'លេខកូដកម្ម៉ង់ :',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Color(0xFF7B7B81)),
                  ),
                ),
                Text(
                  _saleNumber,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Color(0xFF7B7B81)),
                ),
              ],
            ),
          ),
          Container(
            height: 300,
            padding: EdgeInsets.only(left: 16, right: 16),
            color: Colors.white,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return detail_dropdown(context, index);
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15, bottom: 21),
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  height: 43,
                  margin: EdgeInsets.only(left: 16, right: 16),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'ពត៌មានអតិថិជន',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: Color(0xFF16191F)),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                ),
                Container(
                  margin: EdgeInsets.only(left: 16, right: 16, top: 11),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "ឈ្មោះអតិថិជន :",
                          style:
                              TextStyle(fontSize: 15, color: Color(0xFF16191F)),
                          children: <TextSpan>[
                            TextSpan(
                              text: '*',
                              style: TextStyle(
                                  fontSize: 15, color: Color(0xFFFA242C)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                            border: Border.all(
                              color: Color(0xFF8F9297),
                              width: 1,
                            ),
                            color: Colors.white),
                        child: TextFormField(
                          controller: _customerNameController,
                          keyboardType: TextInputType.emailAddress,
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
                            contentPadding:
                                EdgeInsets.only(left: 12, right: 12),
                            hintText: '',
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 28,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "លេខទូរស័ព្ទ :",
                          style:
                              TextStyle(fontSize: 15, color: Color(0xFF16191F)),
                          children: <TextSpan>[
                            TextSpan(
                              text: '*',
                              style: TextStyle(
                                  fontSize: 15, color: Color(0xFFFA242C)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                            border: Border.all(
                              color: Color(0xFF8F9297),
                              width: 1,
                            ),
                            color: Colors.white),
                        child: TextFormField(
                          controller: _customerPhoneController,
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
                            contentPadding: EdgeInsets.only(
                              left: 12,
                              right: 12,
                            ),
                            hintText: '',
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 28,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "អាស័យដ្ឋាន :",
                          style:
                              TextStyle(fontSize: 15, color: Color(0xFF16191F)),
                          children: <TextSpan>[
                            TextSpan(
                              text: '*',
                              style: TextStyle(
                                  fontSize: 15, color: Color(0xFFFA242C)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5.0)),
                            border: Border.all(
                              color: Color(0xFF8F9297),
                              width: 1,
                            ),
                            color: Colors.white),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: 127.0,
                          ),
                          child: new Scrollbar(
                            child: new SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              reverse: true,
                              child: SizedBox(
                                height: 117.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12),
                                  child: new TextField(
                                    controller: _customerAddressController,
                                    maxLines: 100,
                                    decoration: new InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Add your text here',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget detail_dropdown(BuildContext context, int i) {
    return Container(
      margin: EdgeInsets.only(bottom: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: titledrop[i],
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
            height: 45,
            child: Container(
                width: double.maxFinite,
                child: i == 1
                    ? CustomDropdown(
                        dropdownMenuItemList: _orderPlatformDropdownList,
                        onChanged: _onChangeTypeModelDropdown1,
                        value: _selectedOrderPlatform,
                        isEnabled: true,
                      )
                    : i == 2
                        ? CustomDropdown(
                            dropdownMenuItemList:
                                _orderPlatformDetailDropdownList,
                            onChanged: _onChangeTypeModelDropdown2,
                            value: _selectedOrderPlatformDetail,
                            isEnabled: true,
                          )
                        // :CustomDropdown(
                        //   dropdownMenuItemList: _typeDropdownList,
                        //   onChanged: _onChangeTypeModelDropdown,
                        //   value:_typeModelModel,
                        //   isEnabled: true,
                        // ),
                        : calendarDialog()),
          )
        ],
      ),
    );
  }

  //calendar
  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Widget calendarDialog() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectDate(context);
        });
      },
      child: Container(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        margin: EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            border: Border.all(
              color: Color(0xFF8F9297),
              width: 1,
            ),
            color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            new Text("${selectedDate.toLocal()}".split(' ')[0]),
            Icon(
              Icons.keyboard_arrow_down,
              color: Color(0xFFAFAFAF),
            ),
          ],
        ),
      ),
    );
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
      content: Text("សូមបញ្ចូលពត៌មានអតិថិជន ឈ្មោះ លេខទូរសព្ទ អាស័យដ្ឋាន។​"),
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
