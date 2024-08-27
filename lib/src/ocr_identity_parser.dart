import 'package:ad_hoc_ident/ad_hoc_ident.dart';

/// Tries to parse text data to an [AdHocIdentity].
abstract class OcrIdentityParser {
  /// Analyses text data to extract an [AdHocIdentity].
  ///
  /// The text data should be supplied as a list of text blocks,
  /// each consisting of a list of its lines. Depending on the
  /// [OcrTextExtractor] implementation, this might be a single block.
  Future<AdHocIdentity?> parse(List<List<String>> blocksAndLines);
}
