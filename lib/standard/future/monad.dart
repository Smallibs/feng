import 'package:feng/core/types.dart';
import 'package:feng/specs/monad.dart' as specs;
import 'package:feng/standard/future/future.dart';

class Monad extends specs.MonadWithPureAndApply<FutureK> {
  const Monad() : super(Api.applicative);

  @override
  HKP<FutureK, B> bind<A, B>(HKP<FutureK, A> ma, Fun<A, HKP<FutureK, B>> f) =>
      FutureK.of(FutureK.fix(ma).then((a) => FutureK.fix(f(a))));
}
