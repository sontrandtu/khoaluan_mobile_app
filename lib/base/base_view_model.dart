import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

import '../repository/repository.dart';


typedef ErrorCallback = Function(String?);
typedef SuccessCallback = Function(dynamic);
typedef OnLoadedCallback = Function();

class BaseViewModel extends ChangeNotifier {
  final Repository repository;

  BaseViewModel(this.repository);

  bool _loading = false;

  set setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  set done(bool value) {
    doneSubject.value = true;
  }

  // set setMessage(Tuple2<MessageStatus, dynamic> value) {
  //   messageSubject.value = value;
  //   notifyListeners();
  // }
  //
  // final messageSubject = BehaviorSubject<Tuple2<MessageStatus, dynamic>>();
  //
  // Stream<Tuple2<MessageStatus, dynamic>> get messageStream => messageSubject.stream;

  final doneSubject = BehaviorSubject<bool>();

  Stream get doneStream => doneSubject.stream;

  get isLoading => _loading;

  @override
  void dispose() {
    //messageSubject.close();
    doneSubject.close();
    super.dispose();
  }
}
