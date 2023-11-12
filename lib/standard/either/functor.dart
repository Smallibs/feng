import 'package:feng/core/fun.dart';
import 'package:feng/core/types.dart';
import 'package:feng/specs/functor.dart' as specs;
import 'package:feng/standard/either/either.dart';

class Functor<E> implements specs.Functor<EitherK<E>> {
  @override
  HKP<EitherK<E>, B> map<A, B>(Fun<A, B> f, HKP<EitherK<E>, A> ma) =>
      ma.fold(Either.left, f.then(Either.right));
}
