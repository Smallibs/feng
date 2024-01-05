import 'package:feng/core/types.dart';
import 'package:feng/specs/applicative.dart' as specs;
import 'package:feng/standard/future/future.dart';

class Applicative extends specs.ApplicativeWithPureAndApply<FutureK> {
  const Applicative();

  @override
  HKP<FutureK, A> pure<A>(A a) => FutureK.of(Future(() => a));

  // This solution do not use `.then(...)` since it's not safe in Dart!
  @override
  HKP<FutureK, B> apply<A, B>(HKP<FutureK, Fun<A, B>> mf, HKP<FutureK, A> ma) =>
      FutureK.of(_apply(FutureK.fix(mf), FutureK.fix(ma)));

  Future<B> _apply<A, B>(Future<Fun<A, B>> mf, Future<A> ma) async {
    final f = await mf;
    final a = await ma;
    return f(a);
  }
}
