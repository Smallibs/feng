import 'package:feng/standard/identity/identity.dart';
import 'package:test/test.dart';

void main() {
  test('should perform a map', () {
    // Given
    final ma = Api.id(1);

    // When
    final mb = Api.functor.map((i) => i + 1, ma);

    // Then
    expect(mb, Api.id(2));
  });

  test('should perform an apply', () {
    // Given
    final ma = Api.id(1);

    // When
    final mb = Api.applicative.apply(Api.id((int i) => i + 1), ma);

    // Then
    expect(mb, Api.id(2));
  });

  test('should perform a bind', () {
    // Given
    final ma = Api.id(1);

    // When
    final mb = Api.monad.bind(ma, (i) => Api.id(i + 1));

    // Then
    expect(mb, Api.id(2));
  });
}
