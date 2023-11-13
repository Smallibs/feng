import 'package:feng/core/types.dart';
import 'package:feng/standard/either/either.dart';
import 'package:test/test.dart';

void main() {
  test('should perform a map', () {
    // Given
    final ma = Either.right(1);

    // When
    final mb = Either.functor().map((i) => i + 1, ma);

    // Then
    expect(mb, Either.right(2));
  });

  test('should not perform a map', () {
    // Given
    final ma = Either.left("Error");

    // When
    final mb = Either.functor<String>().map((i) => i + 1, ma);

    // Then
    expect(mb, Either.left("Error"));
  });

  test('should perform an apply', () {
    // Given
    final ma = Either.right(1);

    // When
    final mb = Either.applicative().apply(Either.right((int i) => i + 1), ma);

    // Then
    expect(mb, Either.right(2));
  });

  test('should not perform an apply 1/2', () {
    // Given
    final ma = Either.left<String, int>("Error");

    // When
    final HKP<EitherK<String>, int> mb =
        Either.applicative<String>().apply(Either.right((int i) => i + 1), ma);

    // Then
    expect(mb, Either.left<String, int>("Error"));
  });

  test('should not perform an apply 2/2', () {
    // Given
    final ma = Either.right<String, int>(42);

    // When
    final HKP<EitherK<String>, int> mb = Either.applicative<String>()
        .apply(Either.left<String, Fun<int, int>>("Error"), ma);

    // Then
    expect(mb, Either.left<String, int>("Error"));
  });

  test('should perform a bind', () {
    // Given
    final ma = Either.right<String, int>(1);

    // When
    final mb = Either.monad<String>().bind(ma, (i) => Either.right(i + 1));

    // Then
    expect(mb, Either.right<String, int>(2));
  });

  test('should not perform a bind 1/2', () {
    // Given
    final ma = Either.left<String, int>("Error");

    // When
    final mb = Either.monad<String>().bind(ma, (i) => Either.right(i + 1));

    // Then
    expect(mb, Either.left<String, int>("Error"));
  });

  test('should not perform a bind 2/2', () {
    // Given
    final ma = Either.right<String, int>(1);

    // When
    final mb = Either.monad<String>()
        .bind(ma, (i) => Either.left<String, int>("Error"));

    // Then
    expect(mb, Either.left<String, int>("Error"));
  });
}
