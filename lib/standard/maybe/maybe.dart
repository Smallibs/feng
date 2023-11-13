import 'package:feng/core/types.dart';
import 'package:feng/standard/maybe/functor.dart';
import 'package:feng/standard/maybe/applicative.dart';
import 'package:feng/standard/maybe/monad.dart';

sealed class MaybeK {
  // Unsafe part but sealed capability reduces to zero any risk of bad cast!
  static Maybe<A> fix<A>(HKP<MaybeK, A> ma) => ma as Maybe<A>;
}

sealed class Maybe<A> implements HKP<MaybeK, A> {
  static const Functor functor = Functor();
  static const Applicative applicative = Applicative();
  static const Monad monad = Monad();

  static Maybe<A> some<A>(A b) => _Some(b);

  static Maybe<A> none<A>() => _None();
}

class _Some<A> implements Maybe<A> {
  final A _a;

  _Some(this._a);

  @override
  String toString() => 'Some($_a)';
}

class _None<A> implements Maybe<A> {
  @override
  String toString() => 'None';
}

extension Foldable<A> on HKP<MaybeK, A> {
  B fold<B>(Fun<A, B> some, Supplier<B> none) {
    switch (MaybeK.fix(this)) {
      case _Some(_a: var a):
        return some(a);
      case _None():
        return none();
    }
  }
}
