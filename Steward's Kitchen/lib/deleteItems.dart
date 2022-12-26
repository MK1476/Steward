import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';


bool isLoaded = false;
int itemscount = 0; // count of all items in firebase
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
List<Map<String, dynamic>?>? list = []; // list containing maps of items
Map<String, dynamic>? userMap;
final children = <Widget>[]; // list to store itemcards
List<String>? names = []; // list to store names of items from firebase
List<String>? cost = []; // list to store cost of items from firebase
List<String>? images = [];

class deleteItems extends StatefulWidget {
  deleteItems({Key? key}) : super(key: key);

  @override
  State<deleteItems> createState() => _deleteItemsState();
}

class _deleteItemsState extends State<deleteItems> {
  getCount() async {
    QuerySnapshot productCollection = await FirebaseFirestore.instance
        .collection('Canteen')
        .doc("items")
        .collection("itemDetails")
        .get();
    itemscount = productCollection.size;
  }

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
          list?.add(value.docs[i].data());
          names?.add(userMap!["foodName"]);
          cost?.add(userMap!["foodCost"]);
          images?.add(userMap!["foodImage"]);
        }
      });
    });
  }

  listofitemscard() {
    children.length = 0;

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
                SizedBox(width: 1.w),
                CircleAvatar(
                    radius: 5.w,
                    backgroundColor: const Color(0xffececec),
                    child: Padding(
                      padding: EdgeInsets.all(1.5.w),
                      child: Image(
                        image: NetworkImage(images![i]),
                      ),
                    )),
                SizedBox(width: 2.w),
                SizedBox(
                  width: 44.w,
                  child: Expanded(
                    child: Text("${names?[i]}",
                        style: TextStyle(color: Colors.black, fontSize: 13.sp)),
                  ),
                ),
                Text("${cost?[i]}/-",
                    style: TextStyle(color: Colors.grey[500], fontSize: 13.sp)),
                SizedBox(width: 12.w),
                IconButton(
                    onPressed: () async {
                      await _firestore
                          .collection('Canteen')
                          .doc('items')
                          .collection('itemDetails')
                          .doc("${names?[i]}")
                          .delete();
                      emptyLists();
                      getCount();

                      getItems();
                      Future.delayed(const Duration(milliseconds: 1200), () {
                        setState(() {
                          isLoaded = true;
                        });
                      });
                    },
                    icon: Icon(Icons.delete_forever_rounded,
                        color: Color.fromARGB(255, 210, 46, 81), size: 7.w))
              ],
            )),
      ));
    }
    return SizedBox(
        child: Column(
      children: children,
    ));
  }

  emptyLists() async {
    names?.length = 0;
    cost?.length = 0;
    list?.length = 0;
    images?.length = 0;
  }

  @override
  void initState() {
    setState(() {
      isLoaded = false;
    });
    emptyLists();
    getCount();

    getItems();
    Future.delayed(const Duration(milliseconds: 1200), () {
      setState(() {
        isLoaded = true;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
          appBar: AppBar(
              title: Text("DELETE ITEMS",
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
          body: Container(
            width: 100.w,
            height: 100.h,
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
            ),
          ));
    });
  }
}
