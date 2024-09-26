import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'dart:typed_data';

// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';

import 'package:my_windows_app/constants.dart';
import 'package:my_windows_app/route/route_constants.dart';
import 'package:docx_template/docx_template.dart';
import 'package:file_picker/file_picker.dart';

class ViewLowDownScreen extends StatefulWidget {
  final String? dataEntryId;

  const ViewLowDownScreen({this.dataEntryId, super.key});

  @override
  ViewLowDownScreenState createState() => ViewLowDownScreenState();
}

class ViewLowDownScreenState extends State<ViewLowDownScreen> {
  String? thumbnail;

  // Name, Alias, Father Name, Mother Name, Religion, Sect/Sub Sect, Caste, SUb Caste, Nationality, CNIC, Date of Birth, Age, Civ Edn, Complexion, Contact Nos
  final TextEditingController _name = TextEditingController();
  final TextEditingController _alias = TextEditingController();
  final TextEditingController _fatherName = TextEditingController();
  final TextEditingController _motherName = TextEditingController();
  final TextEditingController _religion = TextEditingController();
  final TextEditingController _sectSubSect = TextEditingController();
  final TextEditingController _caste = TextEditingController();
  final TextEditingController _subCaste = TextEditingController();
  final TextEditingController _nationality = TextEditingController();
  final TextEditingController _cnic = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _civEdn = TextEditingController();
  final TextEditingController _complexion = TextEditingController();
  final TextEditingController _contactNos = TextEditingController();

  // Social Media Details
  final TextEditingController _facebook = TextEditingController();
  final TextEditingController _twitter = TextEditingController();
  final TextEditingController _tikTok = TextEditingController();
  final TextEditingController _email = TextEditingController();

  // Text Inputs: Passport No, Bank Acct Details, Languages, Temp Address, Perm Address, Detail of Visit foregin countries, Areas of Influence, Active Since, Likely Loc, Tier, Affl with Ts Gp
  final TextEditingController _passportNo = TextEditingController();
  final TextEditingController _bankAcctDetails = TextEditingController();
  final TextEditingController _languages = TextEditingController();
  final TextEditingController _tempAddress = TextEditingController();
  final TextEditingController _permAddress = TextEditingController();
  final TextEditingController _detailOfVisitForeginCountries =
      TextEditingController();
  final TextEditingController _areasOfInfluence = TextEditingController();
  final TextEditingController _activeSince = TextEditingController();
  final TextEditingController _likelyLoc = TextEditingController();
  final TextEditingController _tier = TextEditingController();
  final TextEditingController _afflWithTsGp = TextEditingController();

  // Text Inputs: Political Affl, Religious Affl, Occupation, Mother Name, Suurce of Income, Property Details, Marital Status, Detail of Children
  final TextEditingController _politicalAffl = TextEditingController();
  final TextEditingController _religiousAffl = TextEditingController();
  final TextEditingController _occupation = TextEditingController();
  final TextEditingController _sourceOfIncome = TextEditingController();
  final TextEditingController _propertyDetails = TextEditingController();
  final TextEditingController _maritalStatus = TextEditingController();
  final TextEditingController _detailOfChildren = TextEditingController();

  // Label Family Detail (Own) i.2 Name, Relation, Age, Profession, Address
  final TextEditingController _brothers = TextEditingController();
  final TextEditingController _sisters = TextEditingController();
  final TextEditingController _uncles = TextEditingController();
  final TextEditingController _aunts = TextEditingController();
  final TextEditingController _cousins = TextEditingController();

  // Label: In Laws Detail (i.2 Name, Relation, Age, Profession, Address)
  final TextEditingController _fatherInLaw = TextEditingController();
  final TextEditingController _motherInLaw = TextEditingController();
  final TextEditingController _brotherInLaw = TextEditingController();
  final TextEditingController _sisterInLaw = TextEditingController();

  // Text Inputs: Criminal Activities, Extortion Activities, Attitude towards Govt, Attitude towards State, Attitude towards SFs, Gen Habbits, Reputation among locals, FIR Status
  final TextEditingController _criminalActivities = TextEditingController();
  final TextEditingController _extortionActivities = TextEditingController();
  final TextEditingController _attitudeTowardsGovt = TextEditingController();
  final TextEditingController _attitudeTowardsState = TextEditingController();
  final TextEditingController _attitudeTowardsSFs = TextEditingController();
  final TextEditingController _genHabbits = TextEditingController();
  final TextEditingController _reputationAmongLocals = TextEditingController();
  final TextEditingController _firStatus = TextEditingController();

