import 'package:flutter/material.dart';

import 'colors.dart';
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
