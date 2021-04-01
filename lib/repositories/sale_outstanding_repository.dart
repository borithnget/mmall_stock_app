import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:markarian_sales/api/api.dart';
import 'package:markarian_sales/model/sale_latest_10_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:flutter_image/network.dart';
import 'package:async/async.dart';

enum MovieLoadMoreStatus { LOADING, STABLE }
 class SaleOutstandingRepository{
   static Future<SalePaymentResponse> fetchOutstandingSales(int pageNumber,String userId) async {
     final url=Api.mainUrl+"Payment/OutstandingByUser?pageSize=50&pageNumber="+pageNumber.toString()+"&user_id="+userId;
     final response = await http.get(url);
     print(response.body);
     final jsonData = json.decode(response.body);
     final saleoutstandings= SalePaymentResponse.fromJson(jsonData);
     if (saleoutstandings == null) {
       throw Exception("An error occurred");
     }

     return saleoutstandings;
   }
}

class SaleOutstandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SalePaymentResponse>(
        future: SaleOutstandingRepository.fetchOutstandingSales(1,'bd9885e4-e11e-4547-b794-4b8b2b9ac8f9'),
        builder: (context, snapshots) {
          if (snapshots.hasError) return Text(snapshots.error);

          switch (snapshots.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());

            case ConnectionState.done:
              // ignore: missing_return
              return SaleOutstandingTile(saleOutstandings: snapshots.data);

            default:
              return Center(
                child: Text("Error"),
              );
          }
        });
  }
}


class SaleOutstandingTile extends StatefulWidget{
  final SalePaymentResponse saleOutstandings;
  SaleOutstandingTile({Key key,this.saleOutstandings}):super(key: key);

  @override
  State<StatefulWidget> createState() =>SaleOutstandingTileState();
  
}
class SaleOutstandingTileState extends State<SaleOutstandingTile>{
  MovieLoadMoreStatus loadMoreStatus=MovieLoadMoreStatus.STABLE;
  final ScrollController scrollController=ScrollController();
  List<SalePayment> salePayments;
  int currentPageNumber;
  CancelableOperation movieOperation;


  @override
  void initState() {
    salePayments = widget.saleOutstandings.model;
    currentPageNumber = widget.saleOutstandings.pageNumber;
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    if (movieOperation != null) movieOperation.cancel();
    super.dispose();
  }

  bool onNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (scrollController.position.maxScrollExtent > scrollController.offset && scrollController.position.maxScrollExtent - scrollController.offset <= 50) {
        if (loadMoreStatus != null && loadMoreStatus == MovieLoadMoreStatus.STABLE) {
          loadMoreStatus = MovieLoadMoreStatus.LOADING;
          movieOperation = CancelableOperation.fromFuture(SaleOutstandingRepository.fetchOutstandingSales(currentPageNumber + 1,'bd9885e4-e11e-4547-b794-4b8b2b9ac8f9').then((moviesObject) {
            currentPageNumber = moviesObject.pageNumber;
            loadMoreStatus = MovieLoadMoreStatus.STABLE;
            setState(() => salePayments.addAll(moviesObject.model));
          }));
        }
      }
    }
    return true;
  }

  Future<Null> _refreshGrid() async{
    print("refreshing....");
  }

  @override
  Widget build(BuildContext context) {
    final l = salePayments.length;
    return NotificationListener(
      onNotification: onNotification,
      child:new RefreshIndicator(
          child: GridView.builder(
        padding: EdgeInsets.only(
          top: 5.0,
        ),
        // EdgeInsets.only
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 0.85,
        ),
        // SliverGridDelegateWithFixedCrossAxisCount
        controller: scrollController,
        itemCount: salePayments.length,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          return MovieListTile(salePayment: salePayments[index]);
        },
      ),
          onRefresh: _refreshGrid
      ),
      // GridView.builder
    ); // NotificationListener
  }
  
}

//Start Sale Payment Item

class MovieListTile extends StatelessWidget {
  MovieListTile({this.salePayment});
  final SalePayment salePayment;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ), // BorderRadius.all
      ), // RoundedRectangleBorder
      color: Colors.white,
      elevation: 5.0,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(bottom: 5.0, right: 5.0),
              child: Text('Rating : ${salePayment.saleNumber}'),
            ), // Padding
          ) // Align
        ], //  <Widget>[]
      ), // Stack
    ); // Card
  }
}