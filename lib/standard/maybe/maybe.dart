import 'package:feng/core/types.dart';

import 'package:feng/specs/applicative.dart' as specs;
import 'package:feng/specs/functor.dart' as specs;
import 'package:feng/specs/monad.dart' as specs;

import 'package:feng/standard/maybe/functor.dart';
import 'package:feng/standard/maybe/applicative.dart';
import 'package:feng/standard/maybe/monad.dart';

final class Api {
  static const specs.Functor<MaybeK> functor = Functor();
  static const specs.Applicative<MaybeK> applicative = Applicative();
  static const specs.Monad<MaybeK> monad = Monad();

  static Maybe<A> some<A>(A b) => _Some(b);

  static Maybe<A> none<A>() => _None();
}

sealed class MaybeK {
  // Unsafe part but sealed capability reduces to zero any risk of bad cast!
  static Maybe<A> fix<A>(HKP<MaybeK, A> ma) => ma as Maybe<A>;
}

sealed class Maybe<A> implements HKP<MaybeK, A> {}

final class _Some<A> implements Maybe<A> {
  final A _a;

  _Some(this._a);

  @override
  String toString() => 'Some($_a)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _Some && runtimeType == other.runtimeType && _a == other._a;

  @override
  int get hashCode => _a.hashCode;
}

final class _None<A> implements Maybe<A> {
  @override
  String toString() => 'None';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _None && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

extension FoldExtension<A> on HKP<MaybeK, A> {
  B fold<B>(Fun<A, B> some, Supplier<B> none) {
    switch (MaybeK.fix(this)) {
      case _Some(_a: var a):
        return some(a);
      case _None():
        return none();
    }
  }
}
