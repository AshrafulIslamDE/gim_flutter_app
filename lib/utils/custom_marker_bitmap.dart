import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:customer/utils/ui_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerBitmap {
  ui.Image pikUpImage;
  ui.Image dropOfImage;
  double defaultPad = 20.0;

  CustomMarkerBitmap() {
    init();
  }

  Future<Null> init() async {
    final ByteData srcData =
        await rootBundle.load('images/2.0x/pickup_pin.png');
    pikUpImage = await loadImage(new Uint8List.view(srcData.buffer));
    final ByteData dstData =
        await rootBundle.load('images/2.0x/dropoff_pin.png');
    dropOfImage = await loadImage(new Uint8List.view(dstData.buffer));
  }

  Future<ui.Image> loadImage(List<int> img) async {
    final Completer<ui.Image> completer = new Completer();
    ui.decodeImageFromList(img, (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

  Future<BitmapDescriptor> createCustomMarkerBitmap(
      String address, bool isSrc, {double size}) async {
    Color color = isSrc
        ? ColorResource.colorMarineBlue
        : ColorResource.colorLightMarineBlue;
    PictureRecorder recorder = new PictureRecorder();
    Canvas c = new Canvas(recorder);

    final TextStyle style = TextStyle(
      color: Colors.white,
      fontSize: 28.0,
      fontWeight: FontWeight.w500,
    );

    final TextPainter tp = TextPainter(
        text: TextSpan(
            text: address, //Space characters added to give left right padding
            style: style), // TextSpan could be whole TextSpans tree :)
        textAlign: TextAlign.center,
        maxLines: 2,
        textDirection: TextDirection.ltr)
      ..layout(maxWidth: size-defaultPad);
    c.drawRect(
        Rect.fromLTRB(0.0, 0.0, tp.width + defaultPad, tp.height + defaultPad),
        Paint()..color = color);
    tp.paint(c, Offset(defaultPad / 2, defaultPad / 2));

    c.drawImage(isSrc ? pikUpImage : dropOfImage,
        new Offset((tp.width-pikUpImage.width/2) / 2, tp.height + defaultPad), new Paint());

    Picture p = recorder.endRecording();
    ByteData pngBytes = await (await p.toImage(
            tp.width.toInt() + defaultPad.toInt(),
            tp.height.toInt() + pikUpImage.height + 40 + defaultPad.toInt()))
        .toByteData(format: ImageByteFormat.png);

    Uint8List data = Uint8List.view(pngBytes.buffer);

    return BitmapDescriptor.fromBytes(data);
  }
}
