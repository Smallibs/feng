import 'package:feng/core/types.dart';

mixin MaybeK {
  // Unsafe part!
  static Maybe<A> fix<A>(HKP<MaybeK, A> ma) => ma as Maybe<A>;
}

mixin Maybe<A> implements HKP<MaybeK, A> {
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
    final self = MaybeK.fix(this);

    if (self is _Some<A>) {
      return some(self._a);
    } else {
      return none();
    }
  }
}