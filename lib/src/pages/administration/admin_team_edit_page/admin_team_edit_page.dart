import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:universal_html/prefer_universal/html.dart' as html;

import 'package:appli_wei_custom/models/team.dart';
import 'package:appli_wei_custom/src/pages/administration/admin_team_edit_page/widgets/admin_team_form.dart';
import 'package:appli_wei_custom/src/shared/widgets/button.dart';
import 'package:appli_wei_custom/src/shared/widgets/team_image.dart';
import 'package:appli_wei_custom/src/shared/widgets/top_navigation_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';


class AdminTeamEditPage extends StatefulWidget {
  const AdminTeamEditPage({Key key, @required this.team, this.heroTag}) : super(key: key);

  final Team team;
  final String heroTag;

  @override 
  _AdminTeamEditPageState createState() => _AdminTeamEditPageState();
}

class _AdminTeamEditPageState extends State<AdminTeamEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // First we add main widgets
          Positioned.fill(
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Hero(
                          tag: widget.heroTag,
                          child: TeamImage(
                            team: widget.team,
                            boxFit: BoxFit.cover,
                          )
                        ),
                      ),
                      Align(
                        child: Button(
                          onPressed: () async {
                            await _updateTeamPicture();
                          },
                          text: "Modifier",
                        ),
                      )
                    ],
                  )
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25, left: 32, right: 32, bottom: 8),
                    child: AdminTeamForm(team: widget.team,)
                  ),
                )
              ],
            ) 
          ),
          TopNavigationBar(),
        ],
      ),
    );
  }

  Future _updateTeamPicture() async {
    MemoryImage memoryImage;

    if (kIsWeb) {
      final html.FileUploadInputElement input = html.FileUploadInputElement();
      input.accept = 'image/*';
      input.click();
      
      await input.onChange.first;
      
      if (input.files.isEmpty) {
         return null;
      }

      final reader = html.FileReader();
      reader.readAsDataUrl(input.files[0]);
      
      await reader.onLoad.first;
      
      final String encoded = reader.result as String;
      final String base64Image = encoded.replaceFirst(RegExp('data:image/[^;]+;base64,'), '');

      memoryImage = MemoryImage(base64Decode(base64Image));
    }
    else {
      final File image = await FilePicker.getFile(type: FileType.image);
      
      if (image == null) {
        return;
      }
      
      final bytes = await image.readAsBytes();
      memoryImage = MemoryImage(bytes);
    }  
    
    setState(() {
      widget.team.imageId = "modified";
      widget.team.image = memoryImage;
    });
  }
}