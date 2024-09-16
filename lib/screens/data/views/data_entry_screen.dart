import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:my_windows_app/constants.dart';
import 'package:my_windows_app/route/route_constants.dart';

class DataEntryScreen extends StatefulWidget {
  const DataEntryScreen({super.key});

  @override
  DataEntryScreenState createState() => DataEntryScreenState();
}

class DataEntryScreenState extends State<DataEntryScreen> {
  final _formKey = GlobalKey<FormState>();

  DateTime? _date;
  TimeOfDay? _time;
  String _casValue = 'Own';
  String _watchListValue = 'Yes';
  // String _subOrganization = '';
  // String _name = '';
  // String _comds = '';
  // String _briefDescription = '';
  // String _area = '';
  // String _martyped = '';
  // String _injured = '';
  // String _killed = '';
  // String _latitute = '';
  // String _longitude = '';
  // String _caseId = '';
  File? thumbnail;

  TextEditingController _organization = TextEditingController();
  TextEditingController _subOrganization = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _comds = TextEditingController();
  TextEditingController _briefDescription = TextEditingController();
  TextEditingController _area = TextEditingController();
  TextEditingController _martyped = TextEditingController();
  TextEditingController _injured = TextEditingController();
  TextEditingController _killed = TextEditingController();
  TextEditingController _latitute = TextEditingController();
  TextEditingController _longitude = TextEditingController();
  TextEditingController _caseId = TextEditingController();

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

