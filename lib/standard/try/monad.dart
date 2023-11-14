import 'package:feng/core/types.dart';
import 'package:feng/specs/monad.dart' as specs;
import 'package:feng/standard/try/try.dart';

class Monad extends specs.MonadWithPureAndApply<TryK> {
  const Monad() : super(Api.applicative);

  @override
  HKP<TryK, B> bind<A, B>(HKP<TryK, A> ma, Fun<A, HKP<TryK, B>> f) =>
      ma.fold(f, Try.failure);
}
