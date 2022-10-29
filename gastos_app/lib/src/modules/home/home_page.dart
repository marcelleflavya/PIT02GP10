import 'package:flutter/material.dart';
import 'package:gastos_app/src/modules/home/components/custom_app_bar.dart';
import 'package:gastos_app/src/modules/home/components/bottom_navigation_bar/custom_bottom_navigation.dart';
import 'package:gastos_app/src/modules/home/components/drawer/custom_drawer.dart';

import 'package:gastos_app/src/modules/home/components/home_body.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(
          onOpenDrawer: () {
            _scaffoldKey.currentState?.openEndDrawer();
          },
        ),
        endDrawer: const CustomDrawer(),
        body: const HomeBody(),
        bottomNavigationBar: const CustomBottomNavigationBar(),
      ),
    );
  }
}
