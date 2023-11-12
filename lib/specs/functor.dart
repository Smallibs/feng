import 'package:feng/core/types.dart';

abstract class Functor<M> {
  HKP<M, B> map<A, B>(Fun<A, B> f, HKP<M, A> ma);

  (Functor<M>, HKP<M, A>) infix<A>(HKP<M, A> ma) => (this, ma);
}

extension FunctorExtension<M, A> on (Functor<M>, HKP<M, A>) {
  (Functor<M>, HKP<M, B>) map<B>(Fun<A, B> f) => ($1, $1.map(f, $2));
}
