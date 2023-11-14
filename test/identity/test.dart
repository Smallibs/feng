import 'package:feng/standard/identity/identity.dart';
import 'package:test/test.dart';

void main() {
  test('should perform a map', () {
    // Given
    final ma = Identity.id(1);

    // When
    final mb = Api.functor.map((i) => i + 1, ma);

    // Then
    expect(mb, Identity.id(2));
  });

  test('should perform an apply', () {
    // Given
    final ma = Identity.id(1);

    // When
    final mb = Api.applicative.apply(Identity.id((int i) => i + 1), ma);

    // Then
    expect(mb, Identity.id(2));
  });

  test('should perform a bind', () {
    // Given
    final ma = Identity.id(1);

    // When
    final mb = Api.monad.bind(ma, (i) => Identity.id(i + 1));

    // Then
    expect(mb, Identity.id(2));
  });
}
