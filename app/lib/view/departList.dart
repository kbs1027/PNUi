import 'package:app/model/Departmentmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class departList extends StatefulWidget {
  const departList({super.key});

  @override
  State<departList> createState() => _departListState();
}

class _departListState extends State<departList> {
  final List<String> departments = ['정보컴퓨터공학부', '기계공학부', 'Department 3'];

  @override
  Widget build(BuildContext context) {
    return Consumer<DepartmentModel>(
      builder: (context, departmentModel, child) {
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
                onPressed: () {
                  // 선택한 값을 저장하고 화면을 닫습니다.
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.check),
              ),
            ],
          ),
          body: ListView.builder(
            itemCount: departments.length,
            itemBuilder: (context, index) {
              return RadioListTile<int>(
                title: Text(departments[index]),
                value: index,
                groupValue: departmentModel.selectedDepartmentIndex,
                onChanged: (int? value) {
                  departmentModel.selectedDepartmentIndex = value;
                },
              );
            },
          ),
        );
      },
    );
  }
}
