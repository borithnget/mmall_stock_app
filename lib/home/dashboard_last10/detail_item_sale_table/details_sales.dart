import 'package:flutter/material.dart';

class Details_Sale extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details_Sale> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Details',
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Color(0xFF303139)),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF2B3C57),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  EdgeInsets.only(top: 35.12, left: 12, right: 12, bottom: 9.5),
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
                itemCount: 4,
                itemBuilder: (BuildContext context, int i) {
                  return ItemDetailViewSale(context, i);
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: double.maxFinite,
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
              padding:
                  EdgeInsets.only(top: 16, left: 16, bottom: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Status',
                    style: TextStyle(fontSize: 15, color: Color(0xFF16191F)),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 28,
                    width: 117,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFFC7CDCA),
                    ),
                    child: Text(
                      'Waiting for stock',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget ItemDetailViewSale(BuildContext context, int index) {
  List<String> titleItem = [
    'Sales code',
    'Customer',
    'Date',
    'Total amount USD',
  ];
  return Container(
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
              Text(
                'S-21-01-180',
                style: TextStyle(
                  fontSize: 17,
                  color: index == 0
                      ? Color(0xFF007AFF)
                      : index == 1
                          ? Color(0xFF007AFF)
                          : Colors.black,
                ),
              ),
              SizedBox(
                height: 6,
              ),
            ],
          ),
        ),
        Visibility(
          visible: index == 3 ? false : true,
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
