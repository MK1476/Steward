import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sizer/sizer.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
bool isadding = false;

class AddItems extends StatefulWidget {
  AddItems({Key? key}) : super(key: key);

  @override
  State<AddItems> createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
          appBar: AppBar(
              title: Text("ADD ITEMS",
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
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                setState(() {
                  isadding = true;
                });
              },
              tooltip: 'Add new items here',
              child: Center(child: Text("ADD")),
              backgroundColor: Color(0xff581A9E)),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isadding
                  ? getCard()
                  : Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 25.w, vertical: 25.h),
                      child:
                          Center(child: Image.asset("assets/images/hot.png")),
                    )
            ],
          ));
    });
  }
}

class getCard extends StatefulWidget {
  getCard({Key? key}) : super(key: key);

  @override
  State<getCard> createState() => _getCardState();
}

class _getCardState extends State<getCard> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController name = TextEditingController();
  final TextEditingController cost = TextEditingController();
  final TextEditingController qty = TextEditingController();
  final TextEditingController type = TextEditingController();
  final TextEditingController img = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
        child: Container(
            height: 82.w,
            width: 90.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.w),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Color(0XFFB1B1B1).withOpacity(0.40),
                    spreadRadius: 0,
                    blurRadius: 22,
                    offset: Offset(0, 1.0)),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(5.w, 5.w, 5.w, 2.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Name      :"),
                      Container(
                        width: 55.w,
                        height: 10.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Color(0xffefefef)),
                        child: TextFormField(
                          controller: name,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "   ",
                            labelStyle:
                                TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Cost        :"),
                      Container(
                        width: 55.w,
                        height: 10.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Color(0xffefefef)),
                        child: TextFormField(
                          controller: cost,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "   ",
                            labelStyle:
                                TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Quantity  :"),
                      Container(
                        width: 55.w,
                        height: 10.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Color(0xffefefef)),
                        child: TextFormField(
                          controller: qty,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "   ",
                            labelStyle:
                                TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Type        :"),
                      Container(
                        width: 55.w,
                        height: 10.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Color(0xffefefef)),
                        child: TextFormField(
                          controller: type,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "   ",
                            labelStyle:
                                TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Image link  :"),
                      Container(
                        width: 55.w,
                        height: 10.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Color(0xffefefef)),
                        child: TextFormField(
                          controller: img,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "   ",
                            labelStyle:
                                TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              name.text = "";
                              cost.text = "";
                              qty.text = "";
                              type.text = "";
                              img.text = "";
                            });
                          },
                          child: Text("CLEAR",
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400))),
                      ButtonTheme(
                          minWidth: 30.w,
                          height: 8.w,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.w)),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                name.text = "";
                                cost.text = "";
                                qty.text = "";
                                type.text = "";
                                img.text = "";
                              });
                              isadding = false;
                              Navigator.pop(context);
                            },
                            child: Text("CANCEL",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400)),
                          )),
                      ButtonTheme(
                          minWidth: 30.w,
                          height: 8.w,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.w)),
                          child: ElevatedButton(
                            onPressed: () async {
                              await _firestore
                                  .collection("Canteen")
                                  .doc("items")
                                  .collection("itemDetails")
                                  .doc(name.text)
                                  .set(
                                {
                                  "foodName": name.text,
                                  "foodCost": cost.text,
                                  "quantity": qty.text,
                                  "foodType": type.text,
                                  "foodImage": img.text,
                                },
                              );
                              setState(() {
                                isadding = false;
                                name.text = "";
                                cost.text = "";
                                qty.text = "";
                                type.text = "";
                                img.text = "";
                              });

                              Navigator.pop(context);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("New item added",
                                    style: TextStyle(color: Colors.white)),
                                backgroundColor: Color(0xff581A9E),
                              ));
                            },
                            child: Text("ADD",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400)),
                          )),
                    ],
                  ),
                ],
              ),
            )),
      );
    });
  }
}
