import 'package:feng/core/types.dart';
import 'package:feng/standard/try/try.dart';
import 'package:test/test.dart';

void main() {
  test('should perform a map', () {
    // Given
    final ma = Try.success(1);

    // When
    final mb = Api.functor.map((i) => i + 1, ma);

    // Then
    expect(mb, Try.success(2));
  });

  test('should not perform a map', () {
    // Given
    final ma = Try.failure(Error());

    // When
    final mb = Api.functor.map((i) => i + 1, ma);

    // Then
    expect(mb, Try.failure(Error()));
  });

  test('should perform an apply', () {
    // Given
    final ma = Try.success(1);

    // When
    final mb = Api.applicative.apply(Try.success((int i) => i + 1), ma);

    // Then
    expect(mb, Try.success(2));
  });

  test('should not perform an apply 1/2', () {
    // Given
// Given
    final ma = Try.success(1);

    // When
    final mb = Api.applicative.apply(Try.failure<Fun<int, int>>(Error()), ma);

    // Then
    expect(mb, Try.failure<int>(Error()));
  });

  test('should not perform an apply 2/2', () {
    // Given
    final ma = Try.failure<int>(Error());

    // When
    final mb = Api.applicative.apply(Try.success((int i) => i + 1), ma);

    // Then
    expect(mb, Try.failure<int>(Error()));
  });

  test('should perform a bind', () {
    // Given
    final ma = Try.success(1);

    // When
    final mb = Api.monad.bind(ma, (i) => Try.success(i + 1));

    // Then
    expect(mb, Try.success(2));
  });

  test('should not perform a bind 1/2', () {
    // Given
    final ma = Try.failure(Error());

    // When
    final mb = Api.monad.bind(ma, (i) => Try.success(i + 1));

    // Then
    expect(mb, Try.failure(Error()));
  });

  test('should not perform a bind 2/2', () {
    // Given
    final ma = Try.success(1);

    // When
    final mb = Api.monad.bind(ma, (i) => Try.failure(Error()));

    // Then
    expect(mb, Try.failure(Error()));
  });
}
