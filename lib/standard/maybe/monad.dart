import 'package:feng/core/types.dart';
import 'package:feng/specs/monad.dart' as specs;
import 'package:feng/standard/maybe/maybe.dart';

class Monad extends specs.MonadWithPureAndApply<MaybeK> {
  const Monad() : super(Api.applicative);

  @override
  HKP<MaybeK, B> bind<A, B>(HKP<MaybeK, A> ma, Fun<A, HKP<MaybeK, B>> f) =>
      ma.fold(f, Maybe.none);
}
