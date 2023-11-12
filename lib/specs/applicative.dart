import 'package:feng/core/types.dart';
import 'package:feng/specs/functor.dart';

mixin Applicative<M> on Functor<M> {
  HKP<M, A> pure<A>(A a);

  HKP<M, B> apply<A, B>(HKP<M, Fun<A, B>> mf, HKP<M, A> ma);
}

abstract class ApplicativeWithMap<M> implements Applicative<M> {
  @override
  HKP<M, B> map<A, B>(Fun<A, B> f, HKP<M, A> ma) => apply(pure(f), ma);
}

extension ApplicativeInfix<M> on Applicative<M> {
  (Applicative<M>, HKP<M, A>) infix<A>(HKP<M, A> ma) => (this, ma);
}

extension ApplyExtension<E extends Applicative<M>, M, A, B> on (
  E,
  HKP<M, Fun<A, B>>,
) {
  (E, HKP<M, B>) apply(HKP<M, A> ma) => ($1, $1.apply($2, ma));
}
