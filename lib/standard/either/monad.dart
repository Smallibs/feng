import 'package:feng/core/types.dart';
import 'package:feng/specs/monad.dart' as specs;
import 'package:feng/standard/either/either.dart';
import 'package:feng/standard/either/applicative.dart';

class Monad<E> implements specs.Monad<EitherK<E>> {
  final Applicative<E> applicative = Applicative();

  @override
  HKP<EitherK<E>, A> returns<A>(A a) => applicative.pure(a);

  @override
  HKP<EitherK<E>, B> bind<A, B>(
          HKP<EitherK<E>, A> ma, Fun<A, HKP<EitherK<E>, B>> f) =>
      ma.fold(Either.left, f);

  // Delegation

  @override
  HKP<EitherK<E>, B> apply<A, B>(
          HKP<EitherK<E>, B Function(A)> mf, HKP<EitherK<E>, A> ma) =>
      applicative.apply(mf, ma);

  @override
  HKP<EitherK<E>, B> map<A, B>(Fun<A, B> f, HKP<EitherK<E>, A> ma) =>
      applicative.map(f, ma);

  @override
  HKP<EitherK<E>, A> pure<A>(A a) => applicative.pure(a);
}
