import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petify/authentication/wrapper.dart';
class Verify extends StatefulWidget {
  const Verify({super.key});

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  @override
  void initState(){
    sendverifylink();
    super.initState();

  }
  sendverifylink()async{
    final user =FirebaseAuth.instance.currentUser;
    await user!.sendEmailVerification().then((value)=>{
      Get.snackbar('Link sent','A link has been sent to your email',margin: EdgeInsets.all(30),snackPosition: SnackPosition.BOTTOM)
    });
  }
  reload()async{
    await FirebaseAuth.instance.currentUser!.reload().then((value) => {Get.offAll(Wrapper())});
  }
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("Petify"),
    ),
    body: Padding(

      padding: const EdgeInsets.all(28.0),

      child: Center(
        child: Text('open your email and ckick on the link provided to verify email and reload this page'),
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: (()=>reload()),
      child: Icon(Icons.restart_alt_rounded),
    ),


  );
}
