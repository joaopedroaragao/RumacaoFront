// lib/view/global/footer.dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rumacao_front/constants/app_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fullWidth = MediaQuery.of(context).size.width;
    final width = fullWidth * 0.75;
    final height = width/24.7;

    return Container(
      width: fullWidth,
      padding: const EdgeInsets.all(16),
      color: AppColors.footerBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 500,
              maxHeight: 30
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Image.asset(
                  AppStrings.footerLogo,
                  fit: BoxFit.fitWidth,
                  height: min(height, constraints.maxHeight),
                  width: min(width, constraints.maxWidth)
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  AppStrings.footerTitle,
                  style: AppStyles.footerTitle,
                ),
              ),
              _socialLinks(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _socialLinks() {
    return Column(
      children: [
        _socialLink(
          iconPath: AppStrings.instagramIcon,
          text: AppStrings.instagramHandle,
          url: 'https://instagram.com/${AppStrings.instagramHandle}',
        ),
        const SizedBox(height: 8),
        _socialLink(
          iconPath: AppStrings.emailIcon,
          text: AppStrings.email,
        ),
      ],
    );
  }

  Widget _socialLink({
    required String iconPath,
    required String text,
    String? url,
  }) {
    final child = Row(
      children: [
        SvgPicture.asset(iconPath, fit: BoxFit.fitWidth, width: 16),
        const SizedBox(width: 8),
        Text(text, style: AppStyles.footerText),
      ],
    );
    return url == null ? child : InkWell(
      onTap: () async {
        final Uri uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          throw 'Could not launch $url';
        }
      },
      child: child,
    );
  }
}
