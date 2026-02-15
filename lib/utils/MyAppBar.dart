import 'package:cliniccxc/constant/colorpalet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAppBar extends AppBar {
   MyAppBar({super.key});

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return  AppBar(
          
        elevation: 0,

        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.notifications_active_outlined ,color: Colors.white,size: 20,)),
          IconButton(onPressed: (){}, icon: Icon(Icons.mail_outline_rounded ,color: Colors.white,size: 20,)),
        ],
        
        centerTitle: false,
        backgroundColor: Mycolors.green,
        leading:           Container(margin: EdgeInsets.all(10),padding: EdgeInsets.all(4), decoration: BoxDecoration(color: const Color.fromARGB(189, 255, 255, 255), borderRadius: BorderRadius.all(Radius.circular(50))),child: Icon(Icons.person,color: const Color.fromARGB(133, 0, 0, 0),size: 20,),)

      );
  }
}