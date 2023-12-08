import 'package:feng/core/fun.dart';
import 'package:feng/core/types.dart';
import 'package:feng/specs/functor.dart';

mixin Applicative<M> {
  HKP<M, A> pure<A>(A a);

  HKP<M, (A, B)> product<A, B>(HKP<M, A> ma, HKP<M, B> mb);

  HKP<M, B> apply<A, B>(HKP<M, Fun<A, B>> mf, HKP<M, A> ma);
}

abstract class ApplicativeWithPureAndApply<M> implements Applicative<M> {
  const ApplicativeWithPureAndApply();

  @override
  HKP<M, (A, B)> product<A, B>(HKP<M, A> ma, HKP<M, B> mb) =>
      apply(map(curry((A a, B b) => (a, b)), ma), mb);

  @override
  HKP<M, B> map<A, B>(Fun<A, B> f, HKP<M, A> ma) => apply(pure(f), ma);
}

extension ApplyExtension<E extends Applicative<M>, M, A, B> on (
  E,
  HKP<M, Fun<A, B>>
) {
  (E, HKP<M, B>) apply(HKP<M, A> ma) => ($1, $1.apply($2, ma));
}
