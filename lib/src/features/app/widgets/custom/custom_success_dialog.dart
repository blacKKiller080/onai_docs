import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onai_docs/src/core/extension/extensions.dart';
import 'package:onai_docs/src/core/resources/resources.dart';

class CustomSuccessDialog extends StatefulWidget {
  final String label;
  const CustomSuccessDialog({super.key, required this.label});

  static Future<void> show(
    BuildContext context,
    String label,
  ) async =>
      showDialog<void>(
        context: context,
        builder: (BuildContext context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          surfaceTintColor: AppColors.kWhite,
          backgroundColor: AppColors.kWhite,
          // insetPadding: EdgeInsets.symmetric(
          //   vertical: 100,
          // ),
          child: CustomSuccessDialog(label: label),
        ),
      );

  @override
  State<CustomSuccessDialog> createState() => _CustomSuccessDialogState();
}

class _CustomSuccessDialogState extends State<CustomSuccessDialog>
    with TickerProviderStateMixin {
  late AnimationController markController;
  late AnimationController cirleController;
  late AnimationController markController2;

  // late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    cirleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    markController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 70),
    );

    markController2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 130),
    );

    cirleController.addListener(() {
      setState(() {});
    });
    markController.addListener(() {
      setState(() {});
    });
    markController2.addListener(() {
      setState(() {});
    });

    cirleController.forward();
    Future.delayed(
      const Duration(milliseconds: 300),
      () => markController.forward(),
    );
    Future.delayed(
      const Duration(milliseconds: 370),
      () => markController2.forward(),
    );

    Future.delayed(
      const Duration(milliseconds: 1000),
      () => context.router.maybePop(),
    );
  }

  @override
  void dispose() {
    cirleController.dispose();
    super.dispose();
  }

  // void restartAnimation() {
  //   _controller.reset();
  //   _controller.forward();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      width: context.screenSize.width - 50,
      padding: const EdgeInsets.only(top: 30, left: 16, right: 16),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.label,
            textAlign: TextAlign.center,
            style: AppTextStyles.os20w700,
          ),
          const SizedBox(height: 50),
          Align(
            alignment: Alignment.bottomCenter,
            child: SuccessCircle(
              controller: cirleController,
              markController: markController,
              markController2: markController2,
              // animation: animation,
            ),
          ),
        ],
      ),
    );
  }
}

class CheckmarkPainter extends CustomPainter {
  final double progress;
  final double progress2;

  CheckmarkPainter(this.progress, this.progress2);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.kMainOrange
      ..strokeWidth = 12.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final path = Path();
    // final pathh = Path();

    path.moveTo(-22, -6);
    path.relativeLineTo(18 * progress, 19 * progress);
    // pathh.moveTo(-4, 9);
    path.relativeLineTo(50 * progress2, -50 * progress2);

    canvas.drawPath(path, paint);
    // canvas.drawPath(pathh, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class SuccessCircle extends StatelessWidget {
  final AnimationController controller;
  final AnimationController markController;
  final AnimationController markController2;

  // final Animation<double> animation;

  const SuccessCircle({
    required this.controller,
    required this.markController,
    required this.markController2,

    // required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: const Size(125, 125),
          painter: MyPainter(controller.value),
        ),
        CustomPaint(
          painter:
              CheckmarkPainter(markController.value, markController2.value),
        ),
      ],
    );
  }
}

class MyPainter extends CustomPainter {
  final double progress;

  MyPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.kMainOrange
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12.0;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const pi = 3.14159265359;

    final sweepAngle = 1.7 * pi * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 15,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
