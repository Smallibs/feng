import 'package:feng/core/types.dart';
import 'package:feng/standard/maybe/maybe.dart';
import 'package:test/test.dart';

void main() {
  test('should perform a map', () {
    // Given
    final ma = Api.some(1);

    // When
    final mb = Api.functor.map((i) => i + 1, ma);

    // Then
    expect(mb, Api.some(2));
  });

  test('should not perform a map', () {
    // Given
    final ma = Api.none();

    // When
    final mb = Api.functor.map((i) => i + 1, ma);

    // Then
    expect(mb, Api.none());
  });

  test('should perform an apply', () {
    // Given
    final ma = Api.some(1);

    // When
    final mb = Api.applicative.apply(Api.some((int i) => i + 1), ma);

    // Then
    expect(mb, Api.some(2));
  });

  test('should not perform an apply 1/2', () {
    // Given
// Given
    final ma = Api.some(1);

    // When
    final mb = Api.applicative.apply(Api.none<Fun<int, int>>(), ma);

    // Then
    expect(mb, Api.none<int>());
  });

  test('should not perform an apply 2/2', () {
    // Given
    final ma = Api.none<int>();

    // When
    final mb = Api.applicative.apply(Api.some((int i) => i + 1), ma);

    // Then
    expect(mb, Api.none<int>());
  });

  test('should perform a bind', () {
    // Given
    final ma = Api.some(1);

    // When
    final mb = Api.monad.bind(ma, (i) => Api.some(i + 1));

    // Then
    expect(mb, Api.some(2));
  });

  test('should not perform a bind 1/2', () {
    // Given
    final ma = Api.none<int>();

    // When
    final mb = Api.monad.bind(ma, (i) => Api.some(i + 1));

    // Then
    expect(mb, Api.none<int>());
  });

  test('should not perform a bind 2/2', () {
    // Given
    final ma = Api.some(1);

    // When
    final mb = Api.monad.bind(ma, (i) => Api.none<int>());

    // Then
    expect(mb, Api.none<int>());
  });
}
