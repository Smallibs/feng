import 'package:feng/core/types.dart';
import 'package:feng/standard/future/future.dart';
import 'package:test/test.dart';

void main() {
  test('should perform a map', () async {
    // Given
    final ma = Api.success(1);

    // When
    final mb = Api.functor.map((i) => i + 1, ma);

    // Then
    expect(await FutureK.fix(mb), 2);
  });

  test('should not perform a map', () async {
    // Given
    final error = Error();
    final ma = Api.failure<int>(error);

    // When
    final mb = Api.functor.map((i) => i + 1, ma);

    // Then
    expectThrown(mb, error);
  });

  test('should perform an apply', () async {
    // Given
    final ma = Api.success(1);

    // When
    final mb = Api.applicative.apply(Api.success((int i) => i + 1), ma);

    // Then
    expect(await FutureK.fix(mb), 2);
  });

  test('should not perform an apply 1/2', () async {
    // Given
    final error = Error();
    final mf = Api.failure<Fun<int, int>>(error);
    final ma = Api.success(1);

    // When
    final mb = Api.applicative.apply(mf, ma);

    // Then
    expectThrown(mb, error);
  });

  test('should not perform an apply 2/2', () async {
    // Given
    final error = Error();
    final mf = Api.success((int i) => i + 1);
    final ma = Api.failure<int>(error);

    // When
    final mb = Api.applicative.apply(mf, ma);

    // Then
    expectThrown(mb, error);
  });

  test('should perform a bind', () async {
    // Given
    final ma = Api.success(1);

    // When
    final mb = Api.monad.bind(ma, (i) => Api.success(i + 1));

    // Then
    expect(await FutureK.fix(mb), 2);
  });

  test('should not perform a bind 1/2', () async {
    // Given
    final error = Error();
    final ma = Api.failure<int>(error);

    // When
    final mb = Api.monad.bind(ma, (i) => Api.success(i + 1));

    // Then
    expectThrown(mb, error);
  });

  test('should not perform a bind 2/2', () async {
    // Given
    final error = Error();
    final ma = Api.success(1);

    // When
    final mb = Api.monad.bind(ma, (i) => Api.failure<int>(error));

    // Then
    expectThrown(mb, error);
  });
}

void expectThrown<A>(HKP<FutureK, A> mb, Error error) async {
  try {
    await FutureK.fix(mb);
    assert(false);
  } catch (e) {
    expect(e, error);
  }
}
