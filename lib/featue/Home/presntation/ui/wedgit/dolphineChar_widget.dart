import 'package:flutter/material.dart';
import 'package:focus_flow/featue/Home/presntation/ui/wedgit/study_buddy_widget.dart';

/// Legacy DolphinCharacterWidget now delegates to the enhanced StudyBuddyWidget
class DolphinCharacterWidget extends StatelessWidget {
  final int level;

  const DolphinCharacterWidget({
    super.key,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return const StudyBuddyWidget();
  }
}
