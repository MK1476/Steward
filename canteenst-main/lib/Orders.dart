//import 'package:canteenst/style/theme.dart';


import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
//import 'package:encrypt/encrypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sizer/sizer.dart';

import 'encrypt.dart';
import 'homepage.dart';




final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;
class recentOrders extends StatefulWidget {
  const recentOrders({Key? key}) : super(key: key);

  @override
  State<recentOrders> createState() => _recentOrdersState();
}

class _recentOrdersState extends State<recentOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : true,
      body: Column(
        children: [
          SizedBox(height: 30,),
          Text('Recent Orders',style: TextStyle(fontSize: 25),),
          SizedBox(height: 20,),
          Flexible(
            child: SingleChildScrollView(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance.collection('Student').doc(_auth.currentUser!.uid).collection('recentOrders').snapshots(),
                builder: (_, snapshot) {
                  if (snapshot.hasError) return Text('Error = ${snapshot.error}');

                  if (snapshot.hasData) {
                    final docs = snapshot.data!.docs;
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: docs.length,
                      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                      itemBuilder: (_, i) {
                        final data = docs[docs.length-1-i].data();
                        return Padding(
                          padding: EdgeInsets.fromLTRB(5.w, 5.w, 5.w, 0),
                          child: InkWell(
                            child: Container(
                                width: 92.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(3.w),
                                  boxShadow: [
                                    BoxShadow(
                                        color: const Color(0XFFA8B4C5).withOpacity(0.30),
                                        spreadRadius: 0,
                                        blurRadius: 14,
                                        offset: const Offset(0, 6.0)),
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(2.w),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      SizedBox(
                                        width: 50.w,
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(data['FoodItems'].toString(),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13.sp,
                                                      fontWeight: FontWeight.w500)),
                                             func(data),
                                            ]),
                                      ),

                                      Container(
                                        height: 13.w,
                                        width: 13.w,
                                        child: Center(child: Text(data['Total'].toString()+"/-")),
                                        decoration: BoxDecoration(
                                            color: Color(0xffB3F4C0), //: Color(0xffF1B1BC),
                                            borderRadius: BorderRadius.circular(2.w)),
                                      )
                                    ],
                                  ),
                                )
                            ),
                            onTap:   ()  {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                            20.0,
                                          ),
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.only(
                                        top: 10.0,
                                      ),
                                      title: Text(
                                        "Order",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 24.0),
                                      ),
                                      content: Container(
                                        height: 400,
                                        child: SingleChildScrollView(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,//func2(data,docs.length+1+i)
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),

                                                child : StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                                    stream: FirebaseFirestore.instance.collection('Student').doc(_auth.currentUser!.uid).collection('recentOrders').snapshots(),
                                                    builder: (BuildContext context, snapshot2){
                                                      if(snapshot2.hasData) {
                                                        return func2(snapshot2.data!.docs[docs.length-1-i].data(),docs.length+1+i);//snapshot.data!.docs[docs.length-1-i].data()
                                                      }

                                                      return Container(child: CircularProgressIndicator());
                                                    }
                                                ),

                                              ),
                                              SingleChildScrollView(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: <Widget>[
                                                    SizedBox(height: 10,),
                                                    SizedBox(child: Text('Items - Count'),),
                                                    SizedBox(height: 10,),
                                                    const MySeparator(color: Colors.grey),
                                                    SizedBox(height: 16,),
                                                    Scrollable(
                                                      viewportBuilder: (BuildContext context, ViewportOffset position) {
                                                        return ListView.builder(
                                                          shrinkWrap: true,
                                                          itemCount: data['FoodItems'].length,
                                                          itemBuilder: (context,i){

                                                            return Text(data['FoodItems'][i],textAlign: TextAlign.center,);
                                                          }); },

                                                    ),




                                                    SizedBox(height: 27,),
                                                    //const MySeparator(color: Colors.grey),

                                                    Row(
                                                      children: [
                                                        SizedBox(width: 90,),
                                                        SizedBox(width: 80,
                                                          child: const MySeparator(color: Colors.grey),),
                                                        SizedBox(width: 10,),
                                                      ],
                                                    ),
                                                    SizedBox(height: 10,),
                                                    SizedBox(child: Text("Total : "+ data['Total'].toString()+" /_"),)
                                                  ],
                                                ),
                                              ),


                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            }
                            ,
                          ),
                        );
                      },
                    );
                  }

                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
  func(data) {
    if(data['status']=='Not-Delivered'){
      return Container(
        child: Text('Your Order is getting ready!!  '),
      );

    }else if(data['status']=='Cancelled'){
      return Container(
        child: Text('Order Canceled'),
      );

    }else if(data['status']=='Delivered'){
      return Container(
        child: Text('Completed successfully'),
      );

    }else{
      return Container();
    }

  }
}
final EncryptData enc= new EncryptData();
func2(data,i) {
  if(data['status']=='Not-Delivered'){
    return Container(
      child: Column(
        children: [

          QrImage(data: data['OrderNumber'].toString(),size: 100,),
          //QrImage(data: enc.encryptAES(data['OrderNumber'].toString()),size: 100,),//sha256.convert(utf8.encode(i.toString())).toString()
          Text('Order is getting ready!!')
        ],
      ),
    );

  }else if(data['status']=='Cancelled'){
    return Container(
      child: Column(
        children: [
          Icon(Icons.cancel_outlined,color: Colors.red,size: 100,),
          Text('Your Order got Cancelled')
        ],
      )
    );

  }else if(data['status']=='Delivered'){
    return Container(
        child: Column(
          children: [
            Icon(Icons.done_outline_rounded,color: CupertinoColors.activeGreen,size: 100,),
            Text('Succesfully Completed')
          ],
        )
    );

  }else{
    return Container();
  }


}



