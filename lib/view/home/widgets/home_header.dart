import 'package:flutter/material.dart';
import '../../../res/color/app_color.dart';
import '../../../res/fonts/app_fonts.dart';

class HomeHeader extends StatelessWidget {
  final String name;
  final String date;
  const HomeHeader({super.key, required this.name, required this.date});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good morning,',
              style: AppFonts.bodyMedium.copyWith(color: AppColors.textMuted),
            ),
            const SizedBox(height: 4),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: name.split(' ')[0],
                    style: AppFonts.headlineLarge.copyWith(
                      fontSize: 28,
                      fontWeight: AppFonts.black_w,
                    ),
                  ),
                  const TextSpan(text: ' '),
                  TextSpan(
                    text: name.split(' ').length > 1 ? name.split(' ')[1] : '',
                    style: AppFonts.headlineLarge.copyWith(
                      fontSize: 28,
                      color: AppColors.primary,
                      fontWeight: AppFonts.black_w,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              date,
              style: AppFonts.bodySmall.copyWith(color: AppColors.textMuted),
            ),
          ],
        ),
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.border),
              ),
              child: const Icon(
                Icons.notifications_none_rounded,
                color: AppColors.white,
                size: 24,
              ),
            ),
            Positioned(
              right: 2,
              top: 2,
              child: Container(
                height: 10,
                width: 10,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
