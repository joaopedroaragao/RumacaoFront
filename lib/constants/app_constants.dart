import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'font_family.dart';
import 'package:rumacao_front/constants/font_size.dart';

class MascoteImages {
  final String neutral1 = "assets/images/mascote/neutral/1.png";
  final String neutral2 = "assets/images/mascote/neutral/2.png";
  final String neutral3 = "assets/images/mascote/neutral/3.png";

  final String partiallyAgree1 = "assets/images/mascote/partially_agree/1.png";
  final String partiallyAgree2 = "assets/images/mascote/partially_agree/2.png";
  final String partiallyAgree3 = "assets/images/mascote/partially_agree/3.png";

  final String partiallyDisagree1 = "assets/images/mascote/partially_disagree/1.png";
  final String partiallyDisagree2 = "assets/images/mascote/partially_disagree/2.png";
  final String partiallyDisagree3 = "assets/images/mascote/partially_disagree/3.png";

  final String totallyAgree1 = "assets/images/mascote/totally_agree/1.png";
  final String totallyAgree2 = "assets/images/mascote/totally_agree/2.png";
  final String totallyAgree3 = "assets/images/mascote/totally_agree/3.png";

  final String totallyDisagree1 = "assets/images/mascote/totally_disagree/1.png";
  final String totallyDisagree2 = "assets/images/mascote/totally_disagree/2.png";
  final String totallyDisagree3 = "assets/images/mascote/totally_disagree/3.png";



  final String majorCi = "assets/images/mascote/results/major_ci.png";
  final String majorCul = "assets/images/mascote/results/major_cul.png";
  final String majorEd = "assets/images/mascote/results/major_ed.png";

  final String mixedCiCul = "assets/images/mascote/results/mixed_ci_cul.png";
  final String mixedCiEd = "assets/images/mascote/results/mixed_ci_ed.png";
  final String mixedCulEd = "assets/images/mascote/results/mixed_cul_ed.png";

  final String equivalent = "assets/images/mascote/results/equivalent.png";
}

class AppStrings {
  static final MascoteImages mascoteImages = MascoteImages();

  static const String headerLogo = "assets/images/logo_header.png";
  static const String headerLogoSvg = "assets/images/logo_header.svg";

  static const String rumacaoIcon = "assets/images/rumacao_icon.png";
  static const String rumacaoIconSvg = "assets/images/rumacao_icon.svg";

  static const String caroaTechLogoSvg = "assets/images/caroa_tech_logo.svg";

  static const String footerLogo = "assets/images/logo_footer.png";
  static const String rumaSplash = "assets/images/ruma_splash.png";
  static const String rumaSplashExpandedWidth = "assets/images/ruma_splash_expanded_width.png";
  static const String rumaSplashExtendedWidth = "assets/images/ruma_splash_extended_width.png";
  static const String footerTexture = 'assets/images/footer_texture.png';
  static const String instagramIcon = "assets/images/instagram_icon.svg";
  static const String emailIcon = "assets/images/email_icon.svg";
  static const String description =
      'Descubra como você pode fazer a diferença em causas que inspiram e transformam o seu mundo!';
  static const String startButtonText = 'INICIAR';
  static const String footerTitle = 'ARRUMACÃO';
  static const String instagramHandle = 'vemderuma';
  static const String email = 'vemderuma@gmail.com';
  static const String appName = 'Arrumação';
  static const String confirmButtonText = 'Confirmar';
  static const String termsAndConditions = 'Termos e Condições';
  static const String privacyPolicy = 'Política de Privacidade';
  static const String termsDisclaimerPrefix =
      'Ao fazer o Login, você concorda com os nossos ';
  static const String termsAndConditionsAndPrivacyPolicy =
      'Termos e Condições e Política de Privacidade.';
  static const String identificationHeaderMessage =
      'Para começar, por favor informe seu nome e e-mail.';
  static const String newsletterConsentMessage =
      "Você aceita receber a nossa newsletter?";

  static const agree = "Concordo";
  static const totallyAgree = "Concordo totalmente";
  static const neutral = "Neutro";
  static const disagree = "Discordo";
  static const totallyDisagree = "Discordo totalmente";

  static const agreeDescription = "Expressa um nível moderado de concordância.";
  static const totallyAgreeDescription = "Expressa um nível completo de concordância, sem ressalvas.";
  static const neutralDescription = "Expressa uma posição de neutralidade, sem concordar ou discordar.";
  static const disagreeDescription = "Expressa um nível moderado de discordância.";
  static const totallyDisagreeDescription = "Expressa um nível completo de discordância, sem ressalvas.";
}

class AppColors {
  static const Color headerBackground = Color(0xFFE0E0E0); // Equivalent to Colors.grey.shade300
  static const Color startButton = Color(0xFFFE8F38);
  static const Color footerBackground = Color(0xFF327760);
  static const Color white = Colors.white;
  static const Color primaryCursor = Color(0xFF327760);
  static const Color textFieldBackground = Color(0xFFC2C2C2);
  static const Color primaryButton = Colors.blue;
  static const Color confirmButtonBlue = Color(0xFF475894);
  static const Color termsAndConditionsBlue = Color(0xFF7E97ED);
}

class AppStyles {
  static final TextStyle descriptionText = TextStyle(
    fontSize: calculateFontSize(15),
    fontWeight: FontWeight.w800,
    fontFamily: FontFamily.inter.name,
  );

  static final TextStyle startButtonText = TextStyle(
    color: AppColors.white,
    fontFamily: FontFamily.inter.name,
  );

  static final TextStyle footerTitle = TextStyle(
    fontFamily: FontFamily.dynamicSchematic.name,
    fontSize: calculateFontSize(16),
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static final TextStyle footerText = TextStyle(
    fontSize: calculateFontSize(10),
    color: AppColors.white,
    fontFamily: FontFamily.inter.name,
  );

  static final TextStyle fieldLabel = TextStyle(
    fontSize: calculateFontSize(14),
    fontWeight: FontWeight.w600,
    fontFamily: FontFamily.inter.name,
  );

  static final TextStyle errorText = TextStyle(
    color: Colors.red,
    fontSize: calculateFontSize(12),
    fontFamily: FontFamily.inter.name,
  );

  static final TextStyle termsText = TextStyle(
    fontSize: calculateFontSize(10),
    color: Colors.black,
    fontFamily: FontFamily.inter.name,
  );

  static final TextStyle linkText = TextStyle(
    fontSize: calculateFontSize(10),
    color: AppColors.termsAndConditionsBlue,
    decoration: TextDecoration.none,
    fontFamily: FontFamily.inter.name,
  );

  static final TextStyle headerText = TextStyle(
    fontSize: calculateFontSize(14),
    fontWeight: FontWeight.w600,
    fontFamily: FontFamily.inter.name,
  );

  static const TextStyle titleStyle = TextStyle(
    fontSize: 20, // será ajustado abaixo com calculateFontSize
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 16, // será ajustado abaixo com calculateFontSize
    fontWeight: FontWeight.w400,
    color: Colors.black54,
  );

  static const TextStyle resultTitleStyle = TextStyle(
    fontSize: 18, // será ajustado abaixo com calculateFontSize
    fontWeight: FontWeight.bold,
    color: Color(0xFF327760),
  );

  static const TextStyle textStyle = TextStyle(
    fontSize: 14, // será ajustado abaixo com calculateFontSize
    fontWeight: FontWeight.w500,
    color: Colors.black54,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 14, // será ajustado abaixo com calculateFontSize
    fontWeight: FontWeight.w400,
    color: Colors.black87,
  );

  static const TextStyle resultTextStyle = TextStyle(
    fontSize: 22, // será ajustado abaixo com calculateFontSize
    fontWeight: FontWeight.bold,
    color: Color(0xFF327760),
  );

  static const TextStyle percentageTextStyle = TextStyle(
    fontSize: 16, // será ajustado abaixo com calculateFontSize
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle percentageTitleStyle = TextStyle(
    fontSize: 14, // será ajustado abaixo com calculateFontSize
    fontWeight: FontWeight.w400,
    color: Colors.black87,
  );

  // Se necessário, para os estilos que são declarados como const, podemos criar getters:
  static TextStyle get titleStyleResponsive =>
      titleStyle.copyWith(fontSize: calculateFontSize(20));
  static TextStyle get subtitleStyleResponsive =>
      subtitleStyle.copyWith(fontSize: calculateFontSize(16));
  static TextStyle get resultTitleStyleResponsive =>
      resultTitleStyle.copyWith(fontSize: calculateFontSize(18));
  static TextStyle get textStyleResponsive =>
      textStyle.copyWith(fontSize: calculateFontSize(14));
  static TextStyle get bodyTextResponsive =>
      bodyText.copyWith(fontSize: calculateFontSize(14));
  static TextStyle get resultTextStyleResponsive =>
      resultTextStyle.copyWith(fontSize: calculateFontSize(22));
  static TextStyle get percentageTextStyleResponsive =>
      percentageTextStyle.copyWith(fontSize: calculateFontSize(16));
  static TextStyle get percentageTitleStyleResponsive =>
      percentageTitleStyle.copyWith(fontSize: calculateFontSize(14));
}

PreferredSizeWidget get appBar => PreferredSize(
  preferredSize: const Size.fromHeight(kToolbarHeight),
  child: Container(
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          offset: const Offset(0, -1), // define o deslocamento da sombra
          blurRadius: 6, // define o blur da sombra
        ),
      ],
    ),
    child: AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: SvgPicture.asset(
        AppStrings.headerLogoSvg,
        height: kToolbarHeight / 2.25,
      ),
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      leading: Container(),
    ),
  ),
);