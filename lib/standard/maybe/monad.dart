import 'package:feng/core/types.dart';
import 'package:feng/specs/monad.dart' as specs;
import 'package:feng/standard/maybe/maybe.dart';

class Monad extends specs.MonadWithPureAndApply<MaybeK> {
  const Monad();

  @override
  HKP<MaybeK, B> bind<A, B>(HKP<MaybeK, A> ma, Fun<A, HKP<MaybeK, B>> f) =>
      ma.fold(f, Maybe.none);

  // Delegation for pure and apply

  @override
  HKP<MaybeK, A> pure<A>(A a) => Maybe.applicative.pure(a);

  @override
  HKP<MaybeK, B> apply<A, B>(HKP<MaybeK, Fun<A, B>> mf, HKP<MaybeK, A> ma) =>
      Maybe.applicative.apply(mf, ma);
}
