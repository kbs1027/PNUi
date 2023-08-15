import 'package:app/model/Departmentmodel.dart';
import 'package:app/model/model.dart';
import 'package:app/view_model/viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoticeList extends StatefulWidget {
  const NoticeList({super.key});

  @override
  State<NoticeList> createState() => _NoticeListState();
}

class _NoticeListState extends State<NoticeList> {
  final List<String> departments = ['정보컴퓨터공학부', '기계공학부', 'Department 3'];

  List<RssData> listData = []; // Data to display in the ListView

  @override
  Widget build(BuildContext context) {
    // Access the DepartmentModel using Provider
    final departmentModel =
        Provider.of<DepartmentModel>(context, listen: false);

    // If the selectedDepartmentIndex is null, we default to an empty string.
    int? currentDepartment = departmentModel.selectedDepartmentIndex;

    return Scaffold(
      appBar: AppBar(
        title: const Text('게시판목록'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          OutlinedButton(
            onPressed: () async {
              var list =
                  await getAllRssByDepartment(departments[currentDepartment!]);

              setState(() {
                listData = list;
              });
            },
            child: const Text('SELECT'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: listData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(listData[index].department),
                  subtitle: Text(
                      '${listData[index].noticeMenu} / ${listData[index].Rss}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
