import 'package:ad_hoc_ident/ad_hoc_ident.dart';

import 'ocr_identity_parser.dart';
import 'ocr_image.dart';
import 'ocr_text_extractor.dart';

/// Tries to detect an [AdHocIdentity] from an [OcrImage].
class OcrIdentityDetector implements AdHocIdentityDetector<OcrImage> {
  /// The [OcrTextExtractor] used to extract text data from an image.
  final OcrTextExtractor extractor;

  /// The [OcrIdentityParser] used to convert the extracted text
  /// data to an [AdHocIdentity].
  final OcrIdentityParser parser;

  /// Creates an [OcrIdentityDetector] using the supplied [extractor]
  /// and [parser] for its processing.
  OcrIdentityDetector({required this.extractor, required this.parser});

  /// Hands over a [OcrImage] to the [extractor] and [parser].
  ///
  /// If the [extractor] returns [null], the [parser] is not invoked.
  @override
  Future<AdHocIdentity?> detect(OcrImage ocrImage) async {
    final blocksAndLines = await extractor.extract(ocrImage);
    if (blocksAndLines == null) {
      return null;
    }
    final identity = await parser.parse(blocksAndLines);
    return identity;
  }
}
