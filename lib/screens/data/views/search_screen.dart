import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:my_windows_app/constants.dart';
import 'package:my_windows_app/route/route_constants.dart';

// Function to parse TimeOfDay from string
TimeOfDay parseTimeOfDay(String tod) {
  final time = tod.substring(10, 15); // Extract "07:59"
  final hour = int.parse(time.split(":")[0]);
  final minute = int.parse(time.split(":")[1]);
  return TimeOfDay(hour: hour, minute: minute);
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final List<String> _incidentTypes = [
    'Fire Raid',
    'IED Attk',
    'Abduction',
    'Tgy Killing',
    'Ambush',
    'Extortion',
    'SB Attk',
    'Polioi Incidents',
    'Robberies',
  ];

  DateTime? _date_start;
  DateTime? _date_end;
  TextEditingController _caseId = TextEditingController();
  TextEditingController _search_text = TextEditingController();
  String _selectedIncidentType = '';
  String _searchIncidentType = '';

  File? selectedImage;

  // selectedData
  Map<String, dynamic> selectedData = {};

  // Searcehed data list
  final List<Map<String, dynamic>> _searchedData = [];

  // Selected incident types

  @override
  void initState() {
    super.initState();

    _selectedIncidentType = _incidentTypes.first;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _saerch(search_type) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$backendUrl/search'),
    );

    if (search_type == "image") {
      if (selectedImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'image',
          selectedImage!.path,
        ));
      }
    }

    if (search_type == "date") {
      if (_date_start != null) {
        request.fields['date_start'] =
            DateFormat('yyyy-MM-dd').format(_date_start!);
      }

      if (_date_end != null) {
        request.fields['date_end'] =
            DateFormat('yyyy-MM-dd').format(_date_end!);
      }

      if (_selectedIncidentType.isNotEmpty) {
        request.fields['incident_type'] = _selectedIncidentType;
      }
    }

    if (search_type == "case_id") {
      if (_caseId.text.isNotEmpty) {
        request.fields['case_id'] = _caseId.text;
      }
    }

    if (search_type == "text") {
      if (_search_text.text.isNotEmpty) {
        request.fields['search_text'] = _search_text.text;
      }
    }

    if (search_type == "incident_type") {
      if (_searchIncidentType.isNotEmpty) {
        request.fields['incident_type'] = _searchIncidentType;
      }
    }

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();

      final List<dynamic> decodedData =
          json.decode(responseBody) as List<dynamic>;
      final List<Map<String, dynamic>> data =
          decodedData.map((item) => item as Map<String, dynamic>).toList();

      setState(() {
        _searchedData.clear();
        _searchedData.addAll(data);
        if (_searchedData.isNotEmpty) {
          selectedData = _searchedData[0];
        } else {
          selectedData = {};
        }
      });
    } else {
      final responseBody = await response.stream.bytesToString();
      final Map<String, dynamic> body =
          json.decode(responseBody) as Map<String, dynamic>;
      final List<String> errors =
          body.entries.map((entry) => '${entry.value}').toList();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to search by image: ${errors.join(', ')}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Future<void> pickImage() async {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          selectedImage = File(image.path);
        });
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/full_color.png',
              width: width,
              height: height,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
              ),
              width: width,
              height: height,
            ),
            SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    "Search",
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 255, 217, 102),
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.8),
                          offset: const Offset(2, 2),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            pickImage();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white),
                          child: const Text('Upload Photo',
                              style: TextStyle(color: Colors.black)),
                        ),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            _saerch('image');
                          },
                          child: const Text('Search'),
                        ),
                      ),
                      const SizedBox(width: 50),
                      SizedBox(
                        width: 200,
                        height: 40,
                        child: TextFormField(
                          controller: _search_text,
                          decoration: const InputDecoration(
                            hintText: 'Search by text',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10.0),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            // Implement file picker logic here
                            _saerch('text');
                          },
                          child: const Text('Search'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 400,
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Search by date:",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Show Date From and Date To. Format is 2024-09-14 23:34:00
                            _buildRow(
                              label: 'Date From:',
                              child: TextFormField(
                                controller: TextEditingController(
                                  text: _date_start != null
                                      ? DateFormat('yyyy-MM-dd')
                                          .format(_date_start!)
                                      : '',
                                ),
                                onTap: () async {
                                  final DateTime? date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                  );

                                  if (date != null) {
                                    setState(() {
                                      _date_start = date;
                                    });
                                  }
                                },
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10.0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            _buildRow(
                              label: 'Date To:',
                              child: TextFormField(
                                controller: TextEditingController(
                                  text: _date_end != null
                                      ? DateFormat('yyyy-MM-dd')
                                          .format(_date_end!)
                                      : '',
                                ),
                                onTap: () async {
                                  final DateTime? date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                  );

                                  if (date != null) {
                                    setState(() {
                                      _date_end = date;
                                    });
                                  }
                                },
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10.0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Dropdown for incident types
                            _buildRow(
                              label: 'Incident Type:',
                              child: DropdownButton<String>(
                                value: _selectedIncidentType,
                                items: _incidentTypes
                                    .map((type) => DropdownMenuItem(
                                          value: type,
                                          child: Text(type),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedIncidentType = value!;
                                  });
                                },
                                dropdownColor: Colors.white,
                              ),
                            ),
                            // Search button
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _saerch('date');
                                      },
                                      child: const Text('Search'),
                                    ),
                                  ),
                                ]),

                            const SizedBox(height: 50),

                            // Search by case id
                            _buildRow(
                              label: 'Search Case ID #:',
                              child: TextFormField(
                                controller: _caseId,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10.0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Search button
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // Implement file picker logic here
                                        _saerch('case_id');
                                      },
                                      child: const Text('Search'),
                                    ),
                                  ),
                                ]),
                          ],
                        ),
                      ),
                      const SizedBox(width: 40),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Left Button, Image, Right button
                            SizedBox(
                              width: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Implement file picker logic here
                                  // Find current index of selectedData
                                  final int index = _searchedData.indexWhere(
                                      (data) => data == selectedData);

                                  if (index != -1) {
                                    setState(() {
                                      if (index - 1 >= 0) {
                                        selectedData = _searchedData[index - 1];
                                      } else {
                                        selectedData = _searchedData.last;
                                      }
                                    });
                                  }
                                },
                                child: const Text('<'),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Container(
                              width: 400,
                              height: 400,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                              child: selectedData["thumbnail"] != null
                                  ? Image.network(
                                      '$backendAssetUrl/images/${selectedData["thumbnail"]}',
                                      width: 400,
                                      height: 400,
                                      fit: BoxFit.cover,
                                    )
                                  : const SizedBox(
                                      width: 400,
                                      height: 400,
                                      child: Icon(
                                        Icons.image,
                                        size: 100,
                                        color: Colors.grey,
                                      ),
                                    ),
                            ),
                            const SizedBox(width: 20),
                            SizedBox(
                              width: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Implement file picker logic here
                                  // Find current index of selectedData
                                  final int index = _searchedData.indexWhere(
                                      (data) => data == selectedData);

                                  if (index != -1) {
                                    setState(() {
                                      if (index + 1 < _searchedData.length) {
                                        selectedData = _searchedData[index + 1];
                                      } else {
                                        selectedData = _searchedData[0];
                                      }
                                    });
                                  }
                                },
                                child: const Text('>'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 50),
                      SizedBox(
                        width: 400,
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Search by Incident Type:",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Show buttons for each incident type
                            Wrap(
                              spacing: 10,
                              children: _incidentTypes
                                  .map((type) => Column(children: [
                                        ElevatedButton(
                                          // If _searchIncidentType is equal to type, change background color
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                _searchIncidentType == type
                                                    ? const Color(0xFFAB520C)
                                                    : Colors.white,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _searchIncidentType = type;
                                            });

                                            _saerch('incident_type');
                                          },
                                          child: Text(type,
                                              style: const TextStyle(
                                                  color: Colors.black)),
                                        ),
                                        const SizedBox(height: 10),
                                      ]))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  // Show search results as Table
                  if (_searchedData.isNotEmpty)
                    Column(
                      children: [
                        Table(
                          children: [
                            const TableRow(
                              children: [
                                // Date
                                TableCell(
                                  child: Center(
                                    child: Text(
                                      'Date',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                // Time
                                TableCell(
                                  child: Center(
                                    child: Text(
                                      'Time',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                // Org
                                TableCell(
                                  child: Center(
                                    child: Text(
                                      'Org',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Text(
                                      'Sub Org',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Text(
                                      'Name',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Text(
                                      'Comds',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Text(
                                      'Watch List',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Text(
                                      'Breif/Description',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Text(
                                      'Photo',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Text(
                                      'Area',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Text(
                                      'Type of Inc',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Text(
                                      'Cas',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Text(
                                      'Martyred',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Text(
                                      'Inj',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Text(
                                      'Killed',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Text(
                                      'Case ID',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Text(
                                      'Lat, Long',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Text(
                                      'Low Down',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ..._searchedData
                                .map((data) => TableRow(
                                      children: [
                                        TableCell(
                                          child: Center(
                                            child: Text(
                                              DateFormat('yyyy-MM-dd').format(
                                                  DateTime.parse(data['date'])),
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Center(
                                            child: Text(
                                              DateFormat('HH:mm').format(
                                                DateTime(
                                                  0,
                                                  0,
                                                  0,
                                                  parseTimeOfDay(data['time'])
                                                      .hour,
                                                  parseTimeOfDay(data['time'])
                                                      .minute,
                                                ),
                                              ),
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Center(
                                            child: Text(
                                              data['organization'],
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Center(
                                            child: Text(
                                              data['sub_organization'],
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Center(
                                            child: Text(
                                              data['name'],
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Center(
                                            child: Text(
                                              data['comds'],
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Center(
                                            child: Text(
                                              data['watch_list'],
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Center(
                                            child: Text(
                                              data['brief_description'],
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Center(
                                              child: data['thumbnail'] != null
                                                  ? Image.network(
                                                      '$backendAssetUrl/images/${data['thumbnail']}',
                                                      width: 60,
                                                      height: 60,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : const SizedBox(
                                                      width: 60,
                                                      height: 60,
                                                      child: Icon(
                                                        Icons.image,
                                                        size: 60,
                                                        color: Colors.grey,
                                                      ),
                                                    )),
                                        ),
                                        TableCell(
                                          child: Center(
                                            child: Text(
                                              data['area'],
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                            // child:  Text(
                                            //   data['incident_types'].join('\n'),
                                            //   style: const TextStyle(
                                            //     color: Colors.black,
                                            //   ),
                                            // ),
                                            child: Column(children: [
                                          for (final type
                                              in data['incident_types'])
                                            Text(
                                              type,
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                        ])),
                                        TableCell(
                                          child: Center(
                                            child: Text(
                                              data['cas'],
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Center(
                                            child: Text(
                                              data['martyped'],
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Center(
                                            child: Text(
                                              data['injured'],
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Center(
                                            child: Text(
                                              data['killed'],
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Center(
                                            child: Text(
                                              data['case_id'],
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Center(
                                            child: Text(
                                              '${data['latitude']} ${data['longitude']}',
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Center(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.pushNamed(context,
                                                    viewLowDownScreenRoute,
                                                    arguments: data['_id']);
                                              },
                                              child: const Text('Low Down'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ))
                                .toList(),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            )),
            Positioned(
                top: 20,
                right: 20,
                // child: Main Menu Button "Menu"
                child: SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, mainScreenRoute);
                    },
                    child: const Text('Menu'),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildRow({required String label, required Widget child}) {
    return Row(
      children: [
        SizedBox(
          width: 150,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        Expanded(child: child),
      ],
    );
  }
}
