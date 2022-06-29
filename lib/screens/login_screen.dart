import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/resources/auth_method.dart';
import 'package:instagram_clone/screens/signup_screen.dart';
import 'package:instagram_clone/utilities/colors.dart';
import 'package:instagram_clone/utilities/utils.dart';
import 'package:instagram_clone/widgets/text_field.dart';

import '../responses/mobile_screen_layout.dart';
import '../responses/responsive_layout.dart';
import '../responses/web_screen_layout.dart';
import '../utilities/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  bool _isloading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }
  void loginUser()async{
    setState(() {
      _isloading = true;
    });
    String res = await AuthMethod().loginUser(
        email: _emailcontroller.text,
        password: _passwordcontroller.text);
    if(res=='success'){
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(mobileScreenLayout:MobileScreen(),
            webScreenLayout:WebScreen() ,)
      ));
    }
    else{
      showSnackBar(res, context);
    }
    setState(() {
      _isloading = false;
    });
  }
  void navigateToSignup(){
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context)=> const SignupScreen()
    ));
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
                color: primaryColor,
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
              onTap: loginUser,
              child: Container(
                child:_isloading? const Center(child:CircularProgressIndicator(
                  color: primaryColor,
                ))
                  :const Text('Log in'),
                alignment: Alignment.center,
                width: double.infinity,
                padding:const EdgeInsets.symmetric(vertical:12 ),
                decoration: const ShapeDecoration(
                  color: blueColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)))
                ),
              ),
            ),
              const SizedBox(height:12),
              Flexible(child: Container(),flex: 2,),
              Row(mainAxisAlignment: MainAxisAlignment.center,
               children:  [
                 Container(
                   child:const Text("Don't have an account?"),
                   padding:const EdgeInsets.symmetric(vertical: 8),
                 ),
                 Container(
                   child:GestureDetector(
                     onTap: navigateToSignup,
                     child: const Text('Sign up',
                     style: TextStyle(
                         fontWeight: FontWeight.bold,

                     ),),
                   ),
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
