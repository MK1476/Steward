import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'canteen_home.dart';
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
class orderDet extends StatefulWidget {
  final String i;
  const orderDet({Key? key, required this.i}) : super(key: key);

  @override
  State<orderDet> createState() => _orderDetState();
}

class _orderDetState extends State<orderDet> {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: newfunc2(context, widget.i),
    );
  }
}


newfunc2(context,i) async {
  await _firestore
      .collection('Canteen')
      .doc('orders')
      .collection('orderDetails')
      .doc(i)
      .get()
      .then((data) {

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
                                    .doc(i)
                                    .delete();

                                await _firestore
                                    .collection('Canteen')
                                    .doc("orders")
                                    .collection('orderSummary')
                                    .doc(i)
                                    .set(
                                    {
                                      'status':'canceledOrders'
                                    }
                                );

                                await _firestore
                                    .collection('Student')
                                    .doc(data['personid'])
                                    .collection('recentOrders')
                                    .doc(i)
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
                                    .doc(i)
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


                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => CanteenHome(l: '',)));
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
                                    .doc(i)
                                    .delete();

                                await _firestore
                                    .collection('Student')
                                    .doc(data['personid'])
                                    .collection('recentOrders')
                                    .doc(i)
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
                                    .doc(i)
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


                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => CanteenHome(l: '',)));

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
  });

}