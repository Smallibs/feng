import 'package:feng/core/types.dart';
import 'package:feng/specs/monad.dart' as specs;
import 'package:feng/standard/identity/identity.dart';

class Monad extends specs.MonadWithPureAndApply<IdentityK> {
  const Monad() : super(Api.applicative);

  @override
  HKP<IdentityK, B> bind<A, B>(
          HKP<IdentityK, A> ma, Fun<A, HKP<IdentityK, B>> f) =>
      ma.fold(f);
}
