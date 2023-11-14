import 'package:feng/core/types.dart';

import 'package:feng/specs/applicative.dart' as specs;
import 'package:feng/specs/functor.dart' as specs;
import 'package:feng/specs/monad.dart' as specs;

import 'package:feng/standard/either/applicative.dart';
import 'package:feng/standard/either/functor.dart';
import 'package:feng/standard/either/monad.dart';

final class Api {
  static specs.Functor<EitherK<E>> functor<E>() => Functor();

  static specs.Applicative<EitherK<E>> applicative<E>() => Applicative();

  static specs.Monad<EitherK<E>> monad<E>() => Monad();

  static Either<E, A> right<E, A>(A a) => _Right(a);

  static Either<E, A> left<E, A>(E e) => _Left(e);
}

sealed class EitherK<E> {
  // Unsafe part but sealed capability reduces to zero any risk of bad cast!
  static Either<E, A> fix<E, A>(HKP<EitherK<E>, A> ma) => ma as Either<E, A>;
}

sealed class Either<E, A> implements HKP<EitherK<E>, A> {}

final class _Left<E, A> implements Either<E, A> {
  final E _e;

  _Left(this._e);

  @override
  String toString() => 'Left($_e)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _Left && runtimeType == other.runtimeType && _e == other._e;

  @override
  int get hashCode => _e.hashCode;
}

final class _Right<E, A> implements Either<E, A> {
  final A _a;

  _Right(this._a);

  @override
  String toString() => 'Right($_a)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _Right && runtimeType == other.runtimeType && _a == other._a;

  @override
  int get hashCode => _a.hashCode;
}

extension FoldExtension<E, A> on HKP<EitherK<E>, A> {
  B fold<B>(Fun<E, B> left, Fun<A, B> right) {
    switch (EitherK.fix(this)) {
      case _Left(_e: var e):
        return left(e);
      case _Right(_a: var a):
        return right(a);
    }
  }
}
