import 'package:feng/core/types.dart';
import 'package:feng/specs/functor.dart' as specs;
import 'package:feng/standard/reader/reader.dart';

class Functor<F, E> implements specs.Functor<ReaderK<F, E>> {
  final specs.Functor<F> _inner;

  Functor(this._inner);

  @override
  HKP<ReaderK<F, E>, B> map<A, B>(Fun<A, B> f, HKP<ReaderK<F, E>, A> ma) =>
      Reader((it) => _inner.map(f, ma.run(it)));
}