  // Gen Remarks
  final TextEditingController _genRemarks = TextEditingController();

  @override
  void initState() {
    super.initState();

    _fetchLowData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _fetchLowData() async {
    final response =
        await http.get(Uri.parse('$backendUrl/low/${widget.dataEntryId}'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> body =
          json.decode(response.body) as Map<String, dynamic>;

      _name.text = body['name'] as String;
      _alias.text = body['alias'] as String;
      _fatherName.text = body['father_name'] as String;
      _motherName.text = body['mother_name'] as String;
      _religion.text = body['religion'] as String;
      _sectSubSect.text = body['sect_sub_sect'] as String;
      _caste.text = body['caste'] as String;
      _subCaste.text = body['sub_caste'] as String;
      _nationality.text = body['nationality'] as String;
      _cnic.text = body['cnic'] as String;
      _dob.text = body['dob'] as String;
      _age.text = body['age'] as String;
      _civEdn.text = body['civ_edn'] as String;
      _complexion.text = body['complexion'] as String;
      _contactNos.text = body['contact_nos'] as String;

      _facebook.text = body['facebook'] as String;
      _twitter.text = body['twitter'] as String;
      _tikTok.text = body['tiktok'] as String;
      _email.text = body['email'] as String;

      _passportNo.text = body['passport_no'] as String;
      _bankAcctDetails.text = body['bank_acct_details'] as String;
      _languages.text = body['languages'] as String;
      _tempAddress.text = body['temp_address'] as String;
      _permAddress.text = body['perm_address'] as String;
      _detailOfVisitForeginCountries.text =
          body['detail_of_visit_foregin_countries'] as String;
      _areasOfInfluence.text = body['areas_of_influence'] as String;
      _activeSince.text = body['active_since'] as String;
      _likelyLoc.text = body['likely_loc'] as String;
      _tier.text = body['tier'] as String;
      _afflWithTsGp.text = body['affl_with_ts_gp'] as String;

      _politicalAffl.text = body['political_affl'] as String;
      _religiousAffl.text = body['religious_affl'] as String;
      _occupation.text = body['occupation'] as String;
      _sourceOfIncome.text = body['source_of_income'] as String;
      _propertyDetails.text = body['property_details'] as String;
      _maritalStatus.text = body['marital_status'] as String;
      _detailOfChildren.text = body['detail_of_children'] as String;

      _brothers.text = body['brothers'] as String;
      _sisters.text = body['sisters'] as String;
      _uncles.text = body['uncles'] as String;
      _aunts.text = body['aunts'] as String;
      _cousins.text = body['cousins'] as String;

      _fatherInLaw.text = body['father_in_law'] as String;
      _motherInLaw.text = body['mother_in_law'] as String;
      _brotherInLaw.text = body['brother_in_law'] as String;
      _sisterInLaw.text = body['sister_in_law'] as String;

      _criminalActivities.text = body['criminal_activities'] as String;
      _extortionActivities.text = body['extortion_activities'] as String;
      _attitudeTowardsGovt.text = body['attitude_towards_govt'] as String;
      _attitudeTowardsState.text = body['attitude_towards_state'] as String;
      _attitudeTowardsSFs.text = body['attitude_towards_sfs'] as String;
      _genHabbits.text = body['gen_habbits'] as String;
      _reputationAmongLocals.text = body['reputation_among_locals'] as String;
      _firStatus.text = body['fir_status'] as String;

      _genRemarks.text = body['gen_remarks'] as String;

      setState(() {
        if (body['thumbnail'] != null) {
          thumbnail = body['thumbnail'] as String;
        }
      });
    } else {
      final responseBody = response.body;
      print(responseBody);
      // final Map<String, dynamic> body =
      //     json.decode(responseBody) as Map<String, dynamic>;
      // final List<String> errors =
      //     body.entries.map((entry) => '${entry.value}').toList();

      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('Failed to fetch product: ${errors.join(', ')}'),
      //     backgroundColor: Colors.red,
      //   ),
      // );
    }
  }

  void _exportAsDoc() async {
    final f = File("assets/docx/template.docx");
    final docx = await DocxTemplate.fromBytes(await f.readAsBytes());

    // Update image with onlien image
    final data =
        await http.get(Uri.parse('$backendAssetUrl/images/$thumbnail'));
    final bytes = data.bodyBytes;

    Content c = Content();
    c
      ..add(TextContent("name", _name.text))
      ..add(TextContent("alias", _alias.text))
      ..add(TextContent("father_name", _fatherName.text))
      ..add(TextContent("mother_name", _motherName.text))
      ..add(TextContent("religion", _religion.text))
      ..add(TextContent("sect_sub_sect", _sectSubSect.text))
      ..add(TextContent("caste", _caste.text))
      ..add(TextContent("sub_caste", _subCaste.text))
      ..add(TextContent("nationality", _nationality.text))
      ..add(TextContent("cnic", _cnic.text))
      ..add(TextContent("dob", _dob.text))
      ..add(TextContent("age", _age.text))
      ..add(TextContent("civ_edn", _civEdn.text))
      ..add(TextContent("complexion", _complexion.text))
      ..add(TextContent("contact_nos", _contactNos.text))
      ..add(TextContent("facebook", _facebook.text))
      ..add(TextContent("twitter", _twitter.text))
      ..add(TextContent("tiktok", _tikTok.text))
      ..add(TextContent("email", _email.text))
      ..add(TextContent("passport_no", _passportNo.text))
      ..add(TextContent("bank_acct_details", _bankAcctDetails.text))
      ..add(TextContent("languages", _languages.text))
      ..add(TextContent("temp_address", _tempAddress.text))
      ..add(TextContent("perm_address", _permAddress.text))
      ..add(TextContent("detail_of_visit_foregin_countries",
          _detailOfVisitForeginCountries.text))
      ..add(TextContent("areas_of_influence", _areasOfInfluence.text))
      ..add(TextContent("active_since", _activeSince.text))
      ..add(TextContent("likely_loc", _likelyLoc.text))
      ..add(TextContent("tier", _tier.text))
      ..add(TextContent("affl_with_ts_gp", _afflWithTsGp.text))
      ..add(TextContent("political_affl", _politicalAffl.text))
      ..add(TextContent("religious_affl", _religiousAffl.text))
      ..add(TextContent("occupation", _occupation.text))
      ..add(TextContent("source_of_income", _sourceOfIncome.text))
      ..add(TextContent("property_details", _propertyDetails.text))
      ..add(TextContent("marital_status", _maritalStatus.text))
      ..add(TextContent("detail_of_children", _detailOfChildren.text))
      ..add(TextContent("brothers", _brothers.text))
      ..add(TextContent("sisters", _sisters.text))
      ..add(TextContent("uncles", _uncles.text))
      ..add(TextContent("aunts", _aunts.text))
      ..add(TextContent("cousins", _cousins.text))
      ..add(TextContent("father_in_law", _fatherInLaw.text))
      ..add(TextContent("mother_in_law", _motherInLaw.text))
      ..add(TextContent("brother_in_law", _brotherInLaw.text))
      ..add(TextContent("sister_in_law", _sisterInLaw.text))
      ..add(TextContent("criminal_activities", _criminalActivities.text))
      ..add(TextContent("extortion_activities", _extortionActivities.text))
      ..add(TextContent("attitude_towards_govt", _attitudeTowardsGovt.text))
      ..add(TextContent("attitude_towards_state", _attitudeTowardsState.text))
      ..add(TextContent("attitude_towards_sfs", _attitudeTowardsSFs.text))
      ..add(TextContent("gen_habbits", _genHabbits.text))
      ..add(TextContent("reputation_among_locals", _reputationAmongLocals.text))
      ..add(TextContent("fir_status", _firStatus.text))
      ..add(TextContent("gen_remarks", _genRemarks.text))
      ..add(ImageContent('img', bytes));

    final d = await docx.generate(c);
    // final of = File('generated.docx');

    // if (d != null) await of.writeAsBytes(d);

    if (d != null) {
      // Open file picker dialog to select the save location
      String? outputPath = await FilePicker.platform.saveFile(
        dialogTitle: 'Please select an output file:',
        fileName: 'generated.docx',
        type: FileType.custom,
        allowedExtensions: ['docx'],
      );

      if (outputPath != null) {
        final of = File(outputPath);
        await of.writeAsBytes(d);
      }
    }
  }

  void _exportAsPDF() async {
    final f = File("assets/docx/template.docx");
    final docx = await DocxTemplate.fromBytes(await f.readAsBytes());

    // Update image with onlien image
    final data =
        await http.get(Uri.parse('$backendAssetUrl/images/$thumbnail'));
    final bytes = data.bodyBytes;

    Content c = Content();
    c
      ..add(TextContent("name", _name.text))
      ..add(TextContent("alias", _alias.text))
      ..add(TextContent("father_name", _fatherName.text))
      ..add(TextContent("mother_name", _motherName.text))
      ..add(TextContent("religion", _religion.text))
      ..add(TextContent("sect_sub_sect", _sectSubSect.text))
      ..add(TextContent("caste", _caste.text))
      ..add(TextContent("sub_caste", _subCaste.text))
      ..add(TextContent("nationality", _nationality.text))
      ..add(TextContent("cnic", _cnic.text))
      ..add(TextContent("dob", _dob.text))
      ..add(TextContent("age", _age.text))
      ..add(TextContent("civ_edn", _civEdn.text))
      ..add(TextContent("complexion", _complexion.text))
      ..add(TextContent("contact_nos", _contactNos.text))
      ..add(TextContent("facebook", _facebook.text))
      ..add(TextContent("twitter", _twitter.text))
      ..add(TextContent("tiktok", _tikTok.text))
      ..add(TextContent("email", _email.text))
      ..add(TextContent("passport_no", _passportNo.text))
      ..add(TextContent("bank_acct_details", _bankAcctDetails.text))
      ..add(TextContent("languages", _languages.text))
      ..add(TextContent("temp_address", _tempAddress.text))
      ..add(TextContent("perm_address", _permAddress.text))
      ..add(TextContent("detail_of_visit_foregin_countries",
          _detailOfVisitForeginCountries.text))
      ..add(TextContent("areas_of_influence", _areasOfInfluence.text))
      ..add(TextContent("active_since", _activeSince.text))
      ..add(TextContent("likely_loc", _likelyLoc.text))
      ..add(TextContent("tier", _tier.text))
      ..add(TextContent("affl_with_ts_gp", _afflWithTsGp.text))
      ..add(TextContent("political_affl", _politicalAffl.text))
      ..add(TextContent("religious_affl", _religiousAffl.text))
      ..add(TextContent("occupation", _occupation.text))
      ..add(TextContent("source_of_income", _sourceOfIncome.text))
      ..add(TextContent("property_details", _propertyDetails.text))
      ..add(TextContent("marital_status", _maritalStatus.text))
      ..add(TextContent("detail_of_children", _detailOfChildren.text))
      ..add(TextContent("brothers", _brothers.text))
      ..add(TextContent("sisters", _sisters.text))
      ..add(TextContent("uncles", _uncles.text))
      ..add(TextContent("aunts", _aunts.text))
      ..add(TextContent("cousins", _cousins.text))
      ..add(TextContent("father_in_law", _fatherInLaw.text))
      ..add(TextContent("mother_in_law", _motherInLaw.text))
      ..add(TextContent("brother_in_law", _brotherInLaw.text))
      ..add(TextContent("sister_in_law", _sisterInLaw.text))
      ..add(TextContent("criminal_activities", _criminalActivities.text))
      ..add(TextContent("extortion_activities", _extortionActivities.text))
      ..add(TextContent("attitude_towards_govt", _attitudeTowardsGovt.text))
      ..add(TextContent("attitude_towards_state", _attitudeTowardsState.text))
      ..add(TextContent("attitude_towards_sfs", _attitudeTowardsSFs.text))
      ..add(TextContent("gen_habbits", _genHabbits.text))
      ..add(TextContent("reputation_among_locals", _reputationAmongLocals.text))
      ..add(TextContent("fir_status", _firStatus.text))
      ..add(TextContent("gen_remarks", _genRemarks.text))
      ..add(ImageContent('img', bytes));

    final d = await docx.generate(c);

    if (d != null) {
      // Send the docx data to backend to convert it to PDF

      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$backendUrl/convert/docx-to-pdf'),
      );

      request.files.add(http.MultipartFile.fromBytes(
        'docx',
        d,
        filename: 'generated.docx',
      ));

      final response = await request.send();

      if (response.statusCode == 200) {
        final pdfBytes = await response.stream.toBytes();

        // Open file picker dialog to select the save location
        String? outputPath = await FilePicker.platform.saveFile(
          dialogTitle: 'Please select an output file:',
          fileName: 'generated.pdf',
          type: FileType.custom,
          allowedExtensions: ['pdf'],
        );

        if (outputPath != null) {
          final of = File(outputPath);
          await of.writeAsBytes(pdfBytes);
        }
      } else {
        final responseBody = await response.stream.bytesToString();
        print(responseBody);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
                                        ? Image.network(
                                            '$backendAssetUrl/images/$thumbnail',
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
                                  ],
                                ),
                              ),
                              const SizedBox(height: 50),
                              ElevatedButton(
                                onPressed: () {
                                  _exportAsDoc();
                                },
                                child: const Text('Export as DOC'),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  _exportAsPDF();
                                },
                                child: const Text('Export as PDF'),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, mainScreenRoute);
                                },
                                child: const Text('Exit'),
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
