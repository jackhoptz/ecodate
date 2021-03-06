import 'package:ecodate/database/database_manager.dart';
import 'package:ecodate/database/database_provider.dart';
import 'package:ecodate/database/entity.dart';
import 'package:ecodate/entities/character.dart';
import 'package:ecodate/entities/dialogue.dart';
import 'package:ecodate/entities/expression.dart';
import 'package:ecodate/entities/segment.dart';
import 'package:ecodate/pages/scenario_runner/game_page.dart';
import 'package:ecodate/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Widget _buildApp(BuildContext context) {
    return MaterialApp(
      title: 'ecodate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      onGenerateRoute: (RouteSettings settings) {
        return EcodateRouter.buildRoute(
          context,
          settings,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DatabaseProvider(
      child: _buildApp(context),
      manager: DatabaseManager(databaseName: 'ecodate.db'),
      entityProviders: [
        EntityProvider(builder: () => CharacterInfo.factoryDefault()),
        EntityProvider(builder: () => DialogueInfo.factoryDefault()),
        EntityProvider(builder: () => FlagOption.factoryDefault()),
        EntityProvider(builder: () => ExpressionInfo.factoryDefault()),
        EntityProvider(builder: () => Segment.factoryDefault()),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Home Screen',
            ),
            Text(
              'Nothing here yet',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final SceneInfo sceneInfo = SceneInfo(
            initialSegmentId: 1,
            backgroundName: 'assets/img/default_background.png',
          );
          Navigator.of(context)
              .pushReplacementNamed('/game', arguments: sceneInfo);
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
