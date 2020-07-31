import 'dart:convert';

import 'package:appli_wei_custom/models/administration/admin_challenge.dart';
import 'package:appli_wei_custom/services/challenge_service.dart';
import 'package:appli_wei_custom/src/providers/user_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminChallengeImage extends StatelessWidget {
  const AdminChallengeImage({Key key, @required this.challenge, this.height, this.boxFit}) : super(key: key);

  final AdminChallenge challenge;

  final double height;
  final BoxFit boxFit;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserStore>(
      builder: (context, userStore, child) {
        if (challenge.image == null) {
          return FutureBuilder(
            future: ChallengeService.instance.getChallengeImage(userStore.authentificationHeader, challenge.id, challenge.imageId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (!snapshot.hasData) {
                  return Image(
                      image: const AssetImage("assets/logo.jpg"), 
                      height: height,
                      fit: boxFit
                  );
                }

                challenge.image = MemoryImage(base64Decode(snapshot.data as String));

                return Image(
                  image: challenge.image,
                  height: height,
                  fit: boxFit,
                );
              }

              return const Center(child: CircularProgressIndicator(),);
            },
          );
        }

        return Image(
          image: challenge.image,
          height: height,
          fit: boxFit,
        );
      },
    );
  }
}