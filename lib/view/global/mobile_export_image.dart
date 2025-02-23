// import 'dart:typed_data';
// import 'dart:ui' as ui;
import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:get/get.dart';

Future<void> downloadShareableContent(GlobalKey key) async {
  // try {
  //   // Solicita permissões, se necessário (principalmente para Android)
  //   if (await Permission.storage.request().isDenied) {
  //     Get.defaultDialog(title: 'Permissão de armazenamento negada');
  //     return;
  //   }
  //
  //   // Obtém o RenderRepaintBoundary a partir da key
  //   RenderRepaintBoundary boundary =
  //   key.currentContext!.findRenderObject() as RenderRepaintBoundary;
  //   // Gera uma imagem a partir do widget com a densidade de pixels desejada
  //   ui.Image image = await boundary.toImage(pixelRatio: 3.0);
  //   // Converte a imagem para bytes no formato PNG
  //   ByteData? byteData =
  //   await image.toByteData(format: ui.ImageByteFormat.png);
  //   Uint8List pngBytes = byteData!.buffer.asUint8List();
  //
  //   // Salva a imagem na galeria
  //   final result = await ImageGallerySaver.saveImage(
  //     pngBytes,
  //     quality: 100,
  //     name: "captura_${DateTime.now().millisecondsSinceEpoch}",
  //   );
  //   print('Imagem salva: $result');
  // } catch (e) {
  //   print('Erro ao capturar imagem: $e');
  // }
}
