import 'package:flutter/material.dart';

import 'export.dart';

late Assets assets;
late AppColors colors;
late AppConstant constant;
late AppSizes sizes;
late Styles textStyles;

void initializeAppResources({@required context}) {
  sizes = AppSizes();
  sizes.initializeSize(context);
  assets = Assets();
  colors = AppColors();
  constant = AppConstant();
  textStyles = Styles();
}
