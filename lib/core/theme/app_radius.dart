import 'package:flutter/material.dart';

import 'app_spacing.dart';

class AppRadius {
  AppRadius._();

  static const xSmall  = BorderRadius.all(Radius.circular(AppSpacing.xs));
  static const small  = BorderRadius.all(Radius.circular(AppSpacing.s));
  static const medium = BorderRadius.all(Radius.circular(AppSpacing.m));
  static const large  = BorderRadius.all(Radius.circular(AppSpacing.l));
}