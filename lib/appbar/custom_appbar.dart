import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Brightness brightness;
  CustomAppBar({Key key, this.brightness})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  static double heightAppbar = 37.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppBarTheme appBarTheme = AppBarTheme.of(context);
    final Brightness brightness = widget.brightness ??
        appBarTheme.brightness ??
        theme.primaryColorBrightness;

    final SystemUiOverlayStyle overlayStyle = brightness == Brightness.dark
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark;

    return Semantics(
      container: true,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: overlayStyle,
        child: Container(
          color: Colors.cyan,
          height:
              widget.preferredSize.height + MediaQuery.of(context).padding.top,
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top, left: 10, right: 15),
          child: Center(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.transparent,
                      child: InkWell(
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onTap: () {
                          print('search text');
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => SearchTyping()),
                          // );
                        },
                        child: Container(
                          color: Colors.transparent,
                          height: heightAppbar,
                          padding: EdgeInsets.only(left: 11, right: 11),
                          child: Row(
                            children: [
                              Icon(Icons.search, size: 21, color: Colors.black),
                              SizedBox(
                                width: 13,
                              ),
                              Text(
                                "Search for product",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
