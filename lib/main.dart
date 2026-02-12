import 'package:flutter/material.dart';

void main() {
  runApp(StudentStressApp());
}

class StudentStressApp extends StatelessWidget {
  // Sample data: names + weekly stress %
  final List<Map<String, dynamic>> studentsWeek1to6 = [
    {
      'name': 'Hikma',
      'weeks': [5, 7, 20, 35, 37, 65],
    },
    {
      'name': 'David',
      'weeks': [25, 30, 35, 40, 45, 50],
    },
    {
      'name': 'Alice',
      'weeks': [20, 25, 30, 35, 40, 45],
    },
    {
      'name': 'Hamse',
      'weeks': [35, 40, 45, 50, 55, 60],
    },
    {
      'name': 'Kevin',
      'weeks': [28, 33, 38, 43, 48, 53],
    },
    {
      'name': 'Thierry',
      'weeks': [22, 27, 32, 37, 42, 47],
    },
  ];

  final List<Map<String, dynamic>> studentsWeek7to11 = [
    {
      'name': 'Hikma',
      'weeks': [70, 75, 80, 85, 90],
    },
    {
      'name': 'David',
      'weeks': [55, 60, 65, 70, 75],
    },
    {
      'name': 'Michael',
      'weeks': [50, 55, 60, 65, 70],
    },
    {
      'name': 'Hamse',
      'weeks': [65, 70, 75, 80, 85],
    },
    {
      'name': 'Kevin',
      'weeks': [60, 65, 70, 75, 80],
    },
    {
      'name': 'Thierry',
      'weeks': [55, 60, 65, 70, 75],
    },
  ];

  StudentStressApp({super.key});

  Color getStressColor(int stress) {
    if (stress < 40) return Colors.green[300]!;
    if (stress < 60) return Colors.yellow[300]!;
    if (stress < 80) return Colors.orange[300]!;
    return Colors.red[300]!;
  }

  Widget buildTable(
    String title,
    List<Map<String, dynamic>> students,
    int startWeek,
  ) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withAlpha((0.7 * 255).round()),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: DataTable(
            headingRowColor: WidgetStateProperty.all(Colors.teal),

            headingTextStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            columnSpacing: 12,
            columns: [
              DataColumn(label: Text('Name')),
              for (int i = 0; i < students[0]['weeks'].length; i++)
                DataColumn(label: Text('Week ${startWeek + i}')),
            ],
            rows: students.map((student) {
              return DataRow(
                cells: [
                  DataCell(Text(student['name'])),
                  for (int stress in student['weeks'])
                    DataCell(
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: getStressColor(stress),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '$stress%',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Stress Tracker',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Student Stress Tracker'),
          backgroundColor: Colors.teal,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 16),
              Text(
                'Weeks 1–6 (Current Stress)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildTable('Weeks 1–6', studentsWeek1to6, 1),
              SizedBox(height: 32),
              Text(
                'Weeks 7–11 (Projected Stress)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildTable('Weeks 7–11', studentsWeek7to11, 7),
            ],
          ),
        ),
      ),
    );
  }
}
