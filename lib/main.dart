import 'package:flutter/material.dart';

import 'CatApi.dart';
import 'api2.dart';
import 'api3.dart';
import 'api4.dart';
import 'insideobj.dart';
import 'jokesAPI.dart';
import 'listget.dart';
import 'listplace.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: objin()
    );
  }
}




import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_filex/open_filex.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:excel/excel.dart';
import 'database_helper.dart';
import 'reward.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rewards Report',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RewardsReportPage(),
    );
  }
}

class RewardsReportPage extends StatefulWidget {
  @override
  _RewardsReportPageState createState() => _RewardsReportPageState();
}

class _RewardsReportPageState extends State<RewardsReportPage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  DateTime? _fromDate;
  DateTime? _toDate;
  List<Reward> _rewards = [];

  void _pickFromDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _fromDate = picked;
      });
    }
  }

  void _pickToDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _toDate = picked;
      });
    }
  }

  void _generateReport() async {
    if (_fromDate != null && _toDate != null) {
      List<Reward> rewards = await _dbHelper.getRewardsByDateRange(_fromDate!, _toDate!);
      setState(() {
        _rewards = rewards;
      });
    }
  }

  Future<void> _generatePDF() async {
    if (await _requestStoragePermission()) {
      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Column(
            children: [
              pw.Text('Rewards Report', style: pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 20),
              pw.Table.fromTextArray(
                headers: ['S.No', 'Date', 'Reward Points'],
                data: List<List<String>>.generate(
                  _rewards.length,
                  (index) => [
                    (index + 1).toString(),
                    _rewards[index].date,
                    _rewards[index].points.toString(),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

      final directory = await getExternalStorageDirectory();
      if (directory != null) {
        final filePath = await _getUniqueFilePath(directory.path, 'rewards_report', 'pdf');
        final file = File(filePath);
        await file.writeAsBytes(await pdf.save());
        OpenFilex.open(file.path);
      }
    } else {
      // Handle permission denied
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Storage permission is required to save the file')),
      );
    }
  }

  Future<void> _generateExcel() async {
    if (await _requestStoragePermission()) {
      final excel = Excel.createExcel();
      final sheet = excel['Sheet1'];

      // Adding header row
      sheet.appendRow(['S.No', 'Date', 'Reward Points']);

      // Adding data rows
      for (int i = 0; i < _rewards.length; i++) {
        sheet.appendRow([
          (i + 1).toString(),
          _rewards[i].date,
          _rewards[i].points.toString(),
        ]);
      }

      final directory = await getExternalStorageDirectory();
      if (directory != null) {
        final filePath = await _getUniqueFilePath(directory.path, 'rewards_report', 'xlsx');
        final file = File(filePath);
        final bytes = excel.encode()!;
        await file.writeAsBytes(bytes);
        OpenFilex.open(file.path);
      }
    } else {
      // Handle permission denied
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Storage permission is required to save the file')),
      );
    }
  }

  Future<bool> _requestStoragePermission() async {
    PermissionStatus status = await Permission.storage.request();
    return status.isGranted;
  }

  Future<String> _getUniqueFilePath(String basePath, String fileName, String extension) async {
    int counter = 1;
    String fullPath = '$basePath/$fileName.$extension';

    while (await File(fullPath).exists()) {
      fullPath = '$basePath/$fileName($counter).$extension';
      counter++;
    }

    return fullPath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rewards Report'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: _pickFromDate,
                  child: Text(_fromDate == null ? 'Select From Date' : DateFormat.yMd().format(_fromDate!)),
                ),
                TextButton(
                  onPressed: _pickToDate,
                  child: Text(_toDate == null ? 'Select To Date' : DateFormat.yMd().format(_toDate!)),
                ),
                ElevatedButton(
                  onPressed: _generateReport,
                  child: Text('Generate Report'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: _rewards.isEmpty
                  ? Center(child: Text('No data available'))
                  : DataTable(
                      columns: [
                        DataColumn(label: Text('S.No')),
                        DataColumn(label: Text('Date')),
                        DataColumn(label: Text('Reward Points')),
                      ],
                      rows: _rewards
                          .asMap()
                          .entries
                          .map(
                            (entry) => DataRow(cells: [
                              DataCell(Text((entry.key + 1).toString())),
                              DataCell(Text(entry.value.date)),
                              DataCell(Text(entry.value.points.toString())),
                            ]),
                          )
                          .toList(),
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _generatePDF,
                  child: Text('Generate PDF'),
                ),
                ElevatedButton(
                  onPressed: _generateExcel,
                  child: Text('Generate Excel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<String> _getUniqueFilePath(String basePath, String fileName, String extension) async {
  int counter = 1;
  String fullPath = '$basePath/$fileName.$extension';

  while (await File(fullPath).exists()) {
    fullPath = '$basePath/$fileName($counter).$extension';
    counter++;
  }

  return fullPath;
}
import 'package:permission_handler/permission_handler.dart';

Future<bool> _requestStoragePermission() async {
  PermissionStatus status = await Permission.storage.request();
  return status.isGranted;
}





