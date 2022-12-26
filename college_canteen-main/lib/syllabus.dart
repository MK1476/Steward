import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class Syllabus extends StatefulWidget {
  Syllabus({Key? key}) : super(key: key);

  @override
  State<Syllabus> createState() => _SyllabusState();
}

class _SyllabusState extends State<Syllabus> {
  List<String> branch = ['CSE', 'DSAI', 'ECE'];
  String selected_branch = 'CSE';
  String? dropdownNames;
  String dropdownScrollable = 'I';

  final TextEditingController sem = TextEditingController();
  final TextEditingController course_name = TextEditingController();
  final TextEditingController course_code = TextEditingController();
  final TextEditingController credits = TextEditingController();
  final TextEditingController prereq = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
          appBar: AppBar(
              title: Text("ADD SYLLABUS",
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                DropdownButton<String>(
                  isExpanded: true,
                  value: selected_branch,
                  icon: Icon(Icons.keyboard_arrow_down),
                  onChanged: (String? newValue) {
                    setState(() {
                      selected_branch = newValue!;
                    });
                  },
                  items: branch.map((category) {
                    return DropdownMenuItem(
                        child: Container(
                            margin: EdgeInsets.only(left: 4, right: 4),
                            child: Text(category)),
                        value: category);
                  }).toList(),
                ),
                TextFormField(
                  controller: sem,
                  decoration: InputDecoration(
                    labelText: "Sem",
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 0.5, color: Colors.grey),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    suffixIcon: Icon(Icons.edit, color: Colors.black, size: 18),
                  ),
                ),
                SizedBox(height: 2.h),
                TextFormField(
                  controller: course_name,
                  decoration: InputDecoration(
                    labelText: "CourseName",
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 0.5, color: Colors.grey),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    suffixIcon: Icon(Icons.edit, color: Colors.black, size: 18),
                  ),
                ),
                SizedBox(height: 2.h),
                TextFormField(
                  controller: course_code,
                  decoration: InputDecoration(
                    labelText: "Course Code",
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 0.5, color: Colors.grey),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    suffixIcon: Icon(Icons.edit, color: Colors.black, size: 18),
                  ),
                ),
                SizedBox(height: 2.h),
                TextFormField(
                  controller: credits,
                  decoration: InputDecoration(
                    labelText: " Credits",
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 0.5, color: Colors.grey),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    suffixIcon: Icon(Icons.edit, color: Colors.black, size: 18),
                  ),
                ),
                SizedBox(height: 2.h),
                TextFormField(
                  controller: prereq,
                  decoration: InputDecoration(
                    labelText: "Prerequisite",
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 0.5, color: Colors.grey),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    suffixIcon: Icon(Icons.edit, color: Colors.black, size: 18),
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      await _firestore
                          .collection("Syllabus")
                          .doc(sem.text)
                          .collection(selected_branch)
                          .doc(course_name.text)
                          .set(
                        {
                          "Course Name": course_name.text.trim(),
                          "Course Code": course_code.text.trim(),
                          "Credits": credits.text.trim(),
                          "Prerequisites": prereq.text.trim(),
                        },
                      );
                      setState(() {});
                      setState(() {
                        course_name.text = "";
                        course_code.text = "";
                        credits.text = "";
                        prereq.text = "";
                      });

                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Course added",
                            style: TextStyle(color: Colors.white)),
                        backgroundColor: Color(0xff581A9E),
                      ));
                    },
                    child: Text("Add")),
                ElevatedButton(onPressed: () {}, child: Text("Cancel"))
              ],
            ),
          ));
    });
  }
}