  // Selected incident types
  final List<String> _selectedIncidentTypes = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _saveData() async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$backendUrl/entry'),
    );

    request.fields['date'] = _date.toString();
    request.fields['time'] = _time.toString();
    request.fields['organization'] = _organization.text;
    request.fields['sub_organization'] = _subOrganization.text;
    request.fields['name'] = _name.text;
    request.fields['comds'] = _comds.text;
    request.fields['brief_description'] = _briefDescription.text;
    request.fields['area'] = _area.text;
    request.fields['cas'] = _casValue;
    request.fields['martyped'] = _martyped.text;
    request.fields['injured'] = _injured.text;
    request.fields['killed'] = _killed.text;
    request.fields['latitute'] = _latitute.text;
    request.fields['longitude'] = _longitude.text;
    request.fields['case_id'] = _caseId.text;
    request.fields['watch_list'] = _watchListValue;
    request.fields['incident_types'] = jsonEncode(_selectedIncidentTypes);

    if (thumbnail != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'thumbnail',
        thumbnail!.path,
      ));
    }

    final response = await request.send();

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data saved successfully'),
          backgroundColor: Colors.green,
        ),
      );

      // Clear all the fields
      setState(() {
        _date = null;
        _time = null;
        _watchListValue = 'Yes';
        _selectedIncidentTypes.clear();
        thumbnail = null;
      });

      _organization.clear();
      _subOrganization.clear();
      _name.clear();
      _comds.clear();
      _briefDescription.clear();
      _area.clear();
      _martyped.clear();
      _injured.clear();
      _killed.clear();
      _latitute.clear();
      _longitude.clear();
      _caseId.clear();
    } else {
      final responseBody = await response.stream.bytesToString();
      final Map<String, dynamic> body =
          json.decode(responseBody) as Map<String, dynamic>;
      final List<String> errors =
          body.entries.map((entry) => '${entry.value}').toList();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add product: ${errors.join(', ')}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double textWidth = 200;

    Future<void> pickImage() async {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          thumbnail = File(image.path);
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
                    "Data Entry",
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
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            _buildRow(
                              label: 'Date:',
                              child: TextFormField(
                                readOnly: true,
                                controller: TextEditingController(
                                  text: _date != null
                                      ? DateFormat('yyyy-MM-dd').format(_date!)
                                      : '',
                                ),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10.0),
                                ),
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                  );
                                  if (pickedDate != null) {
                                    setState(() {
                                      _date = pickedDate;
                                    });
                                  }
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                            _buildRow(
                              label: 'Time:',
                              child: TextFormField(
                                readOnly: true,
                                controller: TextEditingController(
                                  text: _time != null
                                      ? _time!.format(context)
                                      : '',
                                ),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10.0),
                                ),
                                onTap: () async {
                                  TimeOfDay? pickedTime = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if (pickedTime != null) {
                                    setState(() {
                                      _time = pickedTime;
                                    });
                                  }
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                            _buildRow(
                              label: 'Organization:',
                              child: TextFormField(
                                controller: _organization,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10.0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            _buildRow(
                              label: 'Sub Organization:',
                              child: TextFormField(
                                controller: _subOrganization,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10.0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            _buildRow(
                              label: 'Name:',
                              child: TextFormField(
                                controller: _name,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10.0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            _buildRow(
                              label: 'Comds:',
                              child: TextFormField(
                                controller: _comds,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10.0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            _buildRow(
                              label: 'Brief/Description:',
                              child: TextFormField(
                                controller: _briefDescription,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10.0),
                                ),
                              ),
                            ),
                            const SizedBox(
                                height: 10), // Show the selected image
                            _buildRow(
                              label: 'Upload Photo:',
                              child: ElevatedButton(
                                onPressed: pickImage,
                                child: const Text('Select File'),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                SizedBox(
                                  width: textWidth,
                                ),
                                if (thumbnail != null) ...[
                                  Image.file(
                                    thumbnail!,
                                    height: 100,
                                  ),
                                  const SizedBox(height: 8),
                                ],
                                const SizedBox(
                                  width: 20,
                                ),
                                // Show select image name
                                if (thumbnail != null) ...[
                                  Text(
                                    'Selected: ${path.basename(thumbnail!.path)}',
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ],
                            ),

                            const SizedBox(height: 30),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Type of Incidents',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            GridView.builder(
                              shrinkWrap: true,
                              itemCount: _incidentTypes.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 1,
                                mainAxisSpacing: 1,
                                mainAxisExtent: 30,
                              ),
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Checkbox(
                                        value: _selectedIncidentTypes
                                            .contains(_incidentTypes[index]),
                                        onChanged: (value) {
                                          if (value != null) {
                                            setState(() {
                                              if (value) {
                                                _selectedIncidentTypes
                                                    .add(_incidentTypes[index]);
                                              } else {
                                                _selectedIncidentTypes.remove(
                                                    _incidentTypes[index]);
                                              }
                                            });
                                          }
                                        },
                                        activeColor: Colors.black,
                                        checkColor: Colors.white,
                                        // Color of border
                                        side: const BorderSide(
                                            color: Colors.black)),
                                    Text(_incidentTypes[index],
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black)),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 50),
                      Expanded(
                        child: Column(
                          children: [
                            _buildRow(
                              label: 'Area:',
                              child: TextFormField(
                                controller: _area,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10.0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            _buildRow(
                              label: 'Cas:',
                              child: DropdownButton<String>(
                                value: _casValue,
                                items:
                                    <String>['Own', 'TS'].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  if (value != null) {
                                    setState(() {
                                      _casValue = value;
                                    });
                                  }
                                },
                                dropdownColor: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            _buildRow(
                              label: 'Martyped:',
                              child: TextFormField(
                                controller: _martyped,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10.0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            _buildRow(
                              label: 'Injured:',
                              child: TextFormField(
                                controller: _injured,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10.0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            _buildRow(
                              label: 'Killed:',
                              child: TextFormField(
                                controller: _killed,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10.0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            _buildRow(
                              label: 'Latitute:',
                              child: TextFormField(
                                controller: _latitute,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10.0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            _buildRow(
                              label: 'Longitude:',
                              child: TextFormField(
                                controller: _longitude,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10.0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            _buildRow(
                              label: 'Give Case ID #:',
                              child: TextFormField(
                                controller: _caseId,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10.0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            _buildRow(
                              label: 'Watch List:',
                              child: DropdownButton<String>(
                                value: _watchListValue,
                                items:
                                    <String>['Yes', 'No'].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  if (value != null) {
                                    setState(() {
                                      _watchListValue = value;
                                    });
                                  }
                                },
                                dropdownColor: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 50),
                            SizedBox(
                                width: 400,
                                child: Column(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        // Implement file picker logic here
                                      },
                                      child: const Text('Import GOE .kmz'),
                                    ),
                                    const SizedBox(height: 10),
                                    ElevatedButton(
                                      onPressed: () {
                                        // Implement file picker logic here
                                      },
                                      child: const Text('Explore Google Earth'),
                                    ),
                                    const SizedBox(height: 10),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, mainScreenRoute);
                                      },
                                      child: const Text('Low Down'),
                                    ),
                                    const SizedBox(height: 10),
                                    ElevatedButton(
                                      onPressed: () {
                                        _saveData();
                                      },
                                      child: const Text('Save Data'),
                                    ),
                                  ],
                                )),
                          ],
                        ),
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
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRow({required String label, required Widget child}) {
    return Row(
      children: [
        SizedBox(
          width: 200,
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
