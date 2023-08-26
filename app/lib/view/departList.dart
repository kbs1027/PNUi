import 'package:app/model/Department.dart';
import 'package:app/model/User.dart';
import 'package:app/repo/repository.dart';
import 'package:flutter/material.dart';

class departList extends StatefulWidget {
  const departList({super.key});

  @override
  State<departList> createState() => _departListState();
}

class _departListState extends State<departList> {
  String? selectedDepartment = '정보컴퓨터공학부';
  List<Department>? departments;
  User? currentUser;

  @override
  void initState() {
    super.initState();
    _loadDepartments();
  }

  _loadDepartments() async {
    departments = await SqlDatabase.instance.getAllDepartments();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('과설정하기'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              Department department = await SqlDatabase.instance
                  .getDepartmentByName(selectedDepartment!);

              print(department.major);
              print(department.Boards);
              // Close the screen after saving
              User.instance.department = department;
              Navigator.pop(context, selectedDepartment);
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: departments?.map((department) {
                return RadioListTile(
                  title: Text(department.major!),
                  value: department.major,
                  groupValue: selectedDepartment,
                  onChanged: (value) {
                    setState(() {
                      selectedDepartment = value;
                    });
                  },
                );
              }).toList() ??
              [],
        ),
      ),
    );
  }
}
