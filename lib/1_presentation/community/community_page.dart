import 'package:flutter/material.dart';
import 'package:kpostal/kpostal.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TEScaffold(body: KpostalView());
  }
}
