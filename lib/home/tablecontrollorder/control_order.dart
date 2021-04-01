import 'package:flutter/material.dart';

class ControlOrderTable extends StatefulWidget {
  @override
  _ControlOrderTableState createState() => _ControlOrderTableState();
}

class _ControlOrderTableState extends State<ControlOrderTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 10,
                left: 20,
                right: 20,
              ),
              child: Container(
                height: 37,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    color: Color(0xFFE4E3E3)),
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
                        ),
                      ),
                      flex: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(bottom: 50),
            child: Column(
              children: [
                Divider(
                  color: Color(0xFFEEEEEE),
                  thickness: 1,
                  height: 1,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 30, left: 15, right: 15, bottom: 6),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'DATA TABLE',
                          style:
                              TextStyle(fontSize: 13, color: Color(0xFF77767E)),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Awaiting approval',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
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
                                width: 108,
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
                                width: 132,
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
                        itemCount: 20,
                        itemBuilder: (BuildContext context, int i) {
                          return Awaiting_approval(
                            context,
                            i,
                          );
                        },
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
  }

  //Awaiting approval
  Widget Awaiting_approval(BuildContext context, int index) {
    return GestureDetector(
      onTap: () => print("Approval Data : " + index.toString()),
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
                      '25/01/2021 15:35 PM',
                      style: TextStyle(fontSize: 13),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Container(
                    width: 108,
                    alignment: Alignment.center,
                    child: Text(
                      '35.50',
                      style: TextStyle(fontSize: 13),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Container(
                    width: 132,
                    padding: EdgeInsets.only(left: 8, right: 8),
                    margin: EdgeInsets.only(top: 8, bottom: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFFC7CDCA)),
                    alignment: Alignment.center,
                    child: Text(
                      'Waiting for stock',
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
}
