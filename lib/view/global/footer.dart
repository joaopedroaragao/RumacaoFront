import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rumacao_front/constants/app_constants.dart';
import 'package:rumacao_front/constants/font_family.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final fullWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final double appBarHeight = Scaffold.of(context).appBarMaxHeight ?? 0;

    // Fator de escala baseado na altura, limitado entre 0.5 e 1.0.
    // Assim, em telas pequenas, o layout será reduzido proporcionalmente.
    final double scale = (screenHeight / 2000).clamp(0.5, 1.0);
    final width = fullWidth * 0.75;
    final logoHeight = width / 24.7;

    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      width: fullWidth,
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        image: const DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(AppImages.footerTexture)
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(0, -3),
            blurRadius: 10
          )
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0 * scale),
                // child: Text(
                //   AppStrings.footerTitle,
                //   style: AppStyles.footerTitle.copyWith(
                //     // fontSize: AppStyles.footerTitle.fontSize! * scale,
                //   ),
                // ),
                child: SvgPicture.asset(
                  AppImages.headerLogoWhiteSvg,
                  height: 25 * scale,
                  fit: BoxFit.fitHeight,
                ),
              ),
              _socialLinks(scale),
            ],
          ),
          SizedBox(height: 25 * scale),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppImages.caroaTechLogoSvg,
                height: 25 * scale,
                fit: BoxFit.fitHeight,
              ),
              SizedBox(width: 16 * scale),
              Text(
                "+",
                style: TextStyle(
                  fontFamily: FontFamily.dynamicSchematic.name,
                  fontSize: 25 * scale,
                  color: Colors.white
                )
              ),
              SizedBox(width: 16 * scale),
              Text(
                  "RUMA",
                  style: TextStyle(
                      fontFamily: FontFamily.dynamicSchematic.name,
                      fontSize: 25 * scale,
                      color: Colors.white
                  )
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _socialLinks(double scale) {
    return Container(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _socialLink(
            iconPath: AppImages.instagramIcon,
            text: AppStrings.instagramHandle,
            url: 'https://instagram.com/${AppStrings.instagramHandle}',
            verticalSpacing: 8 * scale,
          ),
          SizedBox(height: 8 * scale),
          _socialLink(
            iconPath: AppImages.emailIcon,
            text: AppStrings.email,
            verticalSpacing: 8 * scale,
          ),
        ],
      ),
    );
  }

  Widget _socialLink({
    required String iconPath,
    required String text,
    String? url,
    required double verticalSpacing,
  }) {
    final child = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(
          iconPath,
          width: 16,
          fit: BoxFit.fitWidth,
        ),
        const SizedBox(width: 8),
        Text(text, style: AppStyles.footerText),
      ],
    );
    return url == null
        ? child
        : InkWell(
      onTap: () async {
        final Uri uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          throw 'Could not launch $url';
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: verticalSpacing),
        child: child,
      ),
    );
  }
}
