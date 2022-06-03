import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/utilities/colors.dart';
import 'package:instagram_clone/widgets/text_field.dart';

import '../utilities/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding:const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child:Container(), flex: 2, ),
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: Colors.white,
                height:64
              ),
             const SizedBox(height:24),
              TextFieldInput(
                  textEditingController:_emailcontroller,
                  hintText: 'Enter your email',
                  textInputType: TextInputType.emailAddress),
             const SizedBox(height: 24,),
              TextFieldInput(
                textEditingController: _passwordcontroller,
                hintText: 'Enter your password',
                textInputType: TextInputType.text,
                isPass: true,
              ),
           const SizedBox(height: 24,),
            InkWell(
              onTap: (){},
              child: Container(
                child:const Text('Log in'),
                alignment: Alignment.center,
                width: double.infinity,
                padding:const EdgeInsets.symmetric(vertical:12 ),
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)))
                ),
              ),
            ),
              const SizedBox(height:12),
              Flexible(child: Container(),flex: 2,),
              Row(
               children:  [
                 Container(
                   child:const Text("don't have an account?"),
                   padding:const EdgeInsets.symmetric(vertical: 8),
                 ),
                 Container(
                   child:const Text('sign up',
                   style: TextStyle(
                       fontWeight: FontWeight.bold
                   ),),
                   padding: const EdgeInsets.symmetric(vertical: 8),)

               ],

              )
            ],
          ),
        )
      )
    );
  }
}
