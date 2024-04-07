import 'package:feng/standard/identity/identity.dart';
import 'package:feng/standard/reader/reader.dart';
import 'package:test/test.dart';

import 'template.dart';

void main() {
  test('should perform template transformation', () {
    // Given
    final api = Over<Map<String, String>>();
    final example = Document(Text("Hello "), Variable("who"));

    // When
    final mb = api.monad
        .bind(api.monad.returns(example), Evaluators.toStringUsing(api))
        .run({'who': "World!"});

    // Then
    expect(mb, Api.id("Hello World!"));
  });
}
