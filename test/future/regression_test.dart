import 'package:feng/core/types.dart';
import 'package:test/test.dart';

Future<B> apply<A, B>(Future<Fun<A, B>> f, Future<A> a) async {
  final vf = await f;
  final va = await a;
  return vf(va);
}

void main() {
  test('should not perform an apply', () async {
    // Given
    final error = Error();

    // When
    final mb = apply<int, int>(
      Future(() => (int i) => i + 1),
      Future(() => throw error),
    );

    // Then
    try {
      await mb;
      assert(false);
    } catch (e) {
      expect(e, error);
    }
  });
}
