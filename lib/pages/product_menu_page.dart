import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductMenuPage extends StatefulWidget{
  ProductMenuPage({this.color,this.title,this.onPush});
  final MaterialColor color;
  final String title;
  final ValueChanged<int> onPush;

  @override
  State<StatefulWidget> createState() =>_ListPageState();

}

class _ListPageState extends State<ProductMenuPage> {
  List lessons;

  @override
  void initState() {
    lessons = getLessons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(Lesson lesson) => ListTile(
      contentPadding:
      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
            border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.white24))),
        child: Icon(Icons.autorenew, color: Colors.white),
      ),
      title: Text(
        lesson.title,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
      trailing:
      Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => DetailPage(lesson: lesson)));
      },
    );

    Card makeCard(Lesson lesson) => Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: makeListTile(lesson),
      ),
    );

    final makeBody = Container(
      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: lessons.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(lessons[index]);
        },
      ),
    );


    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: widget.color,
      title: Text(widget.title),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.list),
          onPressed: () {},
        )
      ],
    );

    return Scaffold(
      //backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: topAppBar,
      body: makeBody,
      //bottomNavigationBar: makeBottom,
    );
  }
}

class Lesson {
  String title;
  String level;
  double indicatorValue;
  int price;
  String content;

  Lesson(
      {this.title, this.level, this.indicatorValue, this.price, this.content});
}

List getLessons() {
  return [
    Lesson(title: "ផលិតផលចូលថ្មី"),
    Lesson(title: "ផលិតផលលក់ដាច់ថ្ងៃនេះ"),
    Lesson(title: "ប្រភេទផលិតផល"),
    Lesson(title: "ប្រភទក្រុមផលិតផល"),
    Lesson(title: "ប្រភេទក្រុមរងផលិតផល"),
    Lesson(title: "ផលិតផលទាំងអស់"),
    Lesson(title: "រូបភាពផលិតផល"),

  ];
}