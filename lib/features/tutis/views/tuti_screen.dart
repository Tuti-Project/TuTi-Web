import 'package:flutter/material.dart';
import 'package:tuti/common/constraints_scaffold.dart';

import '../../../constants/gaps.dart';
import '../widgets/tuti_widgets/mobile/tuti_bottom_mobile.dart';
import '../widgets/tuti_widgets/mobile/tuti_card_mobile.dart';
import '../widgets/tuti_widgets/mobile/tuti_header_mobile.dart';

class TuTiScreen extends StatelessWidget {
  const TuTiScreen({Key? key}) : super(key: key);

  static const String routeName = "tuti";
  static const String routePath = "/tuti";

  @override
  Widget build(BuildContext context) {
    return const ConstraintsScaffold(
      child: Scaffold(
        body: Column(
          children: [
            Gaps.h14,
            TuTiHeaderMobile(),
            Gaps.h5,
            TuTiCardMobile(),
          ],
        ),
        bottomNavigationBar: TuTiBottomMobile(),
      ),
    );
  }
}
