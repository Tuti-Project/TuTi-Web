import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuti/common/constraints_scaffold.dart';

import '../../../constants/gaps.dart';
import '../widgets/tuti_widgets/tuti_card_mobile.dart';
import '../widgets/tuti_widgets/tuti_header_mobile.dart';

class TuTiScreen extends StatelessWidget {
  const TuTiScreen({Key? key}) : super(key: key);

  static const String routeName = "tuti";
  static const String routePath = "/tuti";

  @override
  Widget build(BuildContext context) {
    return ConstraintsScaffold(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        child: const Column(
          children: [
            TuTiHeaderMobile(),
            Flexible(
              flex: 5,
              child: TuTiCardMobile(),
            ),
          ],
        ),
      ),
    );
  }
}
