import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:html' as html;

Future<void> downloadShareableContent(GlobalKey key) async {
  try {
    final boundary = key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    final ByteData? byteData =
    await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();

    final blob = html.Blob([pngBytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..style.display = 'none'
      ..download = 'resultado.png';
    html.document.body!.append(anchor);
    anchor.click();
    anchor.remove();
    html.Url.revokeObjectUrl(url);
  } catch (e) {
    print("Erro ao gerar imagem para download: $e");
  }
}
