import 'package:flutter/material.dart';

enum TabItem { home, stock, cart,payment,account }

const Map<TabItem, String> tabName = {
  TabItem.home: 'ទំព័រដើម',
  TabItem.stock: 'ស្តុក',
  TabItem.cart: 'ផលិតផល',
  TabItem.payment:'បង់ប្រាក់',
  TabItem.account:'គណនី',
};

const Map<TabItem, MaterialColor> activeTabColor = {
  TabItem.home: Colors.red,
  TabItem.stock: Colors.red,
  TabItem.cart: Colors.red,
  TabItem.payment:Colors.red,
  TabItem.account:Colors.red,
};
