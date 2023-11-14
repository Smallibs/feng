import 'package:feng/core/fun.dart';
import 'package:feng/core/types.dart';
import 'package:feng/specs/functor.dart' as specs;
import 'package:feng/standard/try/try.dart';

class Functor implements specs.Functor<TryK> {
  const Functor();

  @override
  HKP<TryK, B> map<A, B>(Fun<A, B> f, HKP<TryK, A> ma) =>
      ma.fold(f.then(Try.success), Try.failure);
}
