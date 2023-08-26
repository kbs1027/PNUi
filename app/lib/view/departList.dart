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
  final List<String> departments = [
    '정보컴퓨터공학부',
    '경영학부',
    '전기공학과',
  ];

  User? currentUser;

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

              // Assuming that currentUser is the currently logged-in user
              if (currentUser != null) {
                currentUser!.department = department.id;
                await SqlDatabase.instance.updateUserDepartment(currentUser!);
              } else {
                User user = User(department: department.id);
                await SqlDatabase.instance.insertUser(user);
              }

              // Close the screen after saving
              Navigator.pop(context, selectedDepartment);
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Column(
        children: departments.map((department) {
          return RadioListTile(
            title: Text(department),
            value: department,
            groupValue: selectedDepartment,
            onChanged: (value) {
              setState(() {
                selectedDepartment = value;
                // ignore: unused_local_variable
              });
            },
          );
        }).toList(),
      ),
    );
  }
}
