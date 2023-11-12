import 'package:feng/core/types.dart';

abstract class Maybe<A> extends HKP<Maybe, A> {
  // Unsafe part!
  static Maybe<A> fix<A>(HKP<Maybe, A> ma) => ma as Maybe<A>;

  static Maybe<A> some<A>(A b) => _Some(b);

  static Maybe<A> none<A>() => _None();
}

class _Some<A> extends Maybe<A> {
  final A _a;

  _Some(this._a);

  @override
  String toString() => 'Some($_a)';
}

class _None<A> extends Maybe<A> {
  @override
  String toString() => 'None';
}

extension Foldable<A> on HKP<Maybe, A> {
  B fold<B>(Fun<A, B> some, Supplier<B> none) {
    final self = Maybe.fix(this);

    if (self is _Some<A>) {
      return some(self._a);
    } else {
      return none();
    }
  }
}
