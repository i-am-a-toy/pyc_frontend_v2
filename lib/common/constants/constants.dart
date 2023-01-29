import 'package:flutter/material.dart';

const kDefaultValue = 20.0;

const Color kPrimaryColor = Color(0xff0C3D81);
const Color kSecondaryColor = Color(0xffEDF1FD);
const Color kThirdColor = Color(0xffADC2A9);

const kDoubleHeightSizeBox = SizedBox(
  height: kDefaultValue * 2,
);

const kHeightSizeBox = SizedBox(
  height: kDefaultValue,
);

const kHalfHeightSizeBox = SizedBox(
  height: kDefaultValue / 2,
);

const kQuarterHeightSizedBox = SizedBox(
  height: kDefaultValue / 4,
);

const kWidthSizeBox = SizedBox(
  width: kDefaultValue,
);

const kHalfWidthSizedBox = SizedBox(
  width: kDefaultValue / 2,
);

const kQuarterWidthSizedBox = SizedBox(
  width: kDefaultValue / 4,
);

final kDefaultUserImage = Image.asset(
  'assets/icons/person_icon.png',
).image;
