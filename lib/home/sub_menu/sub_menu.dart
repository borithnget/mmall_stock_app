import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:markarian_sales/home/sub_menu/stock_balance/stock_balance_class.dart';

class Submenuscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
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
      body: listviewbody(),
    );
  }
}

class listviewbody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      color: Colors.white,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 17, right: 17, top: 32.12),
        shrinkWrap: false,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return listItem(context, index);
        },
      ),
    );
  }
}

Widget listItem(BuildContext context, int index) {
  List<String> litemstext = [
    "Adjusting inventory",
    "Stock Balance",
    "View items in stock",
  ];
  List<String> litemsimg = [
    "assets/adjusting_inventory_img.png",
    "assets/stock_balance_img.png",
    "assets/stock_balance_img.png",
  ];
  return Card(
    color: Color(0xFF30444E),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    margin: EdgeInsets.only(bottom: 21),
    child: InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      onTap: () {
        print(index);
        var tmp;
        switch (index) {
          case 0:
            // tmp = AdjustingClass();
            break;
          case 1:
            tmp = StockbalanceClass();
            break;
          case 2:
            // tmp = ViewItemStockClass();
            break;
        }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => tmp),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 26),
        child: Row(
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new ExactAssetImage('assets/round_img.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                margin: EdgeInsets.all(17),
                child: Image(
                  image: AssetImage(
                    litemsimg[index],
                  ),
                  fit: BoxFit.fill,
                ),
                height: 30,
                width: 30,
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  litemstext[index],
                  style: TextStyle(color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Spacer(),
            Container(
              child: new Icon(
                Icons.navigate_next,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    ),
  );
}
