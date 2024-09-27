import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:my_windows_app/constants.dart';
import 'package:docx_template/docx_template.dart';
import 'package:file_picker/file_picker.dart';

class ExportAsDoc extends StatelessWidget {
  final String? name;
  final String? alias;
  final String? fatherName;
  final String? motherName;
  final String? religion;
  final String? sectSubSect;
  final String? caste;
  final String? subCaste;
  final String? nationality;
  final String? cnic;
  final String? dob;
  final String? age;
  final String? civEdn;
  final String? complexion;
  final String? contactNos;
  final String? facebook;
  final String? twitter;
  final String? tikTok;
  final String? email;
  final String? passportNo;
  final String? bankAcctDetails;
  final String? languages;
  final String? tempAddress;
  final String? permAddress;
  final String? detailOfVisitForeginCountries;
  final String? areasOfInfluence;
  final String? activeSince;
  final String? likelyLoc;
  final String? tier;
  final String? afflWithTsGp;
  final String? politicalAffl;
  final String? religiousAffl;
  final String? occupation;
  final String? sourceOfIncome;
  final String? propertyDetails;
  final String? maritalStatus;
  final String? detailOfChildren;
  final String? brothers;
  final String? sisters;
  final String? uncles;
  final String? aunts;
  final String? cousins;
  final String? fatherInLaw;
  final String? motherInLaw;
  final String? brotherInLaw;
  final String? sisterInLaw;
  final String? criminalActivities;
  final String? extortionActivities;
  final String? attitudeTowardsGovt;
  final String? attitudeTowardsState;
  final String? attitudeTowardsSFs;
  final String? genHabbits;
  final String? reputationAmongLocals;
  final String? firStatus;
  final String? genRemarks;
  final String? thumbnail;
  final File? selectedImage;

  const ExportAsDoc(
      {super.key,
      this.name,
      this.alias,
      this.fatherName,
      this.motherName,
      this.religion,
      this.sectSubSect,
      this.caste,
      this.subCaste,
      this.nationality,
      this.cnic,
      this.dob,
      this.age,
      this.civEdn,
      this.complexion,
      this.contactNos,
      this.facebook,
      this.twitter,
      this.tikTok,
      this.email,
      this.passportNo,
      this.bankAcctDetails,
      this.languages,
      this.tempAddress,
      this.permAddress,
      this.detailOfVisitForeginCountries,
      this.areasOfInfluence,
      this.activeSince,
      this.likelyLoc,
      this.tier,
      this.afflWithTsGp,
      this.politicalAffl,
      this.religiousAffl,
      this.occupation,
      this.sourceOfIncome,
      this.propertyDetails,
      this.maritalStatus,
      this.detailOfChildren,
      this.brothers,
      this.sisters,
      this.uncles,
      this.aunts,
      this.cousins,
      this.fatherInLaw,
      this.motherInLaw,
      this.brotherInLaw,
      this.sisterInLaw,
      this.criminalActivities,
      this.extortionActivities,
      this.attitudeTowardsGovt,
      this.attitudeTowardsState,
      this.attitudeTowardsSFs,
      this.genHabbits,
      this.reputationAmongLocals,
      this.firStatus,
      this.genRemarks,
      this.thumbnail,
      this.selectedImage});

  @override
  Widget build(BuildContext context) {
    void exportAsPDF() async {
      final f = File("assets/docx/template.docx");
      final docx = await DocxTemplate.fromBytes(await f.readAsBytes());

      Uint8List bytes = Uint8List(0); // Initialize with an empty byte array

      // Update image with online image
      if (selectedImage != null) {
        final data = await selectedImage!.readAsBytes();
        bytes = data;
      } else if (thumbnail != null) {
        final data =
            await http.get(Uri.parse('$backendAssetUrl/images/$thumbnail'));
        bytes = data.bodyBytes;
      }

      Content c = Content();
      c
        ..add(TextContent("name", name))
        ..add(TextContent("alias", alias))
        ..add(TextContent("father_name", fatherName))
        ..add(TextContent("mother_name", motherName))
        ..add(TextContent("religion", religion))
        ..add(TextContent("sect_sub_sect", sectSubSect))
        ..add(TextContent("caste", caste))
        ..add(TextContent("sub_caste", subCaste))
        ..add(TextContent("nationality", nationality))
        ..add(TextContent("cnic", cnic))
        ..add(TextContent("dob", dob))
        ..add(TextContent("age", age))
        ..add(TextContent("civ_edn", civEdn))
        ..add(TextContent("complexion", complexion))
        ..add(TextContent("contact_nos", contactNos))
        ..add(TextContent("facebook", facebook))
        ..add(TextContent("twitter", twitter))
        ..add(TextContent("tiktok", tikTok))
        ..add(TextContent("email", email))
        ..add(TextContent("passport_no", passportNo))
        ..add(TextContent("bank_acct_details", bankAcctDetails))
        ..add(TextContent("languages", languages))
        ..add(TextContent("temp_address", tempAddress))
        ..add(TextContent("perm_address", permAddress))
        ..add(TextContent(
            "detail_of_visit_foregin_countries", detailOfVisitForeginCountries))
        ..add(TextContent("areas_of_influence", areasOfInfluence))
        ..add(TextContent("active_since", activeSince))
        ..add(TextContent("likely_loc", likelyLoc))
        ..add(TextContent("tier", tier))
        ..add(TextContent("affl_with_ts_gp", afflWithTsGp))
        ..add(TextContent("political_affl", politicalAffl))
        ..add(TextContent("religious_affl", religiousAffl))
        ..add(TextContent("occupation", occupation))
        ..add(TextContent("source_of_income", sourceOfIncome))
        ..add(TextContent("property_details", propertyDetails))
        ..add(TextContent("marital_status", maritalStatus))
        ..add(TextContent("detail_of_children", detailOfChildren))
        ..add(TextContent("brothers", brothers))
        ..add(TextContent("sisters", sisters))
        ..add(TextContent("uncles", uncles))
        ..add(TextContent("aunts", aunts))
        ..add(TextContent("cousins", cousins))
        ..add(TextContent("father_in_law", fatherInLaw))
        ..add(TextContent("mother_in_law", motherInLaw))
        ..add(TextContent("brother_in_law", brotherInLaw))
        ..add(TextContent("sister_in_law", sisterInLaw))
        ..add(TextContent("criminal_activities", criminalActivities))
        ..add(TextContent("extortion_activities", extortionActivities))
        ..add(TextContent("attitude_towards_govt", attitudeTowardsGovt))
        ..add(TextContent("attitude_towards_state", attitudeTowardsState))
        ..add(TextContent("attitude_towards_sfs", attitudeTowardsSFs))
        ..add(TextContent("gen_habbits", genHabbits))
        ..add(TextContent("reputation_among_locals", reputationAmongLocals))
        ..add(TextContent("fir_status", firStatus))
        ..add(TextContent("gen_remarks", genRemarks))
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

    return ElevatedButton(
      onPressed: () {
        exportAsPDF();
      },
      child: const Text('Export as DOC'),
    );
  }
}
