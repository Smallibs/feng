import 'package:feng/core/types.dart';
import 'package:feng/specs/applicative.dart' as specs;
import 'package:feng/specs/functor.dart' as specs;
import 'package:feng/specs/monad.dart' as specs;
import 'package:feng/standard/identity/applicative.dart';
import 'package:feng/standard/identity/functor.dart';
import 'package:feng/standard/identity/monad.dart';

final class Api {
  static const specs.Functor<IdentityK> functor = Functor();
  static const specs.Applicative<IdentityK> applicative = Applicative();
  static const specs.Monad<IdentityK> monad = Monad();

  static HKP<IdentityK, A> id<A>(A a) => Identity(a);
}

sealed class IdentityK {
  // Unsafe part but sealed capability reduces to zero any risk of bad cast!
  static Identity<A> fix<A>(HKP<IdentityK, A> ma) => ma as Identity<A>;
}

final class Identity<A> implements HKP<IdentityK, A> {
  final A _value;

  Identity(this._value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Identity &&
          runtimeType == other.runtimeType &&
          _value == other._value;

  @override
  int get hashCode => _value.hashCode;

  @override
  String toString() {
    return 'Identity($_value)';
  }
}

extension FoldExtension<A> on HKP<IdentityK, A> {
  B fold<B>(Fun<A, B> f) => f(IdentityK.fix(this)._value);
}
