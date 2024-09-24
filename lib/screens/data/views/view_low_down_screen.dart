import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:my_windows_app/constants.dart';
import 'package:my_windows_app/route/route_constants.dart';

class ViewLowDownScreen extends StatefulWidget {
  final String? dataEntryId;

  const ViewLowDownScreen({this.dataEntryId, super.key});

  @override
  ViewLowDownScreenState createState() => ViewLowDownScreenState();
}

class ViewLowDownScreenState extends State<ViewLowDownScreen> {
  String? thumbnail;

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

  void _exportAsPDF() async {
    final pdf = pw.Document();

    // Fetch the thumbnail image data
    Uint8List? imageData;
    if (thumbnail != null) {
      final response =
          await http.get(Uri.parse('$backendAssetUrl/images/$thumbnail'));
      if (response.statusCode == 200) {
        imageData = response.bodyBytes;
      }
    }

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.ListView(children: [
            pw.Text(
              'Low Down',
              style: pw.TextStyle(
                fontSize: 32,
                fontWeight: pw.FontWeight.bold,
                color: const PdfColor.fromInt(0xFFFFD966),
              ),
            ),
            if (imageData != null) ...[
              pw.SizedBox(height: 20),
              pw.Image(
                pw.MemoryImage(imageData),
                width: 200,
                height: 200,
              ),
            ],
            pw.SizedBox(height: 20),
            pw.Expanded(
              child: pw.Row(children: [
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      // Text Inputs : Name, Alias, Father Name, Mother Name, Religion, Sect/Sub Sect, Caste, SUb Caste, National
                      pw.Text('Name: ${_name.text}',
                          style: const pw.TextStyle(
                              color: PdfColor.fromInt(0xFF000000))),
                      pw.Text('Alias: ${_alias.text}'),
                      pw.Text('Father Name: ${_fatherName.text}'),
                      pw.Text('Mother Name: ${_motherName.text}'),
                      pw.Text('Religion: ${_religion.text}'),
                      pw.Text('Sect/Sub Sect: ${_sectSubSect.text}'),
                      pw.Text('Caste: ${_caste.text}'),
                      pw.Text('Sub Caste: ${_subCaste.text}'),
                      pw.SizedBox(height: 10),

                      // Text Inputs: Passport No, Bank Acct Details, Languages, Temp Address, Perm Address, Detail of Visit foregin countries, Areas of Influence, Active Since, Likely Loc, Tier, Affl with Ts Gp
                      pw.Text('Passport No: ${_passportNo.text}'),
                      pw.Text('Bank Acct Details: ${_bankAcctDetails.text}'),
                      pw.Text('Languages: ${_languages.text}'),
                      pw.Text('Temp Address: ${_tempAddress.text}'),
                      pw.Text('Perm Address: ${_permAddress.text}'),
                      pw.Text(
                          'Detail of Visit foregin countries: ${_detailOfVisitForeginCountries.text}'),
                      pw.Text('Areas of Influence: ${_areasOfInfluence.text}'),
                      pw.Text('Active Since: ${_activeSince.text}'),
                      pw.Text('Likely Loc: ${_likelyLoc.text}'),
                      pw.Text('Tier: ${_tier.text}'),
                      pw.Text('Affl with Ts Gp: ${_afflWithTsGp.text}'),
                      pw.SizedBox(height: 10),

                      // Text Inputs: Political Affl, Religious Affl, Occupation, Mother Name, Suurce of Income, Property Details, Marital Status, Detail of Children
                      pw.Text('Political Affl: ${_politicalAffl.text}'),
                      pw.Text('Religious Affl: ${_religiousAffl.text}'),
                      pw.Text('Occupation: ${_occupation.text}'),
                      pw.Text('Mother Name: ${_motherName.text}'),
                      pw.Text('Source of Income: ${_sourceOfIncome.text}'),
                      pw.Text('Property Details: ${_propertyDetails.text}'),
                      pw.Text('Marital Status: ${_maritalStatus.text}'),
                      pw.Text('Detail of Children: ${_detailOfChildren.text}'),
                    ],
                  ),
                ),
                pw.Expanded(
                    child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                      // Label Family Detail (Own) i.2 Name, Relation, Age, Profession, Address
                      pw.Text('Brothers: ${_brothers.text}'),
                      pw.Text('Sisters: ${_sisters.text}'),
                      pw.Text('Uncles: ${_uncles.text}'),
                      pw.Text('Aunts: ${_aunts.text}'),
                      pw.Text('Cousins: ${_cousins.text}'),
                      pw.SizedBox(height: 10),

                      // Label: In Laws Detail (i.2 Name, Relation, Age, Profession, Address)
                      pw.Text('Father in Law: ${_fatherInLaw.text}'),
                      pw.Text('Mother in Law: ${_motherInLaw.text}'),
                      pw.Text('Brother in Law: ${_brotherInLaw.text}'),
                      pw.Text('Sister in Law: ${_sisterInLaw.text}'),
                      pw.SizedBox(height: 10),

                      // Text Inputs: Criminal Activities, Extortion Activities, Attitude towards Govt, Attitude towards State, Attitude towards SFs, Gen Habbits, Reputation among locals, FIR Status
                      pw.Text(
                          'Criminal Activities: ${_criminalActivities.text}'),
                      pw.Text(
                          'Extortion Activities: ${_extortionActivities.text}'),
                      pw.Text(
                          'Attitude towards Govt: ${_attitudeTowardsGovt.text}'),
                      pw.Text(
                          'Attitude towards State: ${_attitudeTowardsState.text}'),
                      pw.Text(
                          'Attitude towards SFs: ${_attitudeTowardsSFs.text}'),
                      pw.Text('Gen Habbits: ${_genHabbits.text}'),
                      pw.Text(
                          'Reputation among locals: ${_reputationAmongLocals.text}'),
                      pw.Text('FIR Status: ${_firStatus.text}'),
                      pw.SizedBox(height: 10),

                      // Gen Remarks
                      pw.Text('Gen Remarks: ${_genRemarks.text}'),
                    ]))
              ]),
            ),
            pw.SizedBox(width: 50),
          ]);
        },
      ),
    );

    // await Printing.layoutPdf(
    //   onLayout: (PdfPageFormat format) async => pdf.save(),
    // );

    // Save the PDF after the page has been added.
    final bytes = await pdf.save();

    // Now use the 'bytes' to print using Printing.layoutPdf
    await Printing.layoutPdf(onLayout: (_) => bytes);
  }

  void _exportAsDoc() async {}

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
                          child: Expanded(
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
                          ))),
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
