import 'package:feng/core/types.dart';
import 'package:feng/standard/maybe/maybe.dart';
import 'package:test/test.dart';

void main() {
  test('should perform a map', () {
    // Given
    final ma = Maybe.some(1);

    // When
    final mb = Api.functor.map((i) => i + 1, ma);

    // Then
    expect(mb, Maybe.some(2));
  });

  test('should not perform a map', () {
    // Given
    final ma = Maybe.none();

    // When
    final mb = Api.functor.map((i) => i + 1, ma);

    // Then
    expect(mb, Maybe.none());
  });

  test('should perform an apply', () {
    // Given
    final ma = Maybe.some(1);

    // When
    final mb = Api.applicative.apply(Maybe.some((int i) => i + 1), ma);

    // Then
    expect(mb, Maybe.some(2));
  });

  test('should not perform an apply 1/2', () {
    // Given
// Given
    final ma = Maybe.some(1);

    // When
    final mb = Api.applicative.apply(Maybe.none<Fun<int, int>>(), ma);

    // Then
    expect(mb, Maybe.none<int>());
  });

  test('should not perform an apply 2/2', () {
    // Given
    final ma = Maybe.none<int>();

    // When
    final mb = Api.applicative.apply(Maybe.some((int i) => i + 1), ma);

    // Then
    expect(mb, Maybe.none<int>());
  });

  test('should perform a bind', () {
    // Given
    final ma = Maybe.some(1);

    // When
    final mb = Api.monad.bind(ma, (i) => Maybe.some(i + 1));

    // Then
    expect(mb, Maybe.some(2));
  });

  test('should not perform a bind 1/2', () {
    // Given
    final ma = Maybe.none<int>();

    // When
    final mb = Api.monad.bind(ma, (i) => Maybe.some(i + 1));

    // Then
    expect(mb, Maybe.none<int>());
  });

  test('should not perform a bind 2/2', () {
    // Given
    final ma = Maybe.some(1);

    // When
    final mb = Api.monad.bind(ma, (i) => Maybe.none<int>());

    // Then
    expect(mb, Maybe.none<int>());
  });
}
