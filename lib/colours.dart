// This file contains all the colours and font styles used for this project

import 'package:flutter/material.dart';

const primaryColour = Color(0xFF2a2e33);

Color secondaryColour = const Color(0xFF4CAF50);
Color secondaryDarker = HSLColor.fromColor(secondaryColour).withLightness(0.25).toColor();
const bodyBackground = Color(0xFF1f2326);
const fontPrimary = Color.fromARGB(255, 231, 231, 231);
const softWhite = Color.fromARGB(255, 224, 218, 218);
const white = Colors.white;

TextStyle textPrimary = const TextStyle(color: fontPrimary);
TextStyle textPrimary12 = const TextStyle(color: fontPrimary, fontSize: 12);
TextStyle textPrimary14 = const TextStyle(color: fontPrimary, fontSize: 14);
TextStyle textPrimary16 = const TextStyle(color: fontPrimary, fontSize: 16);
TextStyle textPrimary18 = const TextStyle(color: fontPrimary, fontSize: 18);
TextStyle textPrimary20 = const TextStyle(color: fontPrimary, fontSize: 20);
TextStyle textPrimary22 = const TextStyle(color: fontPrimary, fontSize: 22);
TextStyle textPrimaryBold12 = const TextStyle(color: fontPrimary, fontSize: 12, fontWeight: FontWeight.bold);
TextStyle textPrimaryBold14 = const TextStyle(color: fontPrimary, fontSize: 14, fontWeight: FontWeight.bold);
TextStyle textPrimaryBold16 = const TextStyle(color: fontPrimary, fontSize: 16, fontWeight: FontWeight.bold);
TextStyle textPrimaryBold18 = const TextStyle(color: fontPrimary, fontSize: 18, fontWeight: FontWeight.bold);
TextStyle textPrimaryBold20 = const TextStyle(color: fontPrimary, fontSize: 20, fontWeight: FontWeight.bold);
TextStyle textPrimaryBold22 = const TextStyle(color: fontPrimary, fontSize: 22, fontWeight: FontWeight.bold);
TextStyle textPrimaryBold24 = const TextStyle(color: fontPrimary, fontSize: 24, fontWeight: FontWeight.bold);
TextStyle textPrimaryBold26 = const TextStyle(color: fontPrimary, fontSize: 26, fontWeight: FontWeight.bold);
TextStyle textPrimaryBold28 = const TextStyle(color: fontPrimary, fontSize: 28, fontWeight: FontWeight.bold);

TextStyle textSecondary = TextStyle(color: secondaryColour);
TextStyle textSecondaryBold14 = TextStyle(color: secondaryColour, fontSize: 14, fontWeight: FontWeight.bold);
TextStyle textSecondaryBold16 = TextStyle(color: secondaryColour, fontSize: 16, fontWeight: FontWeight.bold);
TextStyle textSecondaryBold20 = TextStyle(color: secondaryColour, fontSize: 20, fontWeight: FontWeight.bold);
TextStyle textSecondaryBold28 = TextStyle(color: secondaryColour, fontSize: 28, fontWeight: FontWeight.bold);
TextStyle textSecondaryBold32 = TextStyle(color: secondaryColour, fontSize: 32, fontWeight: FontWeight.w900);

TextStyle textSecondary12 = TextStyle(color: secondaryColour, fontSize: 12);
TextStyle textSecondary14 = TextStyle(color: secondaryColour, fontSize: 14);
TextStyle textSecondary16 = TextStyle(color: secondaryColour, fontSize: 16);
