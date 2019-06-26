import 'package:breed_list/bloc/bloc.dart';
import 'package:breed_list/breed_list/breed_widget.dart';
import 'package:breed_list/repository/breed_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'data_provider/breed_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Breed List',
      theme: ThemeData(primaryColor: Colors.white),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Breed List"),
        ),
        body: BlocProvider(
          builder: (context) => BreedBloc(
              BreedRepository(BreedProvider(httpClient: http.Client())))
            ..dispatch(FetchBreedEvent()),
          child: MyHomePage(title: "List"),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  BreedBloc _breedBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScrol);
    _breedBloc = BlocProvider.of<BreedBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _breedBloc,
      builder: (BuildContext context, BreedState state) {
        if (state is BreedUninitialized) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is BreedLoaded) {
          if (state.breeds.isEmpty) {
            return Center(
              child: Text("No breeds available"),
            );
          }
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return index >= state.breeds.length
                  ? BottomLoader()
                  : BreedWidget(breed: state.breeds[index]);
            },
            itemCount: state.hasReachedMax
                ? state.breeds.length
                : state.breeds.length + 1,
            controller: _scrollController,
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScrol() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (maxScroll - currentScroll <= _scrollThreshold) {
      _breedBloc.dispatch(FetchBreedEvent());
    }
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}
