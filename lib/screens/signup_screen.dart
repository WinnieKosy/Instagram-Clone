import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/auth_method.dart';
import 'package:instagram_clone/utilities/colors.dart';
import 'package:instagram_clone/utilities/utils.dart';
import 'package:instagram_clone/widgets/text_field.dart';

import '../responses/mobile_screen_layout.dart';
import '../responses/responsive_layout.dart';
import '../responses/web_screen_layout.dart';
import 'login_screen.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _usernamecontroller = TextEditingController();
  final TextEditingController _biocontroller = TextEditingController();
  Uint8List? _image;
  bool _isloading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _usernamecontroller.dispose();
    _biocontroller.dispose();
  }
  void selectImage()async{
   Uint8List image = await pickImage(ImageSource.gallery);
   setState(() {
      _image = image;
   });
  }
  void signUpUser()async{
    setState(() {
      _isloading = true;
    });
   String res = await AuthMethod().signupUser(
       email: _emailcontroller.text,
       password: _passwordcontroller.text,
       username: _usernamecontroller.text,
       bio: _biocontroller.text,
       file: _image!);

    setState(() {
      _isloading = false;
    });

   if(res != 'success'){
     showSnackBar(res, context);
   }else{
     Navigator.of(context).pushReplacement(MaterialPageRoute(
         builder: (context) => const ResponsiveLayout(mobileScreenLayout:MobileScreen(),
           webScreenLayout:WebScreen() ,)
     ));
   }
  }
  void navigateToLogin() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const LoginScreen()
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            padding:const EdgeInsets.symmetric(horizontal: 32),
         child: SingleChildScrollView(
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                    'assets/ic_instagram.svg',
                    color: primaryColor,
                    height:64
                ),
                SizedBox(height: 35,),
                Stack(
                  children: [
                    _image!=null?CircleAvatar(
                      radius: 64,
                      backgroundImage: MemoryImage(_image!),
                    ):CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      radius: 64,
                      backgroundImage: NetworkImage('https://www.google.com/url?sa=i&url=https%3A%2F%2Fpicsart.com%2Fi%2F318381621277201&psig=AOvVaw01j1R2rOPMZJFRiY98reDy&ust=1654336795089000&source=images&cd=vfe&ved=0CAwQjRxqFwoTCJiWkN6DkfgCFQAAAAAdAAAAABAD'),
                    ),
                    Positioned(
                     bottom: -10,
                      left: 80,
                      child: IconButton(onPressed: selectImage,
                      icon: const Icon(
                        Icons.add_a_photo
                      ),),
                    )
                  ],
                ),
                const SizedBox(height: 24,),
                TextFieldInput(
                  textEditingController:_usernamecontroller,
                  hintText: 'Enter your username',
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 24,),
                TextFieldInput(
                  textEditingController:_emailcontroller,
                  hintText: 'Enter your email',
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 24,),
                TextFieldInput(
                  textEditingController:_passwordcontroller,
                  hintText: 'Enter your password',
                  textInputType: TextInputType.text,
                  isPass: true,
                ),
                const SizedBox(height: 24,),
                TextFieldInput(
                  textEditingController:_biocontroller,
                  hintText: 'Enter your bio',
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 24,),
                InkWell(
                  onTap: signUpUser,
                  child: Container(
                    child: _isloading? const Center(child: CircularProgressIndicator(
                      color: primaryColor,),)
                        :const Text('Sign up'),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    width: double.infinity,
                    decoration:const ShapeDecoration(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4),)
                    ),
                  )
                  ),
                ),
                const SizedBox(height: 20,),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Container(
                      child:const Text("Already have an account?"),
                      padding:const EdgeInsets.symmetric(vertical: 8),
                    ),
                    Container(
                      child:GestureDetector(
                        onTap: navigateToLogin,
                        child: const Text('Login',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,

                          ),),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),)

                  ],

                )
        ], ),
         ),
      ),
    ));
  }
}
