import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:my_windows_app/constants.dart';
import 'package:my_windows_app/route/route_constants.dart';

class AddLowDownScreen extends StatefulWidget {
  final String? dataEntryId;

  const AddLowDownScreen({this.dataEntryId, super.key});

  @override
  AddLowDownScreenState createState() => AddLowDownScreenState();
}

class AddLowDownScreenState extends State<AddLowDownScreen> {
  File? thumbnail;

  String? dataEntryId = '';

  // Name, Alias, Father Name, Mother Name, Religion, Sect/Sub Sect, Caste, SUb Caste, Nationality, CNIC, Date of Birth, Age, Civ Edn, Complexion, Contact Nos
  TextEditingController _name = TextEditingController();
  TextEditingController _alias = TextEditingController();
  TextEditingController _fatherName = TextEditingController();
  TextEditingController _motherName = TextEditingController();
  TextEditingController _religion = TextEditingController();
  TextEditingController _sectSubSect = TextEditingController();
  TextEditingController _caste = TextEditingController();
  TextEditingController _subCaste = TextEditingController();
  TextEditingController _nationality = TextEditingController();
  TextEditingController _cnic = TextEditingController();
  TextEditingController _dob = TextEditingController();
  TextEditingController _age = TextEditingController();
  TextEditingController _civEdn = TextEditingController();
  TextEditingController _complexion = TextEditingController();
  TextEditingController _contactNos = TextEditingController();

  // Social Media Details
  TextEditingController _facebook = TextEditingController();
  TextEditingController _twitter = TextEditingController();
  TextEditingController _tikTok = TextEditingController();
  TextEditingController _email = TextEditingController();

  // Text Inputs: Passport No, Bank Acct Details, Languages, Temp Address, Perm Address, Detail of Visit foregin countries, Areas of Influence, Active Since, Likely Loc, Tier, Affl with Ts Gp
  TextEditingController _passportNo = TextEditingController();
  TextEditingController _bankAcctDetails = TextEditingController();
  TextEditingController _languages = TextEditingController();
  TextEditingController _tempAddress = TextEditingController();
  TextEditingController _permAddress = TextEditingController();
  TextEditingController _detailOfVisitForeginCountries =
      TextEditingController();
  TextEditingController _areasOfInfluence = TextEditingController();
  TextEditingController _activeSince = TextEditingController();
  TextEditingController _likelyLoc = TextEditingController();
  TextEditingController _tier = TextEditingController();
  TextEditingController _afflWithTsGp = TextEditingController();

  // Text Inputs: Political Affl, Religious Affl, Occupation, Mother Name, Suurce of Income, Property Details, Marital Status, Detail of Children
  TextEditingController _politicalAffl = TextEditingController();
  TextEditingController _religiousAffl = TextEditingController();
  TextEditingController _occupation = TextEditingController();
  TextEditingController _sourceOfIncome = TextEditingController();
  TextEditingController _propertyDetails = TextEditingController();
  TextEditingController _maritalStatus = TextEditingController();
  TextEditingController _detailOfChildren = TextEditingController();

  // Label Family Detail (Own) i.2 Name, Relation, Age, Profession, Address
  TextEditingController _brothers = TextEditingController();
  TextEditingController _sisters = TextEditingController();
  TextEditingController _uncles = TextEditingController();
  TextEditingController _aunts = TextEditingController();
  TextEditingController _cousins = TextEditingController();

  // Label: In Laws Detail (i.2 Name, Relation, Age, Profession, Address)
  TextEditingController _fatherInLaw = TextEditingController();
  TextEditingController _motherInLaw = TextEditingController();
  TextEditingController _brotherInLaw = TextEditingController();
  TextEditingController _sisterInLaw = TextEditingController();

  // Text Inputs: Criminal Activities, Extortion Activities, Attitude towards Govt, Attitude towards State, Attitude towards SFs, Gen Habbits, Reputation among locals, FIR Status
  TextEditingController _criminalActivities = TextEditingController();
  TextEditingController _extortionActivities = TextEditingController();
  TextEditingController _attitudeTowardsGovt = TextEditingController();
  TextEditingController _attitudeTowardsState = TextEditingController();
  TextEditingController _attitudeTowardsSFs = TextEditingController();
  TextEditingController _genHabbits = TextEditingController();
  TextEditingController _reputationAmongLocals = TextEditingController();
  TextEditingController _firStatus = TextEditingController();

