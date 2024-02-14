import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConstraintsScaffold extends StatelessWidget {
  const ConstraintsScaffold({
    super.key,
    required this.child,
    this.padding,
  });

  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Stack(
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: 700.w,
                ),
                child: Image.asset(
                  'assets/images/home_mobile.jpg',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                constraints: BoxConstraints(
                  maxWidth: 700.w,
                ),
                padding: padding,
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
