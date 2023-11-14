import 'package:feng/core/types.dart';

import 'package:feng/specs/applicative.dart' as specs;
import 'package:feng/specs/functor.dart' as specs;
import 'package:feng/specs/monad.dart' as specs;

import 'package:feng/standard/try/functor.dart';
import 'package:feng/standard/try/applicative.dart';
import 'package:feng/standard/try/monad.dart';

final class Api {
  static const specs.Functor<TryK> functor = Functor();
  static const specs.Applicative<TryK> applicative = Applicative();
  static const specs.Monad<TryK> monad = Monad();
}

sealed class TryK {
  // Unsafe part but sealed capability reduces to zero any risk of bad cast!
  static Try<A> fix<A>(HKP<TryK, A> ma) => ma as Try<A>;
}

sealed class Try<A> implements HKP<TryK, A> {
  static Try<A> success<A>(A b) => _Success(b);

  static Try<A> failure<A>(Error error) => _Failure(error);
}

final class _Success<A> implements Try<A> {
  final A _a;

  _Success(this._a);

  @override
  String toString() => 'Some($_a)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _Success && runtimeType == other.runtimeType && _a == other._a;

  @override
  int get hashCode => _a.hashCode;
}

final class _Failure<A> implements Try<A> {
  final Error _e;

  _Failure(this._e);

  @override
  String toString() => 'None';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _Failure && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

extension FoldExtension<A> on HKP<TryK, A> {
  B fold<B>(Fun<A, B> success, Fun<Error, B> failure) {
    switch (TryK.fix(this)) {
      case _Success(_a: var a):
        return success(a);
      case _Failure(_e: var e):
        return failure(e);
    }
  }
}