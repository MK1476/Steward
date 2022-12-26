import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'canteen_home.dart';

class completedOrders extends StatefulWidget {
  const completedOrders({Key? key}) : super(key: key);

  @override
  State<completedOrders> createState() => _completedOrdersState();
}

class _completedOrdersState extends State<completedOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Completed Orders",
                style:
                TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400)),
            centerTitle: true,
            elevation: 0,
            flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xff7732B1), Color(0xffC38DDB)])))),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection('Canteen').doc('orders').collection('completedOrders').snapshots(),
          builder: (_, snapshot) {
            if (snapshot.hasError) return Text('Error = ${snapshot.error}');

            if (snapshot.hasData) {
              final docs = snapshot.data!.docs;
              return ListView.builder(
                itemCount: docs.length,
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                itemBuilder: (_, i) {
                  final data = docs[i].data();
                  return Padding(
                    padding: EdgeInsets.fromLTRB(1.w, 1.w, 1.w, 0),
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
                                        Text(data['Person'].toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w500)),
                                        Text(data['FoodItems'].toString(),
                                            style: TextStyle(
                                                color: Colors.grey[500], fontSize: 12.sp)),
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
                              return AlertDialog

                                (
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
                                  child: Column(
                                    children: [
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
                                            ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: data['FoodItems'].length,
                                                itemBuilder: (context,i){

                                                  return Text(data['FoodItems'][i],textAlign: TextAlign.center,);
                                                }),




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
                                            SizedBox(child: Text(data['Total'].toString()),)
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                    ),
                  );
                },
              );
            }

            return Center(child: CircularProgressIndicator());
          },
        )
    );
  }
}
