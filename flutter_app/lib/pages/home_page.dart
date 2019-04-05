import 'package:flutter/material.dart';

import 'package:flutter_app/utils/app_constants.dart' as app;
import 'package:flutter_app/common/backdrop.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<BackdropState> _backdropKey = GlobalKey();
  final GlobalKey<MenuState> _menuKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Backdrop(
      key: _backdropKey,
      backLayer: Menu(
          key: _menuKey,
          itemSettings: [
            MenuItemSettings(
                text: "MENU",
                type: MenuItemType.menu,
                routeName: app.routeNameMenu),
            MenuItemSettings(
                text: "ORDERS MANAGEMENT",
                type: MenuItemType.ordersManagement,
                routeName: app.routeNameOrdersManagement)
          ],
          onMenuItemSelected: _onMenuItemSelected),
    );
  }

  void _onMenuItemSelected(MenuItemSettings settings) {
    _backdropKey.currentState.toggle();
    _menuKey.currentState.setState(() {
      _menuKey.currentState.selectedMenuItemType = settings.type;
    });
  }
}

typedef OnMenuItemSelected = void Function(MenuItemSettings settings);

class Menu extends StatefulWidget {
  final List<MenuItemSettings> itemSettings;
  final OnMenuItemSelected onMenuItemSelected;

  Menu({Key key, this.itemSettings, this.onMenuItemSelected}) : super(key: key);

  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<Menu> {
  MenuItemType selectedMenuItemType;

  @override
  void initState() {
    super.initState();
    selectedMenuItemType = MenuItemType.menu;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            children:
                List<Widget>.generate(widget.itemSettings.length, (index) {
      return MenuItem(
          settings: widget.itemSettings[index],
          currentSelectedType: selectedMenuItemType,
          callback: widget.onMenuItemSelected);
    })));
  }
}

class MenuItemSettings {
  final String text;
  final MenuItemType type;
  final String routeName;

  const MenuItemSettings({this.text, this.type, this.routeName});
}

enum MenuItemType { menu, ordersManagement }

class MenuItem extends StatefulWidget {
  final MenuItemSettings settings;
  final OnMenuItemSelected callback;
  final MenuItemType currentSelectedType;

  MenuItem({Key key, this.settings, this.callback, this.currentSelectedType})
      : super(key: key);

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> with TickerProviderStateMixin {
  AnimationController animationController;

  bool get isSelected => widget.settings.type == widget.currentSelectedType;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isSelected) {
      animationController.forward();
    } else {
      animationController.reverse();
    }

    return GestureDetector(
      onTap: () {
        if (widget.callback != null) {
          widget.callback(widget.settings);
        }
      },
      child: Column(children: [
        SizedBox(height: 16.0),
        Text(widget.settings.text),
        SizedBox(height: 5.0),
        SizeTransition(
            axis: Axis.horizontal,
            sizeFactor: CurvedAnimation(
                parent: animationController, curve: Curves.easeIn),
            child: Container(width: 100.0, height: 3.0, color: Colors.white)),
      ]),
    );
  }
}
