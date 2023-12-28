import 'package:feng/core/types.dart';

extension FunExtension<A, B> on Fun<A, B> {
  Fun<C, B> compose<C>(Fun<C, A> g) => (C x) => this(g(x));

  Fun<A, C> pipe<C>(Fun<B, C> f) => (A x) => f(this(x));

  Fun<A, C> then<C>(Fun<B, C> f) => this.pipe(f);
}

Fun<A, Fun<B, C>> curry<A, B, C>(Fun2<A, B, C> f) => (a) => (b) => f(a, b);

A id<A>(A a) => a;

Fun<E, A> constant<E, A>(A a) => (_) => a;
