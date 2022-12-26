import 'package:flutter/material.dart';

import '../../settings_ui.dart';


class CustomSettingsSection extends AbstractSettingsSection {
  const CustomSettingsSection({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
