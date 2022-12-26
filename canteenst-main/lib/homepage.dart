import 'package:another_flushbar/flushbar.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

import 'package:canteenst/paylater.dart';
import 'package:canteenst/settings_ui.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:swipebuttonflutter/swipebuttonflutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Authentication_section/Authentication_methods.dart';
import 'Orders.dart';
import 'nlogin.dart';

int totalorders = 0;
int perc = 0;
String cuser = "";
String cemail = "";

String croll = "";
Map<String, dynamic>? Udata;
int indicator = 0;
int omniv = 0;
int totalcount = 0;
int finalTotal = 0;
List<int>? count;

List<int>? oc = [];

List<String>? orderNames = [];

List<String>? orderCost = [];

int _selectedIndex = 0;
late PageController _pageController;
bool isLoaded = false;
bool isLoading = false;
bool isadding = false;

final children = <Widget>[]; // list to store itemcards
final orderchildren = <Widget>[];
List<String>? names = []; // list to store names of items from firebase
List<String>? cost = []; // list to store cost of items from firebase
List<String>? images = [];
int itemscount = 0; // count of all items in firebase

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

List<Map<String, dynamic>?>? list = []; // list containing maps of items
Map<String, dynamic>? userMap;
Map<String, int>? ordercount;
List<String>? orderCount = [];



class CanteenHome extends StatefulWidget {
   CanteenHome({Key? key}) : super(key: key);

  List navigationTitles = ['Home','Cart','Orders'];


  List navigationIcons = [
    Icon(Icons.home_outlined),
    Icon(Icons.receipt_long),
    Icon(Icons.refresh_sharp),
    ];



  @override
  State<CanteenHome> createState() => _CanteenHomeState();
}

// ===================== Get items count ========================

class _CanteenHomeState extends State<CanteenHome> with TickerProviderStateMixin {



  AnimationController? animationController;

  getUserData() async {
    DocumentSnapshot variab = await FirebaseFirestore.instance
        .collection("Students")
        .doc(_auth.currentUser!.uid)
        .get();
    setState(() {
      cuser = variab["name"];
      cemail = variab["email"];

      croll = variab["roll"];
      //Udata = variab as Map<String, dynamic>?;
    });
  }

  getTotalOrders() async {
    DocumentSnapshot variable = await FirebaseFirestore.instance
        .collection("Canteen")
        .doc("TotalOrders")
        .get();
    setState(() {
      totalorders = variable["count"];
    });
  }

  getCount() async {
    QuerySnapshot productCollection = await FirebaseFirestore.instance
        .collection('Canteen')
        .doc("items")
        .collection("itemDetails")
        .get();

    itemscount = productCollection.size;
  }

// ======================= Get items in lists, names and cost============

  getItems() async {
    await _firestore
        .collection('Canteen')
        .doc('items')
        .collection('itemDetails')
        .get()
        .then((value) {
      setState(() {
        for (int i = 0; i < itemscount; i++) {
          userMap = value.docs[i].data();
          names?.add(userMap!["foodName"]);
          cost?.add(userMap!["foodCost"]);
          images?.add(userMap!["foodImage"]);

          list?.add(value.docs[i].data());
        }
      });
    });
  }

// ==================== Card of items ======================

  listofitemscard() {
    children.length = 0;
    var individualCount = 0;

    for (var i = 0; i < itemscount; i++) {
      children.add(Padding(
        padding: EdgeInsets.fromLTRB(1.w, 1.w, 1.w, 0),
        child: Container(
            width: 92.w,
            height: 14.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2.w),
              boxShadow: [
                BoxShadow(
                    color: const Color(0XFFA8B4C5).withOpacity(0.30),
                    spreadRadius: 0,
                    blurRadius: 14,
                    offset: const Offset(0, 6.0)),
              ],
            ),
            child: Row(
              children: [
                SizedBox(width: 2.w),
                CircleAvatar(
                    radius: 6.w,
                    backgroundColor: const Color(0xffececec),
                    child: Padding(
                        padding: EdgeInsets.all(1.7.w),
                        child: SizedBox() //Image.network(
                        //   images![i],
                        //   errorBuilder: (BuildContext context, Object exception,
                        //       stackTrace) {
                        //     return Image.asset("assets/images/errorimage.png",
                        //         fit: BoxFit.cover);
                        //   },
                        // ),
                        )),
                SizedBox(width: 2.w),
                SizedBox(
                  width: 38.w,
                  child: Expanded(
                    child: Text(names![i],
                        style: TextStyle(color: Colors.black, fontSize: 13.sp)),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                  child: Text("${cost?[i]}/-",
                      style:
                          TextStyle(color: Colors.grey[400], fontSize: 13.sp)),
                ),
                SizedBox(
                  width: 27.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              if (count![i] > 0) {
                                totalcount -= 1;
                                count?[i] -= 1;

                                if (orderNames!.contains(names?[i])) {
                                  if (count![i] == 0) {
                                    orderNames?.remove(names?[i]);
                                    orderCost?.remove(orderCost![i]);
                                  } else {
                                    null;
                                  }
                                } else {
                                  null;
                                }
                                oc?[omniv] -= 1;

                                finalTotal =
                                    finalTotal - int.parse("${cost?[i]}");
                              } else {
                                setState(() {
                                  isadding = false;
                                });
                              }
                            });
                          },
                          icon: Icon(Icons.remove_circle,
                              color: Colors.grey[400], size: 7.w)),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              totalcount += 1;

                              isadding = true;

                              count![i] += 1;

                              if (orderNames!.contains("${names?[i]}")) {
                                orderCost?.add('${cost![i]}');
                              } else {
                                setState(() {
                                  orderNames?.add("${names?[i]}");
                                  orderCost?.add('${cost![i]}');
                                  indicator += 1;
                                  oc!.add(count![i]);
                                });
                              }
                              omniv = orderNames!.indexWhere(
                                  (element) => element == names![i]);
                              oc?[omniv] = count![i];

                              finalTotal =
                                  finalTotal + int.parse("${cost?[i]}");
                            });
                          },
                          icon: Icon(Icons.add_circle,
                              color: const Color(0xff9F6CE2), size: 7.w)),
                    ],
                  ),
                )
              ],
            )),
      ));
    }
    return SizedBox(
        child: Column(
      children: children,
    ));
  }

  setorderCount() {
    for (int i = 0; i < orderNames!.length; i++) {
      orderCount?.add("${orderNames![i]} - ${oc![i]}");

    }
  }

