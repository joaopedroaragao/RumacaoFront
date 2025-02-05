// lib/constants/app_constants.dart
import 'package:flutter/material.dart';
import 'font_family.dart';

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
}

class AppStrings {
  static final MascoteImages mascoteImages = MascoteImages();

  static const String headerLogo = "assets/images/logo_header.png";
  static const String footerLogo = "assets/images/logo_footer.png";
  static const String instagramIcon = "assets/images/instagram_icon.svg";
  static const String emailIcon = "assets/images/email_icon.svg";
  static const String description =
      'Descubra como você pode fazer a diferença em causas que inspiram e transformam o seu mundo!';
  static const String startButtonText = 'INICIAR';
  static const String footerTitle = 'RUMACÃO';
  static const String instagramHandle = 'vemderuma';
  static const String email = 'vemderuma@gmail.com';
  static const String appName = 'Rumação';
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
      "Você aceita coisar a newsletter?";

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
    fontSize: 15,
    fontWeight: FontWeight.w800,
    fontFamily: FontFamily.inter.name,
  );

  static final TextStyle startButtonText = TextStyle(
    color: AppColors.white,
    fontFamily: FontFamily.inter.name,
  );

  static final TextStyle footerTitle = TextStyle(
    fontFamily: FontFamily.dynamicSchematic.name,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static final TextStyle footerText = TextStyle(
    fontSize: 10,
    color: AppColors.white,
    fontFamily: FontFamily.inter.name,
  );

  static final TextStyle fieldLabel = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    fontFamily: FontFamily.inter.name,
  );

  static final TextStyle errorText = TextStyle(
    color: Colors.red,
    fontSize: 12,
    fontFamily: FontFamily.inter.name,
  );

  static final TextStyle termsText = TextStyle(
    fontSize: 12,
    color: Colors.black,
    fontFamily: FontFamily.inter.name,
  );

  static final TextStyle linkText = TextStyle(
    fontSize: 12,
    color: AppColors.termsAndConditionsBlue,
    decoration: TextDecoration.none, // Remove o sublinhado
    fontFamily: FontFamily.inter.name,
  );

  static final TextStyle headerText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontFamily: FontFamily.inter.name,
  );
}
