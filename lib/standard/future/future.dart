import 'package:feng/core/types.dart';
import 'package:feng/specs/applicative.dart' as specs;
import 'package:feng/specs/functor.dart' as specs;
import 'package:feng/specs/monad.dart' as specs;
import 'package:feng/standard/future/applicative.dart';
import 'package:feng/standard/future/functor.dart';
import 'package:feng/standard/future/monad.dart';

final class Api {
  static const specs.Functor<FutureK> functor = Functor();
  static const specs.Applicative<FutureK> applicative = Applicative();
  static const specs.Monad<FutureK> monad = Monad();

  static HKP<FutureK, A> success<A>(A a) => FutureK.of(Future(() => a));

  static HKP<FutureK, A> failure<A>(Object e) =>
      FutureK.of(Future(() => throw e));
}

sealed class FutureK {
  // Unsafe part but sealed capability reduces to zero any risk of bad cast!
  static Future<A> fix<A>(HKP<FutureK, A> ma) => (ma as _Future<A>)._value;

  static HKP<FutureK, A> of<A>(Future<A> future) => _Future(future);
}

final class _Future<A> extends HKP<FutureK, A> {
  final Future<A> _value;

  _Future(this._value);
}
