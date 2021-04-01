import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:markarian_sales/home/all_menu/our_order_and_make_new_order/our_order/order_details/detail_item_select/view_sale_detail.dart';

class OrderDetail extends StatefulWidget {
  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  List<String> titleItem = [
    'Date',
    'Sales code',
    'Customer',
    'Total amount in USD',
    'Total amount in KHR',
    'Payment in USD',
    'Payment in KHR',
  ];

  final data = [
    '12/02/2021 17:07 PM',
    'S-12-02-168',
    'VannDa',
    '58.35',
    '45,000,00',
    '58.35',
    '45,000,00',
  ];
  final TextEditingController _controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Details',
          style: TextStyle(
              color: Color(0xFF303139),
              fontWeight: FontWeight.w700,
              fontSize: 17),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  EdgeInsets.only(top: 15.12, left: 12, right: 12, bottom: 9.5),
              child: Text(
                'ALL DATA TABLE',
                style: TextStyle(color: Color(0xFF8E8E93), fontSize: 12),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(
                  color: Color(0xFFC6C6C9),
                  width: 0.5,
                ),
                top: BorderSide(
                  color: Color(0xFFC6C6C9),
                  width: 0.5,
                ),
              )),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 7,
                itemBuilder: (BuildContext context, int i) {
                  return ItemDetailOrder(context, i);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (BuildContext context, int i) {
                  return orderButton(context, i);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget ItemDetailOrder(BuildContext context, int index) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 5.5, bottom: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titleItem[index],
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF8E8E93),
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (index == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewSaleDetail(null)),
                        );
                      }
                    });
                  },
                  child: Text(
                    data[index],
                    style: TextStyle(
                      fontSize: 17,
                      color: index == 1
                          ? Color(0xFF007AFF)
                          : index == 2
                              ? Color(0xFF007AFF)
                              : Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
              ],
            ),
          ),
          Visibility(
            visible: index == 6 ? false : true,
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Divider(
                height: 1,
                thickness: 1,
                color: Color(0xFFC6C6C9),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget orderButton(BuildContext context, int index) {
    return Container(
      padding: EdgeInsets.all(4),
      child: SizedBox(
        height: 40,
        child: RaisedButton.icon(
          elevation: 0.0,
          color: background[index],
          onPressed: () {
            switch (index) {
              case 0:
                print('click $index');
                break;
              case 1:
                print('click $index');
                break;
              case 2:
                print('click $index');
                break;
              case 3:
                print('click $index');
                showBottomSheet1();
                break;
              case 4:
                print('click $index');

                break;
              default:
                break;
            }
          },
          label: Text(
            title[index],
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
          ),
          icon: Icon(
            icons[index],
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void showBottomSheet1() {
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
                        minLines: 5,
                        maxLines: 15,
                        autocorrect: false,
                        decoration: InputDecoration(
                          hintText: '',
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
                                onPressed: () {},
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
                                onPressed: () {},
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

  final title = [
    'កែប្រែ',
    'អតិថិជនប្តូរទំនិញ',
    'បោះពុម្ពវិក័យបត្រ',
    'លុបការកម្ម៉ង់',
    'មើលលំហូរការកម្ម៉ង់',
  ];

  final icons = [
    Icons.carpenter,
    Icons.share,
    Icons.print,
    Icons.delete,
    Icons.more,
  ];

  final background = [
    Color(0xFF1DA7EA),
    Color(0xFFFFC542),
    Color(0xFF1DA7EA),
    Color(0xFFFA242C),
    Color(0xFF1DA7EA),
  ];
}
