import 'package:example/constant/colors.dart';
import 'package:flutter/material.dart';

import 'dimens.dart';

abstract class Fonts {
  static const poppins = 'Poppins';
}

abstract class TextStyles {
  static const TextStyle textNormal = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: Dimens.textNormal,
    color: AppColors.black,
    overflow: TextOverflow.ellipsis,
  );
}
