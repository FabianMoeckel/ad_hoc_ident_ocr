import 'dart:typed_data';

import 'package:ad_hoc_ident/src/ad_hoc_identity.dart';
import 'package:ad_hoc_ident_ocr/ad_hoc_ident_ocr.dart';
import 'package:test/test.dart';

class _OcrTextExtractorMock implements OcrTextExtractor {
  final List<List<String>>? testResult;

  _OcrTextExtractorMock(this.testResult);

  @override
  Future<void> close() {
    // TODO: implement close
    throw UnimplementedError();
  }

  @override
  Future<List<List<String>>?> extract(OcrImage ocrImage) async {
    return testResult;
  }
}

class _OcrIdentityParserMock implements OcrIdentityParser {
  @override
  Future<AdHocIdentity?> parse(List<List<String>> blocksAndLines) async {
    final flattendedToString = blocksAndLines
        .reduce(
          (value, element) => value.followedBy(element).toList(),
        )
        .reduce(
          (value, element) => value + element,
        );
    return AdHocIdentity(type: 'test', identifier: flattendedToString);
  }
}

void main() {
  test('passes lines detected by the extractor to the parser', () async {
    const testValue = 'testData';
    const testData = [
      [testValue]
    ];
    final extractorMock = _OcrTextExtractorMock(testData);
    final parserMock = _OcrIdentityParserMock();

    final mockImage = OcrImage(
        singlePlaneBytes: Uint8List.fromList([]),
        singlePlaneBytesPerRow: 1,
        width: 1,
        height: 1,
        rawImageFormat: 1);

    final detector =
        OcrIdentityDetector(extractor: extractorMock, parser: parserMock);
    final result = await detector.detect(mockImage);

    expect(result, isNotNull);
    expect(result!.identifier, testValue);
  });
}
