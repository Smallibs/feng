import 'package:feng/core/types.dart';
import 'package:feng/specs/applicative.dart' as specs;
import 'package:feng/specs/functor.dart' as specs;
import 'package:feng/specs/monad.dart' as specs;
import 'package:feng/standard/identity/identity.dart' as identity;
import 'package:feng/standard/reader/applicative.dart' show Applicative;
import 'package:feng/standard/reader/functor.dart';
import 'package:feng/standard/reader/monad.dart';

sealed class ReaderK<F, E> {
  // Unsafe part but sealed capability reduces to zero any risk of bad cast!
  static Reader<F, E, A> fix<F, E, A>(HKP<ReaderK<F, E>, A> ma) =>
      ma as Reader<F, E, A>;
}

extension Invoke<F, E, A> on HKP<ReaderK<F, E>, A> {
  HKP<F, A> run(E e) => ReaderK.fix(this).run(e);
}

final class Reader<F, E, A> extends HKP<ReaderK<F, E>, A> {
  final Fun<E, HKP<F, A>> run;

  Reader(this.run);
}

class OverMonad<F, E> {
  final specs.Monad<F> _inner;

  OverMonad(this._inner);

  specs.Functor<ReaderK<F, E>> functor() => Functor(_inner);

  specs.Applicative<ReaderK<F, E>> applicative() => Applicative(_inner);

  specs.Monad<ReaderK<F, E>> monad() => Monad(this._inner);
}

final class Over<E> extends OverMonad<identity.IdentityK, E> {
  Over() : super(identity.Api.monad);
}
