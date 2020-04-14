import 'package:flutter/widgets.dart';

abstract class BasePage extends StatefulWidget {
  BasePage({Key key}) : super(key: key);
}

abstract class BasePageState<Page extends BasePage> extends State<Page> {
  String title() => '';
}
