import 'package:feng/core/fun.dart';
import 'package:feng/core/types.dart';
import 'package:feng/specs/applicative.dart' as specs;
import 'package:feng/standard/reader/reader.dart';

class Applicative<F, E>
    extends specs.ApplicativeWithPureAndApply<ReaderK<F, E>> {
  final specs.Applicative<F> _inner;

  Applicative(this._inner);

  @override
  HKP<ReaderK<F, E>, A> pure<A>(A a) => Reader(constant(_inner.pure(a)));

  @override
  HKP<ReaderK<F, E>, B> apply<A, B>(
    HKP<ReaderK<F, E>, Fun<A, B>> mf,
    HKP<ReaderK<F, E>, A> ma,
  ) =>
      Reader((it) => _inner.apply(mf.run(it), (ma.run(it))));
}
