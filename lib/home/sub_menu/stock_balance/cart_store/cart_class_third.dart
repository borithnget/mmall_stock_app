import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:markarian_sales/appbar/custombar.dart';
import 'package:markarian_sales/customdropdown/custom_dropdown.dart';
import 'package:markarian_sales/home/app.dart';
import 'package:markarian_sales/home/sub_menu/stock_balance/cart_store/item_secondcart/item.dart';
import 'package:markarian_sales/home/sub_menu/stock_balance/cart_store/success/done.dart';
import 'package:markarian_sales/model/commom_model.dart';
import 'package:markarian_sales/services/commom_service.dart';

class CartClassThird extends StatefulWidget {
  final PostSaleModel postSale;
  CartClassThird(this.postSale, {Key key}) : super(key: key);

  @override
  _CartClassSecondState createState() => _CartClassSecondState();
}

class _CartClassSecondState extends State<CartClassThird>
    with AutomaticKeepAliveClientMixin {
  final _deliveryContactPersonController = new TextEditingController(text: "");
  final _deliveryContactPhoneController = new TextEditingController(text: "");
  final _remarkController = new TextEditingController(text: "");
  List<DeliveryModel> _deliveryList = new List<DeliveryModel>();
  List<PaymentTypeModel> _paymentTypeList = new List<PaymentTypeModel>();

  //dropdown
  final List<TypeModel> _typeModelList = [
    TypeModel(type: 'General', page: '0'),
    TypeModel(type: 'Public', page: '1'),
  ];

  TypeModel _typeModelModel = TypeModel();
  DeliveryModel _selectedDelivery = DeliveryModel();
  PaymentTypeModel _selectedPaymentType = PaymentTypeModel();

  List<DropdownMenuItem<TypeModel>> _typeDropdownList;
  List<DropdownMenuItem<DeliveryModel>> _deliveryDropdownList;
  List<DropdownMenuItem<PaymentTypeModel>> _paymentTypeDropdownList;

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

  List<DropdownMenuItem<DeliveryModel>> _buildDeliveryDropdown(
      List deliveryModelList) {
    List<DropdownMenuItem<DeliveryModel>> items = List();
    for (DeliveryModel typeModel in deliveryModelList) {
      items.add(DropdownMenuItem(
        value: typeModel,
        child: Text(typeModel.shipperName),
      ));
    }
    return items;
  }

  List<DropdownMenuItem<PaymentTypeModel>> _buildPaymentTypeDropdown(
      List paymentTypeModelList) {
    List<DropdownMenuItem<PaymentTypeModel>> items = List();
    for (PaymentTypeModel typeModel in paymentTypeModelList) {
      items.add(DropdownMenuItem(
        value: typeModel,
        child: Text(typeModel.paymentType),
      ));
    }
    return items;
  }

  _onChangeTypeModelDropdown(TypeModel typeModel) {
    setState(() {
      _typeModelModel = typeModel;
    });
  }

  _onChangeTypeModelDropdown1(DeliveryModel typeModel) {
    setState(() {
      _selectedDelivery = typeModel;
    });
  }

  _onChangeTypeModelDropdown2(PaymentTypeModel typeModel) {
    setState(() {
      _selectedPaymentType = typeModel;
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _typeDropdownList = _buildTypeDropdown(_typeModelList);
    _typeModelModel = _typeModelList[0];
    super.initState();

    getSaleInititalPage3Reseponse().then((result) {
      setState(() {
        _deliveryList = result.model.deliveries;
        _paymentTypeList = result.model.paymentTypes;

        _paymentTypeDropdownList = _buildPaymentTypeDropdown(_paymentTypeList);
        _deliveryDropdownList = _buildDeliveryDropdown(_deliveryList);

        _selectedDelivery = _deliveryList[0];
        _selectedPaymentType = _paymentTypeList[0];
      });
    });
  }

  Widget body() {
    return Container(
      child: Column(
        children: [
          Container(
            height: 43,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 16, right: 16),
            color: Colors.white,
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
          Divider(
            height: 1,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  height: 208,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 11),
                  color: Colors.white,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return detail_dropdown(context, index);
                    },
                  ),
                ),
                Container(
                  height: 208,
                  color: Colors.white,
                  // child: ListView.builder(
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   itemCount: 2,
                  //   itemBuilder: (context, index) {
                  //     return detail_text(context, index);
                  //   },
                  // ),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 29),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          namePhone[0],
                          style:
                              TextStyle(fontSize: 15, color: Color(0xFF16191F)),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 8),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0)),
                                border: Border.all(
                                  color: Color(0xFF8F9297),
                                  width: 1,
                                ),
                                color: Colors.white),
                            child: TextFormField(
                              controller: _deliveryContactPersonController,
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
                            )),
                        Text(
                          namePhone[1],
                          style:
                              TextStyle(fontSize: 15, color: Color(0xFF16191F)),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 8),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0)),
                                border: Border.all(
                                  color: Color(0xFF8F9297),
                                  width: 1,
                                ),
                                color: Colors.white),
                            child: TextFormField(
                              controller: _deliveryContactPhoneController,
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
                                contentPadding:
                                    EdgeInsets.only(left: 12, right: 12),
                                hintText: '',
                                fillColor: Colors.white,
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 16, right: 16, top: 28, bottom: 29),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ទូទាត់ប្រាក់តាមរយៈ:",
                  style: TextStyle(fontSize: 15, color: Color(0xFF16191F)),
                ),
                Container(
                  height: 50,
                  width: double.maxFinite,
                  child: CustomDropdown(
                    dropdownMenuItemList: _paymentTypeDropdownList,
                    onChanged: _onChangeTypeModelDropdown2,
                    value: _selectedPaymentType,
                    isEnabled: true,
                  ),
                ),
                SizedBox(
                  height: 28,
                ),
                Text(
                  "សម្គាល់:",
                  style: TextStyle(fontSize: 15, color: Color(0xFF16191F)),
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
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: new TextField(
                              controller: _remarkController,
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
    );
  }

  showAlertDialogLoginFail(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("បិទ"),
      onPressed: () => Navigator.pop(context, false),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("រក្សាទុកការកម្ម៉ង់"),
      content: Text("ប្រតិបត្តិការមិនបានជោគជ័យ។"),
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

  //
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
              minWidth: 161,
              height: 40,
              color: Color(0xFF63BCF5),
              onPressed: () {
                PostDeliveryModel deliver = PostDeliveryModel(
                    DeliveryId: _selectedDelivery.id,
                    DeliveryDate: selectedDate.toString(),
                    ContactPersonPhone: _deliveryContactPhoneController.text,
                    ContactPersonName: _deliveryContactPersonController.text);
                widget.postSale.Delivery = deliver;
                widget.postSale.PaymentTypeId =
                    _selectedPaymentType.paymentTypeId;
                widget.postSale.Description = _remarkController.text;

                postSaleResponse(widget.postSale).then((response) {
                  print(response.body);
                  if (response.body == "") {
                    showAlertDialogLoginFail(context);
                  } else {
                    var saleresponse=saleDetailResponseFromJson(response.body).model;
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CheckOutSuccess(saleresponse.id)),
                          (Route<dynamic> route) => false,
                    );
                  }
                });
              },
              child: Text("បង្កើតការកម្ម៉ង់ថ្មី",
                  style: TextStyle(fontSize: 14, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  List<String> namePhone = ["ទំនាក់ទំនង :", "លេខទូរសព្ទ :"];

  Widget detail_text(BuildContext context, int i) {
    return Container(
      margin: EdgeInsets.only(bottom: 29),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            namePhone[i],
            style: TextStyle(fontSize: 15, color: Color(0xFF16191F)),
          ),
          Container(
              margin: EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  border: Border.all(
                    color: Color(0xFF8F9297),
                    width: 1,
                  ),
                  color: Colors.white),
              child: i == 0
                  ? TextFormField(
                      controller: _deliveryContactPersonController,
                      keyboardType: i == 0
                          ? TextInputType.emailAddress
                          : TextInputType.number,
                      autofocus: false,
                      style: TextStyle(color: Color(0xFF16191F)),
                      initialValue: '',
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
                    )
                  : TextFormField(
                      controller: _deliveryContactPersonController,
                      keyboardType: i == 0
                          ? TextInputType.emailAddress
                          : TextInputType.number,
                      autofocus: false,
                      style: TextStyle(color: Color(0xFF16191F)),
                      initialValue: '',
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
                    )),
        ],
      ),
    );
  }

  List<String> nameDayandService = [
    "ក្រុមហ៊ុនដឹកជញ្ជូន *:",
    "កាលបរិច្ឆេទដឹកជញ្ជូន:"
  ];

  Widget detail_dropdown(BuildContext context, int i) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            nameDayandService[i],
            style: TextStyle(fontSize: 15, color: Color(0xFF16191F)),
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            height: 50,
            child: Container(
              width: double.maxFinite,
              child: i == 1
                  ?
                  // CustomDropdown(
                  //   dropdownMenuItemList: _typeDropdownList,
                  //   onChanged: _onChangeTypeModelDropdown,
                  //   value: _typeModelModel,
                  //   isEnabled: true,
                  // )
                  calendarDialog()
                  : CustomDropdown(
                      dropdownMenuItemList: _deliveryDropdownList,
                      onChanged: _onChangeTypeModelDropdown1,
                      value: _selectedDelivery,
                      isEnabled: true,
                    ),
            ),
          )
        ],
      ),
      margin: EdgeInsets.only(bottom: 29),
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
}
