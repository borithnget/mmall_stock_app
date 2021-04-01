import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:markarian_sales/api/api.dart';
import 'package:markarian_sales/home/dashboard_last10/detail_item_sale_table/details_sales.dart';
import 'package:markarian_sales/model/sale_latest_10_model.dart';
import 'package:markarian_sales/models/responesalelast.dart';
import 'package:markarian_sales/services/sale_lastest10_service.dart';

class SaleLast10 extends StatefulWidget {
  @override
  _SaleLast10State createState() => _SaleLast10State();
}

var getDate;

class _SaleLast10State extends State<SaleLast10> {
  List<ListSaleModel> listSaleModel = new List<ListSaleModel>();
  var test;
  //data table sale
  int currentDataSale = 0;
  List<Widget> bodiesSaleData = [];

  @override
  void initState() {
    super.initState();
    //testGetProduct();
    bodiesSaleData.add(last10());
    bodiesSaleData.add(waiting());
    bodiesSaleData.add(finish());
    bodiesSaleData.add(cancel());
  }

  var mm;
  testGetProduct() async {
    mm = await fetchProducts();
    setState(() {
      listSaleModel = test;
    });
    for (var i in mm) {
      print('item: ${i.strCreatedDate}');
      getDate = "${i.strCreatedDate}";
    }
  }

  last10() {
    return allDataSale();
  }

  waiting() {
    return Container(
      height: 1000,
      child: Text('data'),
    );
  }

  finish() {
    return Container(
      height: 1000,
      child: Text('data'),
    );
  }

  cancel() {
    return Container(
      height: 1000,
      child: Text('data'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //SALE DATA Table
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                Text(
                  'DATA TABLE',
                  style: TextStyle(fontSize: 13, color: Color(0xFF77767E)),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  'SALES',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(top: 13, bottom: 13),
            child: Container(
              width: double.maxFinite,
              height: 30,
              child: CupertinoSegmentedControl<int>(
                borderColor: Color(0xFFFA242C),
                children: SaleWidgetname,
                selectedColor: Color(0xFFFA242C),
                onValueChanged: (int val) {
                  setState(() {
                    currentDataSale = val;
                    if (currentDataSale == 0) {
                      changebk = 0;
                    } else if (currentDataSale == 1) {
                      changebk = 1;
                    } else if (currentDataSale == 2) {
                      changebk = 2;
                    } else if (currentDataSale == 3) {
                      changebk = 3;
                    }
                  });
                },
                groupValue: currentDataSale,
              ),
            ),
          ),
          Container(
            child: bodiesSaleData[currentDataSale],
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  //itemListSaleData
  Widget allDataSale() {

     return FutureBuilder<SaleResponse>(
        future: getSaleLatest10(),
        builder: (context, snapshot) {
          //callAPI();
          if(snapshot.connectionState == ConnectionState.done) {

            if(snapshot.hasError){
              print(snapshot.error);
              return Text("Error");
            }

            //return Text('Title from Post JSON : ${snapshot.data.itemsCount}');
            return Container(
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
                              'ទឹកប្រាក់សរុប(\$)',
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
                              'ស្ថានភាព',
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
                    itemCount: snapshot.data.itemsCount,
                    itemBuilder: (BuildContext context, int i) {
                      return saleItem(context, i,snapshot.data.model[i]);
                    },
                  ),
                ],
              ),
            );
          }
          else
            return CircularProgressIndicator();
        }
    );


  }

  final Map<int, Widget> SaleWidgetname = const <int, Widget>{
    0: Text(
      'Last 10',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
    1: Text(
      'Waiting',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
    2: Text(
      'Finish',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
    3: Text(
      'Cancel',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
  };
}

int changebk = 0;

Future<List<ListSaleModel>> fetchProducts() async {
  final response = await get(Api.mainUrl + Api.dashboardSaleLast10);

  if (response.statusCode == 200) {
    ResponeSaleLast responeSaleLaston = responeSaleLastFromJson(response.body);
    print('Body ${responeSaleLaston.pageSize}');
    return responeSaleLaston.model;
  } else {
    throw Exception('Unable to fetch products from the REST API');
  }
}

//SaleItem
Widget saleItem(BuildContext context, int index,Sale sale) {
  return GestureDetector(
    onTap: () {
      print("Sale Data index: " + index.toString());
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Details_Sale()));
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
                    sale.strTotalAmount,
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
                  padding: EdgeInsets.only(left: 8, right: 8),
                  margin: EdgeInsets.only(top: 8, bottom: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: changebk != 2 && changebk != 3
                        ? Color(0xFFC7CDCA)
                        : changebk == 2
                            ? Color(0xFFFFC542)
                            : Color(0xFFFA242C),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    sale.strShowStatus,
                    style: TextStyle(fontSize: 10, color: Colors.white),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
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
