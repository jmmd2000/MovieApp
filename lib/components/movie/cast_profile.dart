// This displays the actors image, name and role name for use in the
// CastSliders on MoviePages

import 'package:api/colours.dart';
import 'package:api/components/functions/get_image.dart';
import 'package:flutter/material.dart';

class CastProfile extends StatelessWidget {
  final String name;
  final String profilePath;
  final String role;

  const CastProfile({
    super.key,
    required this.name,
    required this.profilePath,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          CircleAvatar(
            backgroundImage: getImage(profilePath),
            backgroundColor: secondaryColour,
            radius: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              style: textPrimaryBold12,
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                parseRole(role),
                style: textSecondary12,
              ),
            ),
          ),
        ]),
      ),
    );
  }

  // Some actors have many, many roles which breaks formatting
  // and looks really bad. This just removes all but the first one
  // for display
  String parseRole(String role) {
    if (role.contains("/")) {
      int x = role.indexOf("/");
      String sub = role.substring(0, x);
      return sub;
    } else {
      return role;
    }
  }
}
