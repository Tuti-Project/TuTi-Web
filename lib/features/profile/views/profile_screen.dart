import 'package:flutter/material.dart';
import 'package:tuti/common/tuti_text.dart';

import '../../../constants/color.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static const String routeName = "profile";
  static const String routePath = "/profile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TuTiText.medium(
            context,
            '대학생 회원가입 후 마이페이지',
          ),
          Expanded(
            child: Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildCircleAvatar(),
                      _buildProfileInfo(),
                    ],
                  ),
                  Row(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleAvatar() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 2,
          color: ColorConstants.primaryColor,
        ),
      ),
      child: const CircleAvatar(
        radius: 50,
        backgroundImage: AssetImage('assets/images/fruit.png'),
        backgroundColor: Colors.transparent,
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Expanded(
      child: Container(
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side:
                const BorderSide(width: 2, color: ColorConstants.primaryColor),
            borderRadius: BorderRadius.circular(45),
          ),
        ),
      ),
    );
  }
}
