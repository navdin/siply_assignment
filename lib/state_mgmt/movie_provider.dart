import 'package:flutter_riverpod/all.dart';
import 'package:movie_app/models/MinorDetails.dart';

class InitialData {
  List<MinorDetails> listMovies = [];
  String genrePressed = "None";
}

class InitialDataNotifier extends StateNotifier<InitialData> {
  InitialDataNotifier(InitialData initialData)
      : super(initialData ?? InitialData());

  InitialData initialData = InitialData();

  void changeData(InitialData newData) {
    state = newData;
  }

  void printData() {
    print("printData initialData.listMovies.length=" +
        initialData.listMovies.length.toString());
  }
}

final initialDataProvider = StateNotifierProvider<InitialDataNotifier>((ref) {
  return InitialDataNotifier(InitialData());
});

// void main() {
//   runApp(ProviderScope(child: MyApp()));
// }
//
// //to watch the provider:
// Consumer(
// // Rebuild only the Text when counterProvider updates
// builder: (context, watch, child) {
// // Listens to the value exposed by counterProvider
// var state_provider = watch(counterProvider.state);
// return Text('$count');
// },
// )
//
// //to read the provider:
// StateNotifierProvider:
// context.read(counterProvider.state);
//
// //to read provider out of context:
// Use "ProviderContainer" to access the provider or its state and read or modify accordingly.
//
// To read and modify state:
// final container = ProviderContainer();
// var filterState = container.read(filterProvider);
// filterState.changeData(filterData);
