import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marksheet_generator/model/result.dart';
import 'package:marksheet_generator/view_model/result_viewmodel.dart';

class ResultView extends ConsumerStatefulWidget {
  const ResultView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ResultViewState();
}

class _ResultViewState extends ConsumerState<ResultView> {
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final markController = TextEditingController();
  List<String> course = ["IOT", "WEB API", "Flutter", "Design Thinking"];
  String? selectedCourse = "";
  final List<DataRow> rows = [
    DataRow(cells: [
      const DataCell(Text('1')),
      const DataCell(Text('Math')),
      const DataCell(Text('90')),
      DataCell(IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          // Perform edit action
        },
      )),
    ]),
    DataRow(cells: [
      const DataCell(Text('2')),
      const DataCell(Text('Science')),
      const DataCell(Text('85')),
      DataCell(IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          // Perform edit action
        },
      )),
    ]),
    // Add more rows as needed
  ];

  @override
  Widget build(BuildContext context) {
    var data = ref.read(resultViewModelProvider);
    final totalMarks =
        data.result.fold(0, (sum, markSheet) => sum + (markSheet.mark ?? 0));
    final result =
        data.result.any((markSheet) => markSheet.mark < 40) ? 'Fail' : 'Pass';

    String division;
    final totalPercentage = (totalMarks / data.result.length);
    if (totalPercentage >= 60) {
      division = 'First Division';
    } else if (totalPercentage >= 50) {
      division = 'Second Division';
    } else if (totalPercentage >= 40) {
      division = 'Third Division';
    } else {
      division = "Fail";
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Result"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: fNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "First Name",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: lNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Last Name",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField(
              items: course
                  .map(
                    (option) => DropdownMenuItem(
                      value: option,
                      child: Text(option),
                    ),
                  )
                  .toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedCourse = newValue!;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Select a course',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: markController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter Mark",
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Result result = Result(
                fname: fNameController.text,
                lname: lNameController.text,
                course: selectedCourse!,
                mark: int.parse(markController.text),
              );

              ref.read(resultViewModelProvider.notifier).addMark(result);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Marks Added Successfully'),
                  duration: Duration(seconds: 1),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text("Add Mark"),
          ),
          data.result.isNotEmpty
              ? Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        FittedBox(
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text('First Name')),
                              DataColumn(label: Text('Last Name')),
                              DataColumn(label: Text('Module')),
                              DataColumn(label: Text('Marks')),
                              DataColumn(label: Text('Action')),
                            ],
                            rows: data.result.map((result) {
                              return DataRow(
                                cells: [
                                  DataCell(Text(result.fname)),
                                  DataCell(Text(result.lname)),
                                  DataCell(Text(result.course)),
                                  DataCell(Text(result.mark.toString())),
                                  DataCell(
                                    IconButton(
                                      onPressed: () {
                                        ref
                                            .read(resultViewModelProvider
                                                .notifier)
                                            .deleteMarkSheet(result);
                                      },
                                      icon: const Icon(Icons.delete),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                        FittedBox(
                          child: Container(
                            alignment: Alignment.bottomRight,
                            margin: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('Total Marks: $totalMarks'),
                                Text('Result: $result'),
                                Text('Division: $division'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const Text("No Data"),
        ],
      ),
    );
  }
}
