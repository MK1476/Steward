import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_canteen/add_times.dart';
import 'package:college_canteen/completedOrders.dart';
import 'package:college_canteen/deleteItems.dart';
import 'package:college_canteen/ordedetails.dart';
import 'package:college_canteen/orderSum.dart';
import 'package:college_canteen/qrscanner.dart';
import 'package:college_canteen/syllabus.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'encrypt.dart';

Color color = Color(0xffd1d1d1);
bool isloaded = false;
final children = <Widget>[]; // list to store itemcards

List<List>? names = [];
List<int>? total = [];
List<String>? user = [];

List<List>? names2 =[];
List<int>? total2 = [];
List<String>? user2 = [];

List<bool>? ispaid = [];
int orderscount = 0;
int oc2 = 0;
Map<String, dynamic>? userMap;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class CanteenHome extends StatefulWidget {
  final String l;
  CanteenHome({Key? key,required this.l}) : super(key: key);


  @override
  State<CanteenHome> createState() => _CanteenHomeState();
}

class _CanteenHomeState extends State<CanteenHome> {
  final EncryptData enc= new EncryptData();

  @override
  void initState() {


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.l!=''){
      newfunc2(context, widget.l);
    };
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
          appBar: AppBar(
              title: Text("Steward's Kitchen",
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
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => AddItems()));
                      },
                      borderRadius: BorderRadius.circular(5.w),
                      child: Ink(
                          height: 20.w,
                          width: 20.w,
                          child: Center(
                            child: Text("Add items",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 11.sp)),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.w),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0XFFffffff).withOpacity(1),
                                    spreadRadius: 0,
                                    blurRadius: 7,
                                    offset: Offset(-3, -3.0)),
                                BoxShadow(
                                    color: Color(0XFFC091E7).withOpacity(0.36),
                                    spreadRadius: 0,
                                    blurRadius: 10,
                                    offset: Offset(3, 5.0)),
                              ],
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xffC38DDB),
                                    Color(0xff7732B1)
                                  ]))),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => deleteItems()));
                      },
                      borderRadius: BorderRadius.circular(5.w),
                      child: Ink(
                          height: 20.w,
                          width: 20.w,
                          child: Center(
                            child: Text("Delete items",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 11.sp)),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.w),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0XFFffffff).withOpacity(1),
                                    spreadRadius: 0,
                                    blurRadius: 7,
                                    offset: Offset(-3, -3.0)),
                                BoxShadow(
                                    color: Color(0XFFC091E7).withOpacity(0.36),
                                    spreadRadius: 0,
                                    blurRadius: 10,
                                    offset: Offset(3, 5.0)),
                              ],
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xffC38DDB),
                                    Color(0xff7732B1)
                                  ]))),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => completedOrders()));

                      },
                      borderRadius: BorderRadius.circular(5.w),
                      child: Ink(
                          height: 20.w,
                          width: 20.w,
                          child: Center(
                            child: Text("Completed Orders",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 11.sp)),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.w),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0XFFffffff).withOpacity(1),
                                    spreadRadius: 0,
                                    blurRadius: 7,
                                    offset: Offset(-3, -3.0)),
                                BoxShadow(
                                    color: Color(0XFFC091E7).withOpacity(0.36),
                                    spreadRadius: 0,
                                    blurRadius: 10,
                                    offset: Offset(3, 5.0)),
                              ],
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xffC38DDB),
                                    Color(0xff7732B1)
                                  ]))),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => orderSum()));

                      },
                      borderRadius: BorderRadius.circular(5.w),
                      child: Ink(
                          height: 20.w,
                          width: 20.w,
                          child: Center(
                            child: Text("Canclled Orders",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 11.sp)),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.w),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0XFFffffff).withOpacity(1),
                                    spreadRadius: 0,
                                    blurRadius: 7,
                                    offset: Offset(-3, -3.0)),
                                BoxShadow(
                                    color: Color(0XFFC091E7).withOpacity(0.36),
                                    spreadRadius: 0,
                                    blurRadius: 10,
                                    offset: Offset(3, 5.0)),
                              ],
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xffC38DDB),
                                    Color(0xff7732B1)
                                  ]))),
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.push(context,
                    //         MaterialPageRoute(builder: (_) => Syllabus()));
                    //   },
                    //   borderRadius: BorderRadius.circular(5.w),
                    //   child: Ink(
                    //       height: 20.w,
                    //       width: 20.w,
                    //       child: Center(
                    //         child: Text("Add items",
                    //             style: TextStyle(
                    //                 color: Colors.white, fontSize: 11.sp)),
                    //       ),
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(5.w),
                    //           boxShadow: [
                    //             BoxShadow(
                    //                 color: Color(0XFFffffff).withOpacity(1),
                    //                 spreadRadius: 0,
                    //                 blurRadius: 7,
                    //                 offset: Offset(-3, -3.0)),
                    //             BoxShadow(
                    //                 color: Color(0XFFC091E7).withOpacity(0.36),
                    //                 spreadRadius: 0,
                    //                 blurRadius: 10,
                    //                 offset: Offset(3, 5.0)),
                    //           ],
                    //           gradient: LinearGradient(
                    //               begin: Alignment.topCenter,
                    //               end: Alignment.bottomCenter,
                    //               colors: [
                    //                 Color(0xffC38DDB),
                    //                 Color(0xff7732B1)
                    //               ]))),
                    // ),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(6.w, 3.w, 60.w, 3.w),
                    child: Text("ORDERS",
                        style: TextStyle(
                            color: Colors.indigo[800], fontSize: 14.sp)),
                  ),
                  IconButton(
                    onPressed: () async {


                      CanteenHome(l: '',);
                    },
                    icon: Icon(Icons.refresh_rounded, size: 7.w),
                  )
                ],
              ),
              Container(
                height: 60.h,
                width: 90.w,
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance.collection('Canteen').doc('orders').collection('orderDetails').snapshots(),
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
                                        Column(children: [
                                          TextButton(
                                              onPressed: () async {
                                                await _firestore
                                                    .collection('Canteen')
                                                    .doc("orders")
                                                    .collection('orderDetails')
                                                    .doc(docs[i].id)
                                                    .delete();

                                                await _firestore
                                                    .collection('Canteen')
                                                    .doc("orders")
                                                    .collection('orderSummary')
                                                    .doc(docs[i].id)
                                                    .set(
                                                  {
                                                    'status':'canceledOrders'
                                                  }
                                                );

                                                await _firestore
                                                    .collection('Student')
                                                    .doc(data['personid'])
                                                    .collection('recentOrders')
                                                    .doc(docs[i].id)
                                                    .set(
                                                    {
                                                      "Person": data['Person'].toString(),
                                                      "FoodItems": data['FoodItems'],
                                                      "Total": data['Total'].toString(),
                                                      "isPaid": false,
                                                      "status": "Cancelled"
                                                    },);

                                                await _firestore
                                                    .collection("Canteen")
                                                    .doc("orders")
                                                    .collection("canceledOrders")
                                                    .doc(docs[i].id)
                                                    .set(
                                                  {
                                                    "Person": data['Person'].toString(),
                                                    "FoodItems": data['FoodItems'],
                                                    "Total": data['Total'].toString(),
                                                    "isPaid": false,
                                                    "status": "Cancelled"
                                                  },
                                                );

                                                // await _firestore
                                                //     .collection('Canteen')
                                                //     .doc("TotalOrders")
                                                //     .update(
                                                //   {"count": orderscount - 1},
                                                // );

                                                Future.delayed(
                                                    const Duration(milliseconds: 500), () {});

                                              },
                                              child: Text("Cancel",
                                                  style:
                                                  TextStyle(color: Colors.red, fontSize: 10.sp))),
                                          TextButton(
                                              onPressed: () async {
                                                await _firestore
                                                    .collection('Canteen')
                                                    .doc("orders")
                                                    .collection('orderDetails')
                                                    .doc(docs[i].id)
                                                    .delete();

                                                await _firestore
                                                    .collection('Student')
                                                    .doc(data['personid'])
                                                    .collection('recentOrders')
                                                    .doc(docs[i].id)
                                                    .set(
                                                  {
                                                    "Person": data['Person'].toString(),
                                                    "FoodItems": data['FoodItems'],
                                                    "Total": data['Total'].toString(),
                                                    "isPaid": true,
                                                    "status": "Delivered"
                                                  },);

                                                await _firestore
                                                    .collection("Canteen")
                                                    .doc("orders")
                                                    .collection("completedOrders")
                                                    .doc(docs[i].id)
                                                    .set(
                                                  {
                                                    "Person": data['Person'].toString(),
                                                    "FoodItems": data['FoodItems'],
                                                    "Total": data['Total'].toString(),
                                                    "isPaid": true,
                                                    "status": "Delivered"
                                                  },
                                                );

                                                // await _firestore
                                                //     .collection('Canteen')
                                                //     .doc("TotalOrders")
                                                //     .update(
                                                //   {"count": orderscount - 1,"count2" : oc2+1 },
                                                // );

                                                Future.delayed(
                                                    const Duration(milliseconds: 500), () {});

                                              },
                                              child: Text("Done",
                                                  style: TextStyle(
                                                      color: Colors.green, fontSize: 10.sp))),
                                        ]),
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
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 0.0),
                                                child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                  TextButton(
                                                      onPressed: () async {
                                                        await _firestore
                                                            .collection('Canteen')
                                                            .doc("orders")
                                                            .collection('orderDetails')
                                                            .doc(docs[i].id)
                                                            .delete();

                                                        await _firestore
                                                            .collection('Canteen')
                                                            .doc("orders")
                                                            .collection('orderSummary')
                                                            .doc(docs[i].id)
                                                            .set(
                                                            {
                                                              'status':'canceledOrders'
                                                            }
                                                        );

                                                        await _firestore
                                                            .collection('Student')
                                                            .doc(data['personid'])
                                                            .collection('recentOrders')
                                                            .doc(docs[i].id)
                                                            .set(
                                                          {
                                                            "Person": data['Person'].toString(),
                                                            "FoodItems": data['FoodItems'],
                                                            "Total": data['Total'].toString(),
                                                            "isPaid": false,
                                                            "status": "Cancelled"
                                                          },);

                                                        await _firestore
                                                            .collection("Canteen")
                                                            .doc("orders")
                                                            .collection("canceledOrders")
                                                            .doc(docs[i].id)
                                                            .set(
                                                          {
                                                            "Person": data['Person'].toString(),
                                                            "FoodItems": data['FoodItems'],
                                                            "Total": data['Total'].toString(),
                                                            "isPaid": false,
                                                            "status": "Cancelled"
                                                          },
                                                        );

                                                        // await _firestore
                                                        //     .collection('Canteen')
                                                        //     .doc("TotalOrders")
                                                        //     .update(
                                                        //   {"count": orderscount - 1},
                                                        // );

                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (_) => CanteenHome(l: '',)));
                                                        Future.delayed(
                                                            const Duration(milliseconds: 500), () {});


                                                      },
                                                      child: Text("Cancel",
                                                          style:
                                                          TextStyle(color: Colors.red, fontSize: 20.sp))),
                                                  SizedBox(width: 30,),
                                                  TextButton(
                                                      onPressed: () async {
                                                        await _firestore
                                                            .collection('Canteen')
                                                            .doc("orders")
                                                            .collection('orderDetails')
                                                            .doc(docs[i].id)
                                                            .delete();

                                                        await _firestore
                                                            .collection('Student')
                                                            .doc(data['personid'])
                                                            .collection('recentOrders')
                                                            .doc(docs[i].id)
                                                            .set(
                                                          {
                                                            "Person": data['Person'].toString(),
                                                            "FoodItems": data['FoodItems'],
                                                            "Total": data['Total'].toString(),
                                                            "isPaid": true,
                                                            "status": "Delivered"
                                                          },);

                                                        await _firestore
                                                            .collection("Canteen")
                                                            .doc("orders")
                                                            .collection("completedOrders")
                                                            .doc(docs[i].id)
                                                            .set(
                                                          {
                                                            "Person": data['Person'].toString(),
                                                            "FoodItems": data['FoodItems'],
                                                            "Total": data['Total'].toString(),
                                                            "isPaid": true,
                                                            "status": "Delivered"
                                                          },
                                                        );

                                                        // await _firestore
                                                        //     .collection('Canteen')
                                                        //     .doc("TotalOrders")
                                                        //     .update(
                                                        //   {"count": orderscount - 1,"count2" : oc2+1 },
                                                        // );

                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (_) => CanteenHome(l: '',)));
                                                        Future.delayed(
                                                            const Duration(milliseconds: 500), () {});


                                                      },
                                                      child: Text("Done",
                                                          style: TextStyle(
                                                              color: Colors.green, fontSize: 20.sp))),
                                                ]),
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
              )
            ],
          ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          // isExtended: true,
          child: Icon(Icons.qr_code_scanner_outlined),
          backgroundColor: const Color(0xffC38DDB),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => QRViewExample()));
          },
        ),

      );
    }


    );
  }
}


class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.height = 1, this.color = Colors.black})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}


//isloaded ?
//                     ListView(
//                     physics: const BouncingScrollPhysics(
//                         parent: AlwaysScrollableScrollPhysics()),
//                     scrollDirection: Axis.vertical,
//                     children: [isloaded ? listoforderscard(): CircularProgressIndicator(color: Colors.white,),])
//                     : Row(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: const [
//                        CircularProgressIndicator(color: Colors.white,),
//
//                     ],),