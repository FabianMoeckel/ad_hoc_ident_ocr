import 'ocr_image.dart';

/// Tries to extract text data from an [OcrImage].
abstract class OcrTextExtractor {
  /// Extracts text data from an [OcrImage].
  Future<List<List<String>>?> extract(OcrImage ocrImage);

  /// Releases resources held by the ocr engine.
  Future<void> close();
}
