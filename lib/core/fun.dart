import 'package:feng/core/types.dart';

extension FunExtension<A, B> on Fun<A, B> {
  Fun<C, B> compose<C>(Fun<C, A> g) => (C x) => this(g(x));

  Fun<A, C> pipe<C>(Fun<B, C> f) => (A x) => f(this(x));

  Fun<A, C> then<C>(Fun<B, C> f) => this.pipe(f);
}
