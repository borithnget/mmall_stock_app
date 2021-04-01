import 'package:flutter/material.dart';
import 'package:markarian_sales/home/bottom_nav/tab_item.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({@required this.currentTab, @required this.onSelectTab});
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      showSelectedLabels: false,   // <-- HERE
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(TabItem.home,Icons.home_outlined),
        _buildItem(TabItem.stock,Icons.shopping_bag_outlined),
        _buildItem(TabItem.cart,Icons.inventory),
        _buildItem(TabItem.payment,Icons.payment_outlined),
        _buildItem(TabItem.account,Icons.account_circle_outlined),
      ],
      onTap: (index) => onSelectTab(
        TabItem.values[index],
      ),
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem, IconData icons) {
    return BottomNavigationBarItem(
      icon: Icon(
        //Icons.layers,
        icons,
        color: _colorTabMatching(tabItem),
      ),
      label: tabName[tabItem],
    );
  }

  Color _colorTabMatching(TabItem item) {
    return currentTab == item ? activeTabColor[item] : Colors.grey;
  }
}
