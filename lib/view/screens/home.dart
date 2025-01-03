import 'package:flutter/material.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/size_config.dart';
import 'package:promotion_dashboard/core/functions/size.dart';
import 'package:promotion_dashboard/view/screens/dashboard.dart';
import 'package:promotion_dashboard/view/screens/products.dart';
import 'package:promotion_dashboard/view/widgets/general/drawer/custom_dawer.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  int selectedindex = 0;
  List<Widget> screens = [
    Dashboard(),
    Products(),
    SizedBox(),
    SizedBox(),
    SizedBox(),
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.color_F7F9FA,
      appBar: MediaQuery.sizeOf(context).width <= SizeConfig.tablet
          ? AppBar(
              backgroundColor: AppColors.color_F7F9FA,
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  scaffoldKey.currentState!.openDrawer();
                },
              ),
            )
          : AppBar(
              backgroundColor: AppColors.color_F7F9FA,
              elevation: 0,
            ),
      drawer: MediaQuery.sizeOf(context).width <= SizeConfig.tablet
          ? CustomDawer(
              onIndexSelected: (index) {
                setState(() {
                  selectedindex = index;
                });
              },
            )
          : null,
      body: Row(
        children: [
          MediaQuery.sizeOf(context).width > SizeConfig.tablet
              ? Expanded(
                  child: CustomDawer(
                    onIndexSelected: (index) {
                      setState(() {
                        selectedindex = index;
                      });
                    },
                  ),
                )
              : const SizedBox(),
          Expanded(
            flex: 4,
            child: screens[selectedindex],
          ),
        ],
      ),
    );
  }
}
