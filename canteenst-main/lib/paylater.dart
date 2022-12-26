
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sizer/sizer.dart';

import 'homepage.dart';

int orderNumber=0;
int finalTotal = 0;
List<int>? count;

List<int>? oc = [];

List<String>? orderNames = [];

List<String>? orderCost = [];
class PayLater extends StatefulWidget {
  final int ordernumber;
  PayLater({Key? key,required this.ordernumber}) : super(key: key);


  @override
  State<PayLater> createState() => _PayLaterState();


}

class _PayLaterState extends State<PayLater> {

  getData() async {
    DocumentSnapshot productCollection = await FirebaseFirestore.instance
        .collection('Canteen')
        .doc("orders")
        .collection("OrderDetails").doc(widget.ordernumber.toString())
        .get();


  }

  void initState(){
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        body: Container(
            width: 100.w,
            height: 100.h,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 25.w),
                Stack(
                  children: [
                    SpinKitPulse(
                      color: Color.fromARGB(255, 100, 29, 215),
                      size: 60.w,
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        children: [
                          QrImage(data: widget.ordernumber.toString(),size: 100,),//sha256.convert(utf8.encode(i.toString())).toString()
                          Text('Order is getting ready!!'),
                          Image.asset("assets/images/cooking.png"),
                        ],
                      ),
                    )
                  ],
                ),
                Expanded(
                    child: Text(
                        "Your order has been recorded. Please receive your order at the canteen",
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 14.sp, color: Colors.black))),
                Padding(
                  padding: EdgeInsets.fromLTRB(40.w, 0, 40.w, 30.w),
                  child: ButtonTheme(
                    minWidth: 20.w,
                    height: 10.w,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.w)),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  alignment:
                                  Alignment.centerRight,
                                  type:
                                  PageTransitionType.scale,
                                  child: CanteenHome()));

                        },
                       // color: Color.fromARGB(255, 108, 29, 205),
                        child: Text("Done",
                            style: TextStyle(
                                color: Colors.white, fontSize: 11.sp))),
                  ),
                )
              ],
            )),
      );
    });
  }
}
