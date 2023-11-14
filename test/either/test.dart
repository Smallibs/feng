import 'package:feng/core/types.dart';
import 'package:feng/standard/either/either.dart';
import 'package:test/test.dart';

void main() {
  test('should perform a map', () {
    // Given
    final ma = Api.right(1);

    // When
    final mb = Api.functor().map((i) => i + 1, ma);

    // Then
    expect(mb, Api.right(2));
  });

  test('should not perform a map', () {
    // Given
    final ma = Api.left("Error");

    // When
    final mb = Api.functor<String>().map((i) => i + 1, ma);

    // Then
    expect(mb, Api.left("Error"));
  });

  test('should perform an apply', () {
    // Given
    final ma = Api.right(1);

    // When
    final mb = Api.applicative().apply(Api.right((int i) => i + 1), ma);

    // Then
    expect(mb, Api.right(2));
  });

  test('should not perform an apply 1/2', () {
    // Given
    final ma = Api.left<String, int>("Error");

    // When
    final mb = Api.applicative<String>().apply(Api.right((int i) => i + 1), ma);

    // Then
    expect(mb, Api.left<String, int>("Error"));
  });

  test('should not perform an apply 2/2', () {
    // Given
    final ma = Api.right<String, int>(42);

    // When
    final mb = Api.applicative<String>()
        .apply(Api.left<String, Fun<int, int>>("Error"), ma);

    // Then
    expect(mb, Api.left<String, int>("Error"));
  });

  test('should perform a bind', () {
    // Given
    final ma = Api.right<String, int>(1);

    // When
    final mb = Api.monad<String>().bind(ma, (i) => Api.right(i + 1));

    // Then
    expect(mb, Api.right<String, int>(2));
  });

  test('should not perform a bind 1/2', () {
    // Given
    final ma = Api.left<String, int>("Error");

    // When
    final mb = Api.monad<String>().bind(ma, (i) => Api.right(i + 1));

    // Then
    expect(mb, Api.left<String, int>("Error"));
  });

  test('should not perform a bind 2/2', () {
    // Given
    final ma = Api.right<String, int>(1);

    // When
    final mb =
        Api.monad<String>().bind(ma, (i) => Api.left<String, int>("Error"));

    // Then
    expect(mb, Api.left<String, int>("Error"));
  });
}
