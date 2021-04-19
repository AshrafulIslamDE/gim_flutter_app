
 import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

  Widget getLeftSideShape(){
    return Positioned.fill(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          height: 15,
          width: 8,
          decoration:  BoxDecoration(
              color: HexColor("f4f4f4"),
              border: Border.all(color: HexColor("C9CDD0"),width: 1),
              borderRadius:  BorderRadius.only(
                topRight: const Radius.circular(15.0),
                  bottomRight: const Radius.circular(15.0),
                  )),
        ),
      ),
    );
  }

 Widget getRightSideShape(){
    final borderColor=HexColor("C9CDD0");
   return Positioned.fill(
     child: Align(
       alignment: Alignment.centerRight,
       child: Stack(
         children: <Widget>[
         //  Align(alignment:Alignment.centerRight,child: Container(color: Colors.red,width: 2,height: 15,)),

           Container(
             height: 15,
             width: 8,
             decoration:  BoxDecoration(
                  color: HexColor("f4f4f4"),

                 border: Border.all(color:borderColor ,width: 1),
                 borderRadius:  BorderRadius.only(
                   topLeft: const Radius.circular(15.0),
                   bottomLeft: const Radius.circular(15.0),

                 )),
           ),

         ],
       ),
     ),
   );
 }