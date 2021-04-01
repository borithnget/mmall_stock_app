import 'package:flutter/material.dart';
import 'package:markarian_sales/home/all_menu/payment_pakage/payment_activity.dart';
import 'package:markarian_sales/home/bottom_nav/color_detail_page.dart';
import 'package:markarian_sales/home/bottom_nav/colors_list_page.dart';
import 'package:markarian_sales/home/bottom_nav/tab_item.dart';
import 'package:markarian_sales/home/sub_menu/stock_balance/cart_store/cart_class_first.dart';
import 'package:markarian_sales/home/sub_menu/stock_balance/stock_balance_class.dart';
import 'package:markarian_sales/pages/account_page.dart';
import 'package:markarian_sales/pages/product_menu_page.dart';
import 'package:markarian_sales/pages/home_page.dart';
import 'package:markarian_sales/pages/payment_page.dart';
import 'package:markarian_sales/pages/stock_page.dart';


class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
  static const String cart='/cart';
}

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;

  void _push(BuildContext context, {int materialIndex: 500}) {
    var routeBuilders = _routeBuilders(context, materialIndex: materialIndex);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => routeBuilders[TabNavigatorRoutes.detail](context),
      ),
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context, {int materialIndex: 500}) {
    switch(tabItem.index){
      case 0:
        return {
          TabNavigatorRoutes.root: (context) => HomePage(
            color: activeTabColor[tabItem],
            title: tabName[tabItem],
            onPush: (materialIndex) =>
                _push(context, materialIndex: materialIndex),
          ),
          // TabNavigatorRoutes.detail: (context) => ColorDetailPage(
          //   color: activeTabColor[tabItem],
          //   title: tabName[tabItem],
          //   materialIndex: materialIndex,
          // ),
        };
        break;
      case 1:
        return {
          TabNavigatorRoutes.root: (context) => StockbalanceClass(
            color: activeTabColor[tabItem],
            title: tabName[tabItem],
            onPush: (materialIndex) =>
                _push(context, materialIndex: materialIndex),
          ),
          // TabNavigatorRoutes.detail: (context) => ColorDetailPage(
          //   color: activeTabColor[tabItem],
          //   title: tabName[tabItem],
          //   materialIndex: materialIndex,
          // ),
        };
        break;
      case 2:
        return {
          // TabNavigatorRoutes.root: (context) => CartPage(
          //   color: activeTabColor[tabItem],
          //   title: tabName[tabItem],
          //   onPush: (materialIndex) =>
          //       _push(context, materialIndex: materialIndex),
          // ),
          TabNavigatorRoutes.root: (context) => ProductMenuPage(
            color: activeTabColor[tabItem],
            title: tabName[tabItem],
            onPush: (materialIndex) =>
                _push(context, materialIndex: materialIndex),
          ),
          TabNavigatorRoutes.detail: (context) => ColorDetailPage(
            color: activeTabColor[tabItem],
            title: tabName[tabItem],
            materialIndex: materialIndex,
          ),
        };
        break;
      case 3:
        return {
          TabNavigatorRoutes.root: (context) => PaymentActivity(
            // color: activeTabColor[tabItem],
            // title: tabName[tabItem],
            // onPush: (materialIndex) =>
            //     _push(context, materialIndex: materialIndex),
          ),
          // TabNavigatorRoutes.detail: (context) => ColorDetailPage(
          //   color: activeTabColor[tabItem],
          //   title: tabName[tabItem],
          //   materialIndex: materialIndex,
          // ),
        };
        break;
      case 4:
        return {
          TabNavigatorRoutes.root: (context) => AccountPage(
            // color: activeTabColor[tabItem],
            // title: tabName[tabItem],
            // onPush: (materialIndex) =>
            //     _push(context, materialIndex: materialIndex),
          ),
          // TabNavigatorRoutes.detail: (context) => ColorDetailPage(
          //   color: activeTabColor[tabItem],
          //   title: tabName[tabItem],
          //   materialIndex: materialIndex,
          // ),
        };
        break;
      default:
        return {
          TabNavigatorRoutes.root: (context) => ColorsListPage(
            color: activeTabColor[tabItem],
            title: tabName[tabItem],
            onPush: (materialIndex) =>
                _push(context, materialIndex: materialIndex),
          ),
          // TabNavigatorRoutes.detail: (context) => ColorDetailPage(
          //   color: activeTabColor[tabItem],
          //   title: tabName[tabItem],
          //   materialIndex: materialIndex,
          // ),
        };
        break;
    }

  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        print("route name " + routeSettings.name);

        return MaterialPageRoute(
          builder: (context) => routeBuilders[routeSettings.name](context),
        );
      },
    );
  }
}
