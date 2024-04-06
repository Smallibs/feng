import 'package:feng/core/types.dart';
import 'package:feng/specs/applicative.dart' as specs;
import 'package:feng/specs/functor.dart' as specs;
import 'package:feng/specs/monad.dart' as specs;
import 'package:feng/standard/maybe/applicative.dart';
import 'package:feng/standard/maybe/functor.dart';
import 'package:feng/standard/maybe/monad.dart';

final class Api {
  static const specs.Functor<MaybeK> functor = Functor();
  static const specs.Applicative<MaybeK> applicative = Applicative();
  static const specs.Monad<MaybeK> monad = Monad();

  static Maybe<A> some<A>(A b) => _Some(b);

  static Maybe<A> none<A>() => _None();
}

sealed class MaybeK {}

sealed class Maybe<A> implements HKP<MaybeK, A> {}

final class _Some<A> implements Maybe<A> {
  final A _value;

  _Some(this._value);

  @override
  String toString() => 'Some($_value)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _Some &&
          runtimeType == other.runtimeType &&
          _value == other._value;

  @override
  int get hashCode => _value.hashCode;
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

extension MaybeFold<A> on HKP<MaybeK, A> {
  B fold<B>(Fun<A, B> some, Supplier<B> none) {
    // Unsafe part but sealed capability reduces to zero any risk of bad cast!
    switch (this as Maybe<A>) {
      case _Some(_value: var value):
        return some(value);
      case _None():
        return none();
    }
  }
}
