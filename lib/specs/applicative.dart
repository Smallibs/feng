import 'package:feng/core/types.dart';
import 'package:feng/specs/functor.dart';

abstract class Applicative<M> extends Functor<M> {
  HKP<M, A> pure<A>(A a);

  HKP<M, B> apply<A, B>(HKP<M, Fun<A, B>> mf, HKP<M, A> ma);

  @override
  (Applicative<M>, HKP<M, A>) infix<A>(HKP<M, A> ma) => (this, ma);
}

extension ApplicativeExtension<M, A, B> on (Applicative<M>, HKP<M, Fun<A, B>>) {
  (Applicative<M>, HKP<M, B>) apply(HKP<M, A> ma) => ($1, $1.apply($2, ma));
}
