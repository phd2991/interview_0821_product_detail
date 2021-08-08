import 'package:flutter/widgets.dart';

class Helpers {
  Helpers._();
}

extension StringExtension on String {
  static const needleRegex = r'{#}';
  static const needle = '{#}';
  static final RegExp exp = new RegExp(needleRegex);

  String interpolate(List l) {
    Iterable<RegExpMatch> matches = exp.allMatches(this);

    assert(l.length == matches.length);

    var i = -1;
    return this.replaceAllMapped(exp, (match) {
      i = i + 1;
      return '${l[i]}';
    });
  }
}

extension ListExtension<T> on List<T> {
  List<Widget> addGap<T extends Widget>({
    required Widget gap,
    Widget itemBuilder(T)?,
    bool addAtTop = false,
    bool addAtLast = false,
  }) {
    if (itemBuilder == null) {
      itemBuilder = (_) => _;
    }
    var result = this
        .expand((item) sync* {
          yield gap;
          yield itemBuilder!(item);
        })
        .skip(addAtTop ? 0 : 1)
        .toList();
    if (addAtLast) result.add(gap);
    return result;
  }
}
