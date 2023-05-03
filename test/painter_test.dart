/*
 * QR.Widget
 * Copyright (c) 2019-2023 the QR.Widget authors.
 * See LICENSE for distribution and usage details.
 */
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qr_widget/qr_widget.dart';

void main() {
  testWidgets('QrPainter generates correct image', (WidgetTester tester) async {
    final QrPainter painter = QrPainter(
      data: 'The painter is this thing',
      version: QrVersions.auto,
      gapless: true,
      errorCorrectionLevel: QrErrorCorrectLevel.L,
    );
    ByteData? imageData;
    await tester.runAsync(() async {
      imageData = await painter.toImageData(600.0);
    });
    final Uint8List imageBytes = imageData!.buffer.asUint8List();
    final Widget widget = Center(
      child: RepaintBoundary(
        child: SizedBox(
          width: 600,
          height: 600,
          child: Image.memory(imageBytes),
        ),
      ),
    );
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(RepaintBoundary),
      matchesGoldenFile('./.golden/qr_painter_golden.png'),
    );
  });
}
