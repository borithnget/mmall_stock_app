import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
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
                itemCount: 8,
                itemBuilder: (BuildContext context, int i) {
                  return ItemDetailView(context, i);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget ItemDetailView(BuildContext context, int index) {
  List<String> titleItem = [
    'Date',
    'Sales code',
    'Invoice number',
    'Customer',
    'Total amount in USD',
    'Total amount in KHR',
    'Payment in USD',
    'Payment in KHR',
  ];
  return Container(
    // height: 50,
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
                '26/01/2021 17:07 PM',
                style: TextStyle(
                  fontSize: 17,
                  color: index == 1
                      ? Color(0xFF007AFF)
                      : index == 3
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
          visible: index == 7 ? false : true,
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
