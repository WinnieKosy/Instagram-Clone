import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/auth_method.dart';

class Feed extends StatelessWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: IconButton(onPressed:() {
        AuthMethod().getUserDetails();
      },
      icon: Icon(Icons.home),)),
    );
  }
}
