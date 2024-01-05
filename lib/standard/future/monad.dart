import 'package:feng/core/types.dart';
import 'package:feng/specs/monad.dart' as specs;
import 'package:feng/standard/future/future.dart';

class Monad extends specs.MonadWithPureAndApply<FutureK> {
  const Monad() : super(Api.applicative);

  // This solution do not use `.then(...)` since it's not safe in Dart!
  @override
  HKP<FutureK, B> bind<A, B>(HKP<FutureK, A> ma, Fun<A, HKP<FutureK, B>> f) =>
      FutureK.of(_bind(FutureK.fix(ma), (a) => FutureK.fix(f(a))));

  Future<B> _bind<A, B>(Future<A> ma, Fun<A, Future<B>> f) async {
    final a = await ma;
    final b = await f(a);
    return b;
  }
}