  // Gen Remarks
  TextEditingController _genRemarks = TextEditingController();

  @override
  void initState() {
    super.initState();

    dataEntryId = widget.dataEntryId;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _saveData() async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$backendUrl/low'),
    );

    request.fields['entry_id'] = dataEntryId!;

    request.fields['name'] = _name.text;
    request.fields['alias'] = _alias.text;
    request.fields['father_name'] = _fatherName.text;
    request.fields['mother_name'] = _motherName.text;
    request.fields['religion'] = _religion.text;
    request.fields['sect_sub_sect'] = _sectSubSect.text;
    request.fields['caste'] = _caste.text;
    request.fields['sub_caste'] = _subCaste.text;
    request.fields['nationality'] = _nationality.text;
    request.fields['cnic'] = _cnic.text;
    request.fields['dob'] = _dob.text;
    request.fields['age'] = _age.text;
    request.fields['civ_edn'] = _civEdn.text;
    request.fields['complexion'] = _complexion.text;
    request.fields['contact_nos'] = _contactNos.text;

    request.fields['facebook'] = _facebook.text;
    request.fields['twitter'] = _twitter.text;
    request.fields['tiktok'] = _tikTok.text;
    request.fields['email'] = _email.text;

    request.fields['passport_no'] = _passportNo.text;
    request.fields['bank_acct_details'] = _bankAcctDetails.text;
    request.fields['languages'] = _languages.text;
    request.fields['temp_address'] = _tempAddress.text;
    request.fields['perm_address'] = _permAddress.text;
    request.fields['detail_of_visit_foregin_countries'] =
        _detailOfVisitForeginCountries.text;
    request.fields['areas_of_influence'] = _areasOfInfluence.text;
    request.fields['active_since'] = _activeSince.text;
    request.fields['likely_loc'] = _likelyLoc.text;
    request.fields['tier'] = _tier.text;
    request.fields['affl_with_ts_gp'] = _afflWithTsGp.text;

    request.fields['political_affl'] = _politicalAffl.text;
    request.fields['religious_affl'] = _religiousAffl.text;
    request.fields['occupation'] = _occupation.text;
    request.fields['source_of_income'] = _sourceOfIncome.text;
    request.fields['property_details'] = _propertyDetails.text;
    request.fields['marital_status'] = _maritalStatus.text;
    request.fields['detail_of_children'] = _detailOfChildren.text;

    request.fields['brothers'] = _brothers.text;
    request.fields['sisters'] = _sisters.text;
    request.fields['uncles'] = _uncles.text;
    request.fields['aunts'] = _aunts.text;
    request.fields['cousins'] = _cousins.text;

    request.fields['father_in_law'] = _fatherInLaw.text;
    request.fields['mother_in_law'] = _motherInLaw.text;
    request.fields['brother_in_law'] = _brotherInLaw.text;
    request.fields['sister_in_law'] = _sisterInLaw.text;

    request.fields['criminal_activities'] = _criminalActivities.text;
    request.fields['extortion_activities'] = _extortionActivities.text;
    request.fields['attitude_towards_govt'] = _attitudeTowardsGovt.text;
    request.fields['attitude_towards_state'] = _attitudeTowardsState.text;
    request.fields['attitude_towards_sfs'] = _attitudeTowardsSFs.text;
    request.fields['gen_habbits'] = _genHabbits.text;
    request.fields['reputation_among_locals'] = _reputationAmongLocals.text;
    request.fields['fir_status'] = _firStatus.text;

