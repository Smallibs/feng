import 'package:feng/core/types.dart';
import 'package:feng/specs/applicative.dart' as specs;
import 'package:feng/standard/future/future.dart';

class Applicative extends specs.ApplicativeWithPureAndApply<FutureK> {
  const Applicative();

  @override
  HKP<FutureK, A> pure<A>(A a) => FutureK.of(Future(() => a));

  @override
  HKP<FutureK, B> apply<A, B>(HKP<FutureK, Fun<A, B>> mf, HKP<FutureK, A> ma) =>
      FutureK.of(FutureK.fix(mf).then(FutureK.fix(ma).then));
}