//================== mini order tracking =================

  getOrderCard() {
    orderchildren.length = 0;

    for (int i = 0; i < orderNames!.length && orderCount!= 0; i++) {
      orderchildren.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            height: 8.w,
            child: Padding(
              padding: EdgeInsets.fromLTRB(2.w, 0, 2.w, 0),
              child: Center(
                  child:
                      Expanded(child: Text(orderNames![i] + " - ${oc![i]}"))),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.w),
              color: Color(0xffE9E9E9),
            )),
      ));
    }
    return Row(children: orderchildren);
  }

  Cartlist() {
    final docs = orderchildren;

    if(orderCount!= 0){

    return Column(
      children: [
        SizedBox(height: 30,),
        Text('My Bill',style: TextStyle(fontSize: 25),),
        SizedBox(height: 30,),
        Row(
          children: [
            SizedBox(width: MediaQuery.of(context).size.width / 3,

              child: Text('Items',style: TextStyle(fontSize: 22),textAlign: TextAlign.center )),
            SizedBox(width: MediaQuery.of(context).size.width / 3,
                child: Text('Count',style: TextStyle(fontSize: 18),textAlign: TextAlign.center)),

        SizedBox(width: MediaQuery.of(context).size.width / 3,
              child: Text('Cost',style: TextStyle(fontSize: 22),textAlign: TextAlign.center))
          ],

        ),
        SizedBox(height: 20,),
        const MySeparator(color: Colors.grey),
        SizedBox(height: 30,),

        SizedBox(
          height:  MediaQuery.of(context).size.height*2/5 ,
          child: ListView.builder(
            itemCount: orderNames?.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            itemBuilder: (_, i) {

              if(orderNames?.length!=0){
              return Column(
                children: [SizedBox(height: 10,),
                  Row(
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width / 3,
                        child: Text(orderNames![i],style: TextStyle(fontFamily: 'Raleway',
                            fontSize: 17),textAlign: TextAlign.center),),
                      SizedBox(width: MediaQuery.of(context).size.width / 3,
                        child: Text(oc![i].toString(),style: TextStyle(fontSize: 17),textAlign: TextAlign.center),),



                      SizedBox(width: MediaQuery.of(context).size.width / 3,
                        child: Text(orderCost![i],style: TextStyle(fontSize: 17),textAlign: TextAlign.center),)
                    ],

                  ),
                  SizedBox(height: 10,),
                ],
              );}
              else{
                return Center(
                  child: Text('Empty cart',style: TextStyle(fontSize: 32),textAlign: TextAlign.center)
                );
              }
            },
          ),
        ),
    Row(
      children: [
        SizedBox(width: MediaQuery.of(context).size.width / 3,),
            SizedBox(width: MediaQuery.of(context).size.width / 3,),
            SizedBox(width: MediaQuery.of(context).size.width / 3,
              child: const MySeparator(color: Colors.grey),),
      ],
    ),
        SizedBox(height: 30,),
        Row(
          children: [
            SizedBox(width: MediaQuery.of(context).size.width / 3,child: Text('Total Cost',style: TextStyle(fontSize: 22),textAlign: TextAlign.right,),),
            SizedBox(width: MediaQuery.of(context).size.width / 3,child: Text('-',style: TextStyle(fontSize: 30),textAlign: TextAlign.right,),),
            SizedBox(width: MediaQuery.of(context).size.width / 3,
              child: Text('$finalTotal/-',style: TextStyle(fontSize: 22),textAlign: TextAlign.center))
          ],
        ),
        SwipingButton(text: "Pay Now",
          padding: EdgeInsets.all(15),
          height: 60,
          swipeButtonColor
              : const Color(0xff7732B1),
          backgroundColor: const Color(0xffC38DDB),

          onSwipeCallback:() async {
          setorderCount();


          if(finalTotal!=0){

          await _firestore
              .collection("Canteen")
              .doc("orders")
              .collection("orderDetails")
              .doc("${totalorders + 1}")
              .set(
            {
              "Person": cuser,
              "FoodItems": orderCount,
              "Total": finalTotal,
              "isPaid": false,
              "status": "Not-Delivered",
              "OrderNumber": totalorders + 1,
              "personid": _auth.currentUser?.uid,
            },
          );
          await _firestore
              .collection("Canteen")
              .doc("TotalOrders")
              .set(
            {
              "count": totalorders + 1,
              "count2": totalorders + 1,
            },);
              await _firestore
                  .collection("Canteen")
                  .doc("orders")
                  .collection("orderSummary")
                  .doc("${totalorders + 1}")
                  .set(
                {
                  "status": 'OrderDetails',

                },
          );
          await _firestore
              .collection("Student")
              .doc(_auth.currentUser?.uid)
              .collection("recentOrders")
              .doc("${totalorders + 1}")
              .set(
            {
              "Person": cuser,
              "FoodItems": orderCount,
              "Total": finalTotal,
              "isPaid": false,
              "status": "Not-Delivered",
              "OrderNumber": totalorders + 1,
              "personid": _auth.currentUser?.uid,

            },
          );

          setState(() {
            totalorders = 0;
            orderNames = [];
            oc = [];
            orderCount = [];
          });
          emptyLists();
          getUserData();
          getTotalOrders();
          setState(() {
            isLoading = true;
            isLoaded = false;
          });

          getCount();
          Future.delayed(
              const Duration(milliseconds: 500), () {});
          getItems();
          Future.delayed(
              const Duration(milliseconds: 2200), () {
            setState(() {
              isLoaded = true;
              isLoading = false;
              isadding =
              false; // Here you can write your code for open new view
            });
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => PayLater(ordernumber: totalorders + 1 )));


        }else{
            Flushbar(
              title: "Please make Order first",
              message:
              'Trying to make payment on empty cart',
              duration: Duration(seconds: 2),
            )..show(context);
            setState(() {
              _selectedIndex =0;
            });
          }

            })

      ],
    );}
    else{
      return CircularProgressIndicator();
    }


  }


  emptyLists() async {
    names?.length = 0;

    cost?.length = 0;
    list?.length = 0;
    images?.length = 0;
    count = List.filled(itemscount, 0);
    finalTotal = 0;
    orderCost = [];

  }



  @override
  void initState() {
    getUserData();
    _pageController = PageController();
    getTotalOrders();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    setState(() {
      isLoading = true;
      isLoaded = false;
    });

    emptyLists();
    getCount();
    Future.delayed(const Duration(milliseconds: 500), () {});
    getItems();
    Future.delayed(const Duration(milliseconds: 2200), () {
      setState(() {
        count = List.filled(itemscount, 0);
        isLoaded = true;
        isLoading = false; // Here you can write your code for open new view
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    animationController?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {

      List<Widget> wid = [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: 15.h,
                  width: 100.w,
                  color: Colors.white,
                  child: Column(
                    children: [
                      isadding
                          ? SizedBox(
                        height: 8.h,
                        child: ListView(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          scrollDirection: Axis.horizontal,
                          children: [
                            getOrderCard(),
                          ],
                        ),
                      )
                          : SizedBox(
                        height: 8.h,
                        child: Center(
                          child: Text(
                              "Start adding items by clicking on +",
                              style:
                              TextStyle(color: Colors.grey[400])),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(2.w, 1.w, 2.w, 0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ButtonTheme(
                                  minWidth: 20.w,
                                  height: 6.w,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(20.w)),
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        orderNames = [];
                                        orderCost = [];
                                        count = List.filled(itemscount, 0);
                                        oc!.length = 0;
                                        finalTotal = 0;
                                        isadding = false;
                                        orderCount = [];
                                      });
                                    },
                                    child: Text("clear",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w400)),
                                  )),
                              Row(children: [
                                const Text("Total : "),
                                Container(
                                  height: 9.w,
                                  child: Padding(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 2.w),
                                    child: Center(
                                        child: Text("Rs. $finalTotal",
                                            style:
                                            TextStyle(fontSize: 12.sp))),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(1.w),
                                      color: const Color(0xffE7D3F4)),
                                )
                              ])
                            ]),
                      )
                    ],
                  )),
              Divider(
                height: 0,
                color: Colors.grey[300],
                thickness: 0.4.w,
              ),
              Padding(
                padding: EdgeInsets.all(2.w),
                child: Text(
                  "ITEMS",
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                  width: 94.w,
                  height: 61.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2.w),
                      color: const Color(0xffF4F4F4)),
                  child: ListView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    children: [
                      SizedBox(height: 2.w),
                      isLoaded
                          ? listofitemscard()
                          : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 11.h),
                          SizedBox(
                            height: 30.w,
                            width: 30.w,
                            child: Image.asset("assets/images/cup.png"),
                          ),
                          SpinKitThreeInOut(
                            color: Color.fromARGB(255, 144, 80, 197),
                            size: 10.w,
                          ),
                        ],
                      ),
                    ],
                  )),
              SizedBox(height: 2.h),

            ],
          ),
        ),
        Cartlist(),
        recentOrders(),



      ];

      Uri url = Uri.parse("mailto:20BDS062@iiitdwd.ac.in");
      return Scaffold(
          backgroundColor: const Color(0XFFFFFFFF),
          appBar: AppBar(
              title: Text("STEWARD",
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400)),
              centerTitle: true,
              elevation: 10,

              flexibleSpace: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Color(0xff7732B1), Color(0xffC38DDB)]))
              )),
        drawer: Drawer(
          //backgroundColor : Color(0xffdfc5ee),
            child: ListView(
              children: <Widget>[
                DrawerHeader(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Text(cuser,

                            style: TextStyle(fontSize: 20)),
                        Text(
                          cemail,
                            style: TextStyle(fontSize: 18)
                        )
                      ],
                    ),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xff7732B1), Color(0xffC38DDB)]))),
                Container(
                    child: Column(
                      children: [


                        Row(children: [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text("Roll No. - " + croll)
                          ),
                          SizedBox(width: 30,),

                        ]),


                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                        Row(children: [
                          InkWell(
                            onTap: (){
                              _onPasswordforgot();
                              _auth.signOut();
                              Navigator.pushReplacement(
                              context,
                              PageTransition(
                              alignment: Alignment.centerLeft,
                              duration: const Duration(milliseconds: 600),
                              type: PageTransitionType.bottomToTopPop,
                              childCurrent:  CanteenHome(),
                              child: LoginPage()));
                            },
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Icon(
                                Icons.password_sharp,
                                size: 30.0,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Text("Change Password")
                        ]),
                        InkWell(
                          onTap: () async => {

                            if (await canLaunchUrl(url)) {
                              await launchUrl(url)} else {
                            throw 'Could not launch $url'
                           }
                          },
                          child: Row(children: [
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Icon(
                                Icons.help,
                                size: 30.0,
                                color: Colors.grey,
                              ),
                            ),
                            Text("Write Us!")
                          ]),
                        ),
                        // InkWell(
                        //   onTap: ()=> {
                        //   setState(() {
                        //   _selectedIndex = 3;
                        //   Navigator.pop(context);
                        //   })
                        //   },
                        //   child: Row(children: [
                        //     Padding(
                        //       padding: EdgeInsets.all(10.0),
                        //       child: Icon(
                        //         Icons.settings,
                        //         size: 30.0,
                        //         color: Colors.grey,
                        //       ),
                        //     ),
                        //     Text("Settings")
                        //   ]),
                        // ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 0.0),
                          child: InkWell(
                            onTap: ()=>{
                              _auth.signOut(),
                              Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  alignment: Alignment.centerLeft,
                                  duration: const Duration(milliseconds: 600),
                                  type: PageTransitionType.bottomToTopPop,
                                  childCurrent:  CanteenHome(),
                                  child: LoginPage()))},
                            child: Row(children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.logout,
                                  size: 30.0,
                                  color: Colors.black,
                                ),
                              ),
                              Text("Logout")
                            ]),
                          ),
                        ),
                      ],
                    ))
              ],
            )),
          body: wid[_selectedIndex],
        bottomNavigationBar: BottomNavyBar(
        selectedIndex: _selectedIndex,
        curve: Curves.easeIn,
        showElevation: true,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
          _pageController.jumpToPage(index);
        },
        items: this.widget.navigationTitles.map((title) {
          int index = this.widget.navigationTitles.indexOf(title);
          return BottomNavyBarItem(
            title: Text(title),
            icon: this.widget.navigationIcons[index],
            activeColor: Color(0xff7732B1)
          );
        }).toList(),
      ),

      );


    });
  }
}

class Fard {
  late String name;
  late int cost;
  Fard(this.name, this.cost);
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

Future<void> _onPasswordforgot() async {
  SystemChannels.textInput.invokeMethod('TextInput.hide');

  try {

    await forgotPasswordEmail(cemail.trim());

    Flushbar(
      title: "Password Reset Email Sent",
      message:
      'Check your email and follow the instructions to reset your password.',
      duration: Duration(seconds: 20),
    );
  } catch (e) {

    print("Forgot Password Error: $e");

    Flushbar(
      title: "Forgot Password Error",
      message: e.toString(),
      duration: Duration(seconds: 10),
    );
  }

}