import 'package:common_user/common/colors.dart';
import 'package:common_user/common/provider/providervariable.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/planning%20tools/tasklist/alltask.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/planning%20tools/tasklist/completetasklist.dart';
import 'package:common_user/homepage/New%20Event/main%20screen/planning%20tools/tasklist/pendingtasklist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class tasklist extends ConsumerStatefulWidget {
  const tasklist({super.key});

  @override
  ConsumerState<tasklist> createState() => _tasklistState();
}

class _tasklistState extends ConsumerState<tasklist> {
  final TextEditingController taskcont = TextEditingController();

  String selectedType = "Select option";
  final List<String> taskOptions = [
    "Select option",
    "From 10 to 12 months",
    "From 7 to 9 months",
    "From 4 to 6 months",
    "From 2 to 3 months",
    "The last month",
    "2 weeks Before",
    "Last week",
    "After the Event",
  ];

  @override
  Widget build(BuildContext context) {
     final alllistname = ref.watch(tasklistprovidername);
  final alllisttime = ref.watch(tasklistprovidertime);
  final pendinglistname = ref.watch(tasklistpendingname);
  final pendinglisttime = ref.watch(tasklistpendingtime);
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // ---------- Header / Form ----------
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add TaskList",
                      style: GoogleFonts.sahitya(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),
                    eventnameform1(
                      hint: "Task Name",
                      maxer: 30,
                      specifyname: false,
                      parteventname: taskcont,
                    ),
                    const SizedBox(height: 12),
                    dropdownField(),
                     const SizedBox(height: 12),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                             final name = taskcont.text.trim();

    // 1) validate
    if (name.isEmpty || selectedType == "Select option") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter task name & select time")),
      );
      return;
    }

    // 2) add both together (pair)
    setState(() {
      alllistname.add(name);
      alllisttime.add(selectedType);
      pendinglistname.add(name);
      pendinglisttime.add(selectedType);

      // 3) reset inputs
      taskcont.clear();
      selectedType = "Select option";
    });
                            // setState(() {
                            //   if( selectedType != "Select option")
                            //   taskNameList.add(taskcont.text);
                            //   taskTimeList.add(selectedType);
                            // });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
                              color: AppColors.buttoncolor,
                            ),
                            child:  Text("Save",style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold,color: Colors.white),),
                          ),
                        )
                      ],
                     )
                  ],
                ),
              ),

              // ---------- Tabs ----------
              Material(
                color: Colors.white,
                child: TabBar(
                  isScrollable: false,
                  indicatorWeight: 1,
                  unselectedLabelColor: Colors.grey,
                  labelColor: AppColors.buttoncolor,
                  indicatorColor: AppColors.buttoncolor,
                  unselectedLabelStyle: GoogleFonts.sahitya(
                    fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black54,
                  ),
                  labelStyle: GoogleFonts.sahitya(
                    fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.buttoncolor,
                  ),
                  tabs: const [
                    Tab(text: "Pending",  ),
                    Tab(text: "All",      ),
                    Tab(text: "Completed",),
                  ],
                ),
              ),

              // ---------- Tab content (constrained) ----------
              Expanded(
                child: TabBarView(
                  children:[
                    pendingtask(taskNames: pendinglistname, taskTimes: pendinglisttime),
                    alltasklist(taskNamesall: alllistname, taskTimesall:alllisttime),
                    completetasklist(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dropdownField() {

    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black26, width: 0.75),
        borderRadius: BorderRadius.circular(4),
        boxShadow: const [BoxShadow(spreadRadius: 1, blurRadius: 1, color: Colors.black38)],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedType,
          isExpanded: true,
          dropdownColor: Colors.white,
          style: GoogleFonts.inter(
            color: Colors.black45, fontSize: 14, fontWeight: FontWeight.w600,
          ),
          icon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black54),
            ],
          ),
          items: taskOptions.map((opt) {
            return DropdownMenuItem<String>(
              value: opt,
              child: Text(
                opt,
                style: TextStyle(
                  color: opt == "Select option" ? Colors.black38 : Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(),
          onChanged: (value) => setState(() => selectedType = value!),
        ),
      ),
    );
  }

  Widget eventnameform1({
    required String hint,
    required int maxer,
    required bool specifyname,
    required TextEditingController parteventname,
  }) {
    return StatefulBuilder(
      builder: (context, setLocal) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.05,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black26, width: 0.75),
            borderRadius: BorderRadius.circular(4),
            boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 1, spreadRadius: 1)],
          ),
          child: TextFormField(
            controller: parteventname,
            maxLength: maxer,
            onChanged: (_) => setLocal(() {}),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: GoogleFonts.inter(
              color: Colors.black87, fontSize: 14, fontWeight: FontWeight.w600,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              counterText: '',
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              hintText: "Task Name",
              hintStyle: TextStyle(fontSize: 14.0,color: Colors.black45)
            ),
          ),
        );
      },
    );
  }

  
}
