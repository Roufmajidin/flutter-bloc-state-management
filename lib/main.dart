import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rouf_state_management_bloc/data/api_endpoints.dart';
import 'package:rouf_state_management_bloc/data/repository/comment_repository.dart';

import 'data/bloc/comment/comment_bloc.dart';
import 'data/bloc/comment/comment_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(providers: [
        BlocProvider<CommentBloc>(
          create: (context) => CommentBloc()
            ..add(
                FetchComments()), // Menambahkan event FetchComments saat membuat Bloc
        ),
      ], child: const MyHomePage(title: 'Flutter Demo Home Page')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final commentBloc = BlocProvider.of<CommentBloc>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Comments')),
      body: BlocBuilder<CommentBloc, CommentState>(
        builder: (context, state) {
          if (state is CommentLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CommentLoaded) {
            final comments = state.comments;

            return ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                return ListTile(
                  title: Text(comment.name),
                  subtitle: Text(comment.email),
                  // ... other widgets for displaying the comment data
                );
              },
            );
          } else if (state is CommentError) {
            return Center(child: Text(state.failure.message));
          } else {
            return Center(child: Text("Something went wrong."));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          commentBloc.add(FetchComments());
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
