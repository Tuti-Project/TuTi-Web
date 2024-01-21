import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tuti/features/tutis/views/home_screen.dart';
import 'package:tuti/features/tutis/widgets/tuti_button_widget.dart';
import 'package:tuti/features/tutis/widgets/tuti_widgets/desktop/tuti_header_desktop.dart';

import '../../../constants/gaps.dart';
import '../../../constants/media_query.dart';
import '../widgets/tuti_widgets/desktop/tuti_card_desktop.dart';
import '../widgets/tuti_widgets/mobile/tuti_bottom_mobile.dart';
import '../widgets/tuti_widgets/mobile/tuti_card_mobile.dart';
import '../widgets/tuti_widgets/mobile/tuti_header_mobile.dart';

class TuTiScreen extends StatelessWidget {
  const TuTiScreen({Key? key}) : super(key: key);

  static const String routeName = "tuti";
  static const String routePath = "/tuti";

  @override
  Widget build(BuildContext context) {
    final mq = MQ(context);

    return Scaffold(
      body: Column(
        children: [
          mq.isMobile ? Gaps.h14 : Gaps.h104,
          mq.isMobile ? const TuTiHeaderMobile() : const TuTiHeaderDesktop(),
          mq.isMobile ? Gaps.h5 : Gaps.h40,
          mq.isMobile ? const TuTiCardMobile() : const TuTiCardDesktop(),
        ],
      ),
      bottomNavigationBar: mq.isMobile ? const TuTiBottomMobile() : null,
    );
  }
}
