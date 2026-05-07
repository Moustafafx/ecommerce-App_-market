import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/auth/widgets/profile_animation_widget/OrbitPainter%20.dart';
import 'package:image_picker/image_picker.dart';

class OrbitAvatar extends StatefulWidget {
  final String networkImage; // الصورة الافتراضية من النت
  final XFile? localImage; // ✅ الصورة اللي المستخدم اختارها

  const OrbitAvatar({super.key, required this.networkImage, this.localImage});

  @override
  _OrbitAvatarState createState() => _OrbitAvatarState();
}

class _OrbitAvatarState extends State<OrbitAvatar>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ✅ اختيار الصورة الصح
    final ImageProvider imageProvider = widget.localImage != null
        ? FileImage(File(widget.localImage!.path))
        : NetworkImage(widget.networkImage);

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: const Size(300, 300),
              painter: OrbitPainter(controller.value),
            ),
            CircleAvatar(radius: 60, backgroundImage: imageProvider),

            Positioned(
              child: Icon(Icons.camera_alt, size: 33),
              bottom: 88,
              right: 95,
            ),
          ],
        );
      },
    );
  }
}
