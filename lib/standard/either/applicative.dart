import 'package:feng/core/types.dart';
import 'package:feng/specs/applicative.dart' as specs;
import 'package:feng/standard/either/either.dart';
import 'package:feng/standard/either/functor.dart';

class Applicative<E> extends specs.ApplicativeWithMap<EitherK<E>> {
  final Functor<E> functor = Functor();

  @override
  HKP<EitherK<E>, A> pure<A>(A a) => Either.right(a);

  @override
  HKP<EitherK<E>, B> apply<A, B>(
          HKP<EitherK<E>, B Function(A)> mf, HKP<EitherK<E>, A> ma) =>
      mf.fold(
          Either.left, (f) => ma.fold(Either.left, (a) => Either.right(f(a))));
}
