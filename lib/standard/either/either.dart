import 'package:feng/core/types.dart';

mixin EitherK<E> {
  // Unsafe part!
  static Either<E, A> fix<E, A>(HKP<EitherK<E>, A> ma) => ma as Either<E, A>;
}

mixin Either<E, A> implements HKP<EitherK<E>, A> {
  static Either<E, A> left<E, A>(E e) => _Left(e);

  static Either<E, A> right<E, A>(A a) => _Right(a);
}

class _Left<E, A> implements Either<E, A> {
  final E _e;

  _Left(this._e);

  @override
  String toString() => 'Left($_e)';
}

class _Right<E, A> implements Either<E, A> {
  final A _a;

  _Right(this._a);

  @override
  String toString() => 'Right($_a)';
}

extension Foldable<E, A> on HKP<EitherK<E>, A> {
  B fold<B>(Fun<E, B> left, Fun<A, B> right) {
    final self = EitherK.fix(this);

    if (self is _Left<E, A>) {
      return left(self._e);
    } else if (self is _Right<E, A>) {
      return right(self._a);
    }

    throw Error();
  }
}
