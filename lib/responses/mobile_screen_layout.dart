import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utilities/colors.dart';
import 'package:instagram_clone/utilities/global_variables.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';


class MobileScreen extends StatefulWidget {
  const MobileScreen({Key? key}) : super(key: key);

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {

  int _page = 0;
  late PageController pageController;

  void navigationTapped(int page){
    pageController.jumpToPage(page);
  }
  @override
  void initState() {
    super.initState();
    pageController = PageController();

  }
  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
  void onPageChanged(int page){
    setState(() {
      _page = page;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:PageView(
        children: HomeScreen,
        onPageChanged:onPageChanged ,
        physics:const NeverScrollableScrollPhysics(),
        controller: pageController,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home, color: _page==0? primaryColor: secondaryColor,),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(icon: Icon(Icons.search,color: _page==1? primaryColor: secondaryColor,),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle,color: _page==2? primaryColor: secondaryColor,),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(icon: Icon(Icons.favorite,color: _page==3? primaryColor: secondaryColor,),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(icon: Icon(Icons.person,color: _page==4? primaryColor: secondaryColor,),
              label: '',
              backgroundColor: primaryColor),
        ],
        onTap:navigationTapped,
      )
    );
  }
}
