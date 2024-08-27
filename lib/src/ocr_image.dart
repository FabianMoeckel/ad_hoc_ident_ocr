import 'dart:typed_data';

/// The rotation of the device.
///
/// This is used to determine rotational adjustments to images before
/// processing.
enum DeviceOrientation {
  portraitUp,
  landscapeLeft,
  portraitDown,
  landscapeRight;

  /// Converts the enum value to rotation degrees.
  ///
  /// Possible resulting values are 0, 90, 180, and 270.
  int toInt() => switch (this) {
        DeviceOrientation.landscapeLeft => 0,
        DeviceOrientation.portraitUp => 90,
        DeviceOrientation.landscapeRight => 180,
        DeviceOrientation.portraitDown => 270,
      };

  /// Converts a value of rotation degrees to an enum value.
  ///
  /// Only exact matches to the enum values are allowed. Valid values are
  /// therefore 0, 90, 180 and 270.
  static DeviceOrientation fromInt(int value) => switch (value) {
        0 => DeviceOrientation.landscapeLeft,
        90 => DeviceOrientation.portraitUp,
        180 => DeviceOrientation.landscapeRight,
        270 => DeviceOrientation.portraitDown,
        _ => throw ArgumentError.value(value,
            'Invalid orientation value. Only 0, 90, 180 and 270 are permitted.')
      };
}

/// Representation of a native image's data needed for OCR,
/// expanded with necessary camera metadata.
///
/// If the native image uses a multi plane format, the image data needs to be
/// converted to a single plane format first.
class OcrImage {
  /// The binary data of the image.
  final Uint8List singlePlaneBytes;

  /// The length of one row of the binary data of the image.
  final int singlePlaneBytesPerRow;

  /// The width of the image.
  final int width;

  /// The height of the image.
  final int height;

  /// The [DeviceOrientation] of the camera while the image was taken.
  ///
  /// This should be set to [DeviceOrientation.portraitUp] if the image was
  /// not taken by the camera, e.g. if it was loaded from a file. This
  /// value is used to rotate the image before processing.
  final DeviceOrientation cameraSensorOrientation;

  /// Raw version of the platform specific format.
  /// On Android, this is an int from class android.graphics.ImageFormat.
  /// See https://developer.android.com/reference/android/graphics/ImageFormat
  /// <br> On iOS, this is a FourCharCode constant from Pixel Format Identifiers.
  /// See https://developer.apple.com/documentation/corevideo/1563591-pixel_format_identifiers?language=objc
  final dynamic rawImageFormat;

  /// Creates an [OcrImage] from a native image's data and camera metadata.
  ///
  /// The [singlePlaneBytes] and [singlePlaneBytesPerRow] define the binary
  /// structure of the image, while [width] and [height] refer to its bounds.
  /// The [cameraSensorOrientation] is required to adjust the image rotation.
  /// If the image was not created by the camera, this can be omitted.
  /// The [rawImageFormat] specifies a platform specific representation of
  /// the image format. For more information see the respective property.
  const OcrImage(
      {required this.singlePlaneBytes,
      required this.singlePlaneBytesPerRow,
      required this.width,
      required this.height,
      this.cameraSensorOrientation = DeviceOrientation.portraitUp,
      required this.rawImageFormat});
}
