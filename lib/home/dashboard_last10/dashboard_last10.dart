import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:markarian_sales/api/api.dart';
import 'package:markarian_sales/home/dashboard_last10/detail_item_dashboard/detail.dart';
import 'package:markarian_sales/home/dashboard_last10/detail_item_sale_table/details_sales.dart';
import 'package:markarian_sales/home/dashboard_last10/lasttop_and_sale_table_pk/last10.dart';
import 'package:markarian_sales/home/dashboard_last10/lasttop_and_sale_table_pk/sale_last10.dart';
import 'package:markarian_sales/models/responesalelast.dart';

class DashboardLast10 extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<DashboardLast10> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //last10
                Last10Class(),
                SizedBox(
                  height: 50,
                ),
                //salelast10
                SaleLast10(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
