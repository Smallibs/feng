import 'package:feng/core/types.dart';
import 'package:feng/specs/monad.dart' as specs;
import 'package:feng/standard/reader/applicative.dart';
import 'package:feng/standard/reader/reader.dart';

class Monad<F, E> extends specs.MonadWithPureAndApply<ReaderK<F, E>> {
  final specs.Monad<F> _inner;

  Monad(this._inner) : super(Applicative(_inner));

  @override
  HKP<ReaderK<F, E>, B> bind<A, B>(
    HKP<ReaderK<F, E>, A> ma,
    Fun<A, HKP<ReaderK<F, E>, B>> f,
  ) =>
      Reader((e) => _inner.bind(ma.run(e), (a) => f(a).run(e)));
}
