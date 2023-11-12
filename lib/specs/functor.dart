import 'package:feng/core/types.dart';

mixin Functor<M> {
  HKP<M, B> map<A, B>(Fun<A, B> f, HKP<M, A> ma);
}

extension FunctorInfix<M> on Functor<M> {
  (Functor<M>, HKP<M, A>) infix<A>(HKP<M, A> ma) => (this, ma);
}

extension FunctorExtension<E extends Functor<M>, M, A> on (
  E,
  HKP<M, A>,
) {
  (E, HKP<M, B>) map<B>(Fun<A, B> f) => ($1, $1.map(f, $2));
}