    request.fields['gen_remarks'] = _genRemarks.text;

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
          content: Text('Low Down data saved successfully'),
          backgroundColor: Colors.green,
        ),
      );

      // Clear all the fields
      setState(() {
        thumbnail = null;
      });

      _name.clear();
      _alias.clear();
      _fatherName.clear();
      _motherName.clear();
      _religion.clear();
      _sectSubSect.clear();
      _caste.clear();
      _subCaste.clear();
      _nationality.clear();
      _cnic.clear();
      _dob.clear();
      _age.clear();
      _civEdn.clear();
      _complexion.clear();
      _contactNos.clear();

      _facebook.clear();
      _twitter.clear();
      _tikTok.clear();
      _email.clear();

      _passportNo.clear();
      _bankAcctDetails.clear();
      _languages.clear();
      _tempAddress.clear();
      _permAddress.clear();
      _detailOfVisitForeginCountries.clear();
      _areasOfInfluence.clear();
      _activeSince.clear();
      _likelyLoc.clear();
      _tier.clear();
      _afflWithTsGp.clear();

      _politicalAffl.clear();
      _religiousAffl.clear();
      _occupation.clear();
      _sourceOfIncome.clear();
      _propertyDetails.clear();
      _maritalStatus.clear();
      _detailOfChildren.clear();

      _brothers.clear();
      _sisters.clear();
      _uncles.clear();
      _aunts.clear();
      _cousins.clear();

      _fatherInLaw.clear();
      _motherInLaw.clear();
      _brotherInLaw.clear();
      _sisterInLaw.clear();

      _criminalActivities.clear();
      _extortionActivities.clear();
      _attitudeTowardsGovt.clear();

      _attitudeTowardsState.clear();
      _attitudeTowardsSFs.clear();
      _genHabbits.clear();
      _reputationAmongLocals.clear();
      _firStatus.clear();

      _genRemarks.clear();
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
                    "Low Down",
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
                            // Text Inputs : Name, Alias, Father Name, Mother Name, Religion, Sect/Sub Sect, Caste, SUb Caste, Nationality, CNIC, Date of Birth, Age, Civ Edn, Complexion, Contact Nos

                            _buildTextInputRow(
                              label: 'Name:',
                              controller: _name,
                            ),
                            const SizedBox(height: 10),
                            _buildTextInputRow(
                              label: 'Alias:',
                              controller: _alias,
                            ),
                            const SizedBox(height: 10),
                            _buildTextInputRow(
                              label: 'Father Name:',
                              controller: _fatherName,
                            ),
                            const SizedBox(height: 10),
                            _buildTextInputRow(
                              label: 'Mother Name:',
                              controller: _motherName,
                            ),
                            const SizedBox(height: 10),
                            _buildTextInputRow(
                              label: 'Religion:',
                              controller: _religion,
                            ),
                            const SizedBox(height: 10),
                            _buildTextInputRow(
                              label: 'Sect/Sub Sect:',
                              controller: _sectSubSect,
                            ),
                            const SizedBox(height: 10),
                            _buildTextInputRow(
                              label: 'Caste:',
                              controller: _caste,
                            ),
                            const SizedBox(height: 10),
                            _buildTextInputRow(
                              label: 'Sub Caste:',
                              controller: _subCaste,
                            ),
                            const SizedBox(height: 10),
                            _buildTextInputRow(
                              label: 'Nationality:',
                              controller: _nationality,
                            ),
                            const SizedBox(height: 10),
                            _buildTextInputRow(
                              label: 'CNIC:',
                              controller: _cnic,
                            ),
                            const SizedBox(height: 10),
                            _buildTextInputRow(
                              label: 'Date of Birth:',
                              controller: _dob,
                            ),
                            const SizedBox(height: 10),
                            _buildTextInputRow(
                              label: 'Age:',
                              controller: _age,
                            ),
                            const SizedBox(height: 10),
                            _buildTextInputRow(
                              label: 'Civ Edn:',
                              controller: _civEdn,
                            ),
                            const SizedBox(height: 10),
                            _buildTextInputRow(
                              label: 'Complexion:',
                              controller: _complexion,
                            ),
                            const SizedBox(height: 10),
                            _buildTextInputRow(
                              label: 'Contact Nos:',
                              controller: _contactNos,
                            ),

                            const SizedBox(height: 10),

                            // Border for the Social Media Details
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  // Title: Social Media Details
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Social Media Details',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  // Text Inputs: Facebook, Twitter, TikTok,Email
                                  _buildTextInputRow(
                                    label: 'Facebook:',
                                    controller: _facebook,
                                  ),
                                  const SizedBox(height: 10),
                                  _buildTextInputRow(
                                    label: 'Twitter:',
                                    controller: _twitter,
                                  ),
                                  const SizedBox(height: 10),
                                  _buildTextInputRow(
                                    label: 'TikTok:',
                                    controller: _tikTok,
                                  ),
                                  const SizedBox(height: 10),
                                  _buildTextInputRow(
                                    label: 'Email:',
                                    controller: _email,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),

                            // Text Inputs: Passport No, Bank Acct Details, Languages, Temp Address, Perm Address, Detail of Visit foregin countries, Areas of Influence, Active Since, Likely Loc, Tier, Affl with Ts Gp
                            _buildTextInputRow(
                              label: 'Passport No:',
                              controller: _passportNo,
                            ),
                            const SizedBox(height: 10),
                            _buildTextInputRow(
                              label: 'Bank Acct Details:',
                              controller: _bankAcctDetails,
                            ),
                            const SizedBox(height: 10),
                            _buildTextInputRow(
                              label: 'Languages:',
                              controller: _languages,
                            ),
                            const SizedBox(height: 10),
                            _buildTextInputRow(
                              label: 'Temp Address:',
                              controller: _tempAddress,
                            ),
                            const SizedBox(height: 10),
                            _buildTextInputRow(
                              label: 'Perm Address:',
                              controller: _permAddress,
                            ),
                            const SizedBox(height: 10),
                            _buildTextInputRow(
                              label: 'Detail of Visit foregin countries:',
                              controller: _detailOfVisitForeginCountries,
                            ),
                            const SizedBox(height: 10),
                            _buildTextInputRow(
                              label: 'Areas of Influence:',
                              controller: _areasOfInfluence,
                            ),
                            const SizedBox(height: 10),
                            _buildTextInputRow(
                              label: 'Active Since:',
                              controller: _activeSince,
                            ),
                            const SizedBox(height: 10),
                            _buildTextInputRow(
                              label: 'Likely Loc:',
                              controller: _likelyLoc,
                            ),
                            const SizedBox(height: 10),
                            _buildTextInputRow(
                              label: 'Tier:',
                              controller: _tier,
                            ),
                            const SizedBox(height: 10),
                            _buildTextInputRow(
                              label: 'Affl with Ts Gp:',
                              controller: _afflWithTsGp,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 50),
                      SizedBox(
                          width: 300,
                          child: Column(
                            children: [
                              // Thumbnail
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    // Title: Thumbnail
                                    const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'TS Photo',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    // Thumbnail Image
                                    thumbnail != null
                                        ? Image.file(
                                            thumbnail!,
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          )
                                        : const SizedBox(
                                            width: 200,
                                            height: 200,
                                            child: Icon(
                                              Icons.image,
                                              size: 100,
                                              color: Colors.grey,
                                            ),
                                          ),
                                    const SizedBox(height: 10),
                                    // Pick Image Button
                                    ElevatedButton(
                                      onPressed: pickImage,
                                      child: const Text('Pick Image'),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 50),
                              ElevatedButton(
                                onPressed: () {
                                  _saveData();
                                },
                                child: const Text('Save Data'),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  // Implement file picker logic here
                                },
                                child: const Text('Export as DOC'),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, mainScreenRoute);
                                },
                                child: const Text('Export as PDF'),
                              ),
                            ],
                          )),
                      const SizedBox(width: 50),
                      Expanded(
                        child: Column(
                          children: [
                            // Text inputs : Political Affl, Religious Affl, Occupation, Mother Name, Suurce of Income, Property Details, Marital Status, Detail of Children
                            _buildTextInputRow(
                              label: 'Political Affl:',
                              controller: _politicalAffl,
                            ),
                            const SizedBox(height: 10),
                            _buildTextInputRow(
                              label: 'Religious Affl:',
                              controller: _religiousAffl,
                            ),
                            const SizedBox(height: 10),
                            _buildTextInputRow(
                              label: 'Occupation:',
                              controller: _occupation,
                            ),
                            const SizedBox(height: 10),
                            _buildTextInputRow(
                              label: 'Mother Name:',
                              controller: _motherName,
                            ),
                            const SizedBox(height: 10),
                            _buildTextInputRow(
                              label: 'Source of Income:',
                              controller: _sourceOfIncome,
                            ),
                            const SizedBox(height: 10),
                            _buildTextInputRow(
                              label: 'Property Details:',
                              controller: _propertyDetails,
                            ),
                            const SizedBox(height: 10),
                            _buildTextInputRow(
                              label: 'Marital Status:',
                              controller: _maritalStatus,
                            ),
                            const SizedBox(height: 10),
                            _buildTextInputRow(
                              label: 'Detail of Children:',
                              controller: _detailOfChildren,
                            ),
                            const SizedBox(height: 10),
                            // Label Family Detail (Own) i.2 Name, Relation, Age, Profession, Address in border
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  // Title: Family Detail (Own)
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Label Family Detail (Own) i.2 Name, Relation, Age, Profession, Address',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  // Text Inputs: Brothers, Sisters, Uncles, Aunts, Cousins
                                  _buildTextInputRow(
                                    label: 'Brothers:',
                                    controller: _brothers,
                                  ),
                                  const SizedBox(height: 10),
                                  _buildTextInputRow(
                                    label: 'Sisters:',
                                    controller: _sisters,
                                  ),
                                  const SizedBox(height: 10),
                                  _buildTextInputRow(
                                    label: 'Uncles:',
                                    controller: _uncles,
                                  ),
                                  const SizedBox(height: 10),
                                  _buildTextInputRow(
                                    label: 'Aunts:',
                                    controller: _aunts,
                                  ),
                                  const SizedBox(height: 10),
                                  _buildTextInputRow(
                                    label: 'Cousins:',
                                    controller: _cousins,
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 10),
                            // Label: In Laws Detail (i.2 Name, Relation, Age, Profession, Address) in border
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  // Title: In Laws Detail (i.2 Name, Relation, Age, Profession, Address)
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'In Laws Detail (i.2 Name, Relation, Age, Profession, Address)',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  // Text Inputs: Father in Law, Mother in Law, Brother in Law, Sister in Law
                                  _buildTextInputRow(
                                    label: 'Father in Law:',
                                    controller: _fatherInLaw,
                                  ),
                                  const SizedBox(height: 10),
                                  _buildTextInputRow(
                                    label: 'Mother in Law:',
                                    controller: _motherInLaw,
                                  ),
                                  const SizedBox(height: 10),
                                  _buildTextInputRow(
                                    label: 'Brother in Law:',
                                    controller: _brotherInLaw,
                                  ),
                                  const SizedBox(height: 10),
                                  _buildTextInputRow(
                                    label: 'Sister in Law:',
                                    controller: _sisterInLaw,
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 10),
                            // Text Inputs: Criminal Activities, Extortion Activities, Attitude towards Govt, Attitude towards State, Attitude towards SFs, Gen Habbits, Reputation among locals, FIR Status
                            _buildTextInputRow(
                              label: 'Criminal Activities:',
                              controller: _criminalActivities,
                            ),
                            const SizedBox(height: 10),
                            _buildTextInputRow(
                              label: 'Extortion Activities:',
                              controller: _extortionActivities,
                            ),
                            const SizedBox(height: 10),
                            _buildTextInputRow(
                              label: 'Attitude towards Govt:',
                              controller: _attitudeTowardsGovt,
                            ),
                            const SizedBox(height: 10),
                            _buildTextInputRow(
                              label: 'Attitude towards State:',
                              controller: _attitudeTowardsState,
                            ),
                            const SizedBox(height: 10),
                            _buildTextInputRow(
                              label: 'Attitude towards SFs:',
                              controller: _attitudeTowardsSFs,
                            ),
                            const SizedBox(height: 10),
                            _buildTextInputRow(
                              label: 'Gen Habbits:',
                              controller: _genHabbits,
                            ),
                            const SizedBox(height: 10),
                            _buildTextInputRow(
                              label: 'Reputation among locals:',
                              controller: _reputationAmongLocals,
                            ),
                            const SizedBox(height: 10),
                            _buildTextInputRow(
                              label: 'FIR Status:',
                              controller: _firStatus,
                            ),

                            // Gen Remarks
                            const SizedBox(height: 10),
                            _buildTextInputRow(
                              label: 'Gen Remarks:',
                              controller: _genRemarks,
                            ),
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

  // Text Input Widget
  Widget _buildTextInputRow(
      {required String label, required TextEditingController controller}) {
    return Row(
      children: [
        SizedBox(
          width: 200,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 32,
            child: TextFormField(
              controller: controller,
              style: const TextStyle(fontSize: 15),
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
