import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:markarian_sales/model/post_model.dart';
import 'package:markarian_sales/services/post_service.dart';
import 'package:markarian_sales/model/sale_latest_10_model.dart';
import 'package:markarian_sales/services/sale_lastest10_service.dart';

class PostPage extends StatefulWidget{
  static String TAG="Post Page";
  _PostPageState createState()=>new _PostPageState();
}

class _PostPageState extends State<PostPage>{

  callAPI(){
    Post post = Post(
        body: 'Testing body body body',
        title: 'Flutter jam6'
    );
    createPost(post).then((response){
      if(response.statusCode > 200)
        print(response.body);
      else
        print(response.statusCode);
    }).catchError((error){
      print('error : $error');
    });
  }

  onSelectedRow(bool selected, Sale sale,BuildContext context) async {
    //setState(() {
      if (selected) {
        //selectedUsers.add(user);
        print(sale.saleNumber);
        showAlertDialog(context,sale);
      } else {
        //selectedUsers.remove(user);
      }
    //});
  }

  showAlertDialog(BuildContext context,Sale sale) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () => Navigator.pop(context, false),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Sale Detail"),
      content: Text(sale.saleNumber),
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        appBar: AppBar(),
        body : FutureBuilder<SaleResponse>(
            future: getSaleLatest10(),
            builder: (context, snapshot) {
              //callAPI();
              if(snapshot.connectionState == ConnectionState.done) {

                if(snapshot.hasError){
                  return Text("Error");
                }

                //return Text('Title from Post JSON : ${snapshot.data.title}');
                return ListView(children: <Widget>[
                  Center(
                    child: Text(
                      'People-Chart',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )),
                    DataTable(
                      columns: [
                        DataColumn(label: Text(
                          'ID',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
                        )),
                        DataColumn(label: Text(
                          'Name',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
                        )),
                        DataColumn(label: Text(
                          'Profession',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
                        )),
                      ],
                      /*
                      rows: [
                        DataRow(cells: [
                          DataCell(Text('1')),
                          DataCell(Text('Stephen')),
                          DataCell(Text('Actor')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('5')),
                          DataCell(Text('John')),
                          DataCell(Text('Student')),
                        ]),

                      ],*/
                      rows: snapshot.data.model.map((sale)=>
                          DataRow(
                              onSelectChanged: (b) {
                                //print("Onselect");
                                onSelectedRow(b, sale,context);
                              },
                              cells: [
                                DataCell(
                                  Container(
                                    //width:40,
                                    child:Text(sale.strCreatedDate)
                                )),
                                DataCell(
                                    Container(
                                        width: 40, //SET width
                                        child: Text(sale.strTotalAmount)
                                    )
                                ),
                                DataCell(Text(sale.strShowStatus)),
                              ]
                          ),
                      ).toList(),
              )
              ]);
              }
              else
                return CircularProgressIndicator();
            }
        )
    );
  }

}