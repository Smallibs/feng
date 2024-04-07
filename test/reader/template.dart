import 'package:feng/core/types.dart';
import 'package:feng/standard/reader/reader.dart';

sealed class Template {}

class Document extends Template {
  final Template lhd;
  final Template rhd;

  Document(this.lhd, this.rhd);
}

class Text extends Template {
  final String content;

  Text(this.content);
}

class Variable extends Template {
  final String name;

  Variable(this.name);
}

class Evaluators {
  static Fun<Template, HKP<ReaderK<F, Map<String, String>>, String>>
      toStringUsing<F>(OverMonad<F, Map<String, String>> api) =>
          (template) => switch (template) {
                Document d => api.monad.bind(
                    toStringUsing(api)(d.lhd),
                    (lhd) => api.functor
                        .map((rhd) => lhd + rhd, toStringUsing(api)(d.rhd))),
                Text t => api.monad.returns(t.content),
                Variable v =>
                  api.functor.map((m) => m[v.name] ?? "N/A", api.ask)
              };
}
