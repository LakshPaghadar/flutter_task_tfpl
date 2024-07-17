/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/1.png
  AssetGenImage get a1 => const AssetGenImage('assets/images/1.png');

  /// File path: assets/images/2.png
  AssetGenImage get a2 => const AssetGenImage('assets/images/2.png');

  /// File path: assets/images/3.png
  AssetGenImage get a3 => const AssetGenImage('assets/images/3.png');

  /// File path: assets/images/back_1.png
  AssetGenImage get back1 => const AssetGenImage('assets/images/back_1.png');

  /// File path: assets/images/back_2.png
  AssetGenImage get back2 => const AssetGenImage('assets/images/back_2.png');

  /// File path: assets/images/back_3.png
  AssetGenImage get back3 => const AssetGenImage('assets/images/back_3.png');

  /// File path: assets/images/drawer_1.png
  AssetGenImage get drawer1 =>
      const AssetGenImage('assets/images/drawer_1.png');

  /// File path: assets/images/drawer_2.png
  AssetGenImage get drawer2 =>
      const AssetGenImage('assets/images/drawer_2.png');

  /// File path: assets/images/drawer_3.png
  AssetGenImage get drawer3 =>
      const AssetGenImage('assets/images/drawer_3.png');

  /// File path: assets/images/location_1.png
  AssetGenImage get location1 =>
      const AssetGenImage('assets/images/location_1.png');

  /// File path: assets/images/location_2.png
  AssetGenImage get location2 =>
      const AssetGenImage('assets/images/location_2.png');

  /// File path: assets/images/location_3.png
  AssetGenImage get location3 =>
      const AssetGenImage('assets/images/location_3.png');

  /// File path: assets/images/plus_1.png
  AssetGenImage get plus1 => const AssetGenImage('assets/images/plus_1.png');

  /// File path: assets/images/plus_2.png
  AssetGenImage get plus2 => const AssetGenImage('assets/images/plus_2.png');

  /// File path: assets/images/plus_3.png
  AssetGenImage get plus3 => const AssetGenImage('assets/images/plus_3.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        a1,
        a2,
        a3,
        back1,
        back2,
        back3,
        drawer1,
        drawer2,
        drawer3,
        location1,
        location2,
        location3,
        plus1,
        plus2,
        plus3
      ];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
