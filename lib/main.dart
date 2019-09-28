import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_samples/bmi_calculator_app/bmi_calculator_app.dart';
import 'package:flutter_samples/bmi_calculator_app/bmi_model.dart';
import 'package:flutter_samples/custom_paint_app/custom_paint_app.dart';
import 'package:flutter_samples/date_time_picker_app/date_time_picker_app.dart';
import 'package:flutter_samples/flutter_bloc/bloc_counter_app/bloc_counter_app.dart';
import 'package:flutter_samples/flutter_bloc/bloc_fifaplayers_search_app/bloc_fifaplayers_search_app.dart';
import 'package:flutter_samples/future_builder_app/future_builder_app.dart';
import 'package:flutter_samples/gesture_inkwell_app/gesture_inkwell_app.dart';
import 'package:flutter_samples/grid_list_app/grid_list_app.dart';
import 'package:flutter_samples/image_picker_app/image_picker_app.dart';
import 'package:flutter_samples/note_keeper_app/note_list.dart';
import 'package:flutter_samples/pageview_box_animation_app/pageview_box_animation_app.dart';
import 'package:flutter_samples/provider_counter_app/provider_counter_app.dart';
import 'package:flutter_samples/provider_counter_app/provider_counter_bloc.dart';
import 'package:flutter_samples/provider_cryptocurrency_list/crypto_provider.dart';
import 'package:flutter_samples/provider_cryptocurrency_list/provider_cryptocurrency_list.dart';
import 'package:flutter_samples/provider_shopper_app/provider_shopper_app.dart';
import 'package:flutter_samples/provider_shopper_app/shopper_cart.dart';
import 'package:flutter_samples/provider_shopper_app/shopper_cart_model.dart';
import 'package:flutter_samples/provider_shopper_app/shopper_catalog_model.dart';
import 'package:flutter_samples/provider_web_api_app/cat_facts_list.dart';
import 'package:flutter_samples/provider_web_api_app/cat_store.dart';
import 'package:flutter_samples/sliver_list_app/sliver_list_app.dart';
import 'package:flutter_samples/sticky_header_sliverlist_app/sticky_header_sliverlist_app.dart';
import 'package:flutter_samples/ui/image_clipping_app/image_clipping_app.dart';
import 'package:flutter_samples/ui/story_ui_app/story_ui_app.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProviderBloc>.value(value: ProviderBloc()),
        Provider(
          builder: (BuildContext context) => ShopperCatalogModel(),
        ),
        ChangeNotifierProxyProvider<ShopperCatalogModel, ShopperCartModel>(
          builder: (context, catalog, previousCart) =>
              ShopperCartModel(catalog, previousCart),
        ),
        ChangeNotifierProvider(
          builder: (BuildContext context) => CatsStore(),
        ),
        ChangeNotifierProvider(
          builder: (BuildContext context) => BMIModel(),
        ),
        ChangeNotifierProvider(
          builder: (BuildContext context) => CryptoProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Samples',
        theme: ThemeData(
          fontFamily: 'Lato',
          primarySwatch: Colors.blue,
          buttonColor: Colors.deepOrange,
        ),
        routes: {
          "/": (BuildContext context) => DashboardScreen(),
          "/sliverListApp": (BuildContext context) => SliverListApp(),
          "/noteKeeperApp": (BuildContext context) => NoteKeeperApp(),
          "/blocCounterApp": (BuildContext context) => BlocCounterApp(),
          "/blocFifaPlayersSearchApp": (BuildContext context) =>
              FifaPlayerSearchApp(),
          "/providerCounterApp": (BuildContext context) => ProviderCounterApp(),
          "/providerShopperApp": (BuildContext context) => ProviderShopperApp(),
          "/providerShopperCart": (BuildContext context) => ShopperCart(),
          "/providerWebApiApp": (BuildContext context) => ProviderWebApiApp(),
          "/stickyHeaderSliverListApp": (BuildContext context) =>
              StickyHeaderSliverListApp(),
          "/bmiCalculatorApp": (BuildContext context) => BMICalculatorApp(),
          "/providerWithFutureBuilderApp": (BuildContext context) =>
              ProviderWithFutureBuilderApp(),
          "/dateTimePickerApp": (BuildContext context) => DateTimePickerApp(),
          "/storyUIApp": (BuildContext context) => StoryUIApp(),
          "/imageClippingApp": (BuildContext context) => ImageClippingApp(),
          "/gridListApp": (BuildContext context) => GridListApp(),
          "/gestureInkwellApp": (BuildContext context) => GestureInkwellApp(),
          "/futureBuilderApp": (BuildContext context) => FutureBuilderApp(),
          "/pageViewBoxAnimationApp": (BuildContext context) =>
              PageViewBoxAnimationApp(),
          "/customPaintApp": (BuildContext context) => CustomPaintApp(),
        },
        onGenerateRoute: (RouteSettings settings) {
          if (settings.name == "/imagePickerApp") {
            // Cast the arguments to the correct type: ScreenArguments.
            final args = settings.arguments;

            // Then, extract the required data from the arguments and
            // pass the data to the correct screen.
            return MaterialPageRoute(
              builder: (context) {
                return ImagePickerApp(
                  title: "ImagePicker App",
                );
              },
            );
          }
        },
      ),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var routes = [
    "/imagePickerApp",
    "/sliverListApp",
    "/sliverListApp",
    "/gridListApp",
    "/stickyHeaderSliverListApp",
    "/gestureInkwellApp",
    "/bmiCalculatorApp",
    "/noteKeeperApp",
    "/blocCounterApp",
    "/blocFifaPlayersSearchApp",
    "/providerCounterApp",
    "/providerShopperApp",
    "/providerWebApiApp",
    "/futureBuilderApp",
    "/providerWithFutureBuilderApp",
    "/dateTimePickerApp",
    "/storyUIApp",
    "/imageClippingApp",
    "/customPaintApp",
    "/pageViewBoxAnimationApp",
  ];
  var routeName = [
    "Image Picker App",
    "Sliver Grid List App",
    "Sliver List App",
    "Grid List App",
    "Sticky Header Sliver List App",
    "Gestures & Inkwell App",
    "BMI Calculator App",
    "Note Keeper App",
    "Bloc Counter App",
    "Bloc Fifa Players Search App",
    "Provider Counter App",
    "Provider Shopper App",
    "Provider Web API App",
    "FutureBuilderApp",
    "Provider - FutureBuilder App",
    "DateTimePicker App",
    "Story UI App",
    "Image Clipper App",
    "Custom Paint App",
    "PageView Box Animation App",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: GridView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2,
            ),
            itemCount: routes.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.all(5.0),
                child: RaisedButton(
                  color: Colors.primaries[index % Colors.primaries.length],
                  child: Text(
                    routeName[index],
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    if (index == 0) {
                      Navigator.of(context).pushNamed("/imagePickerApp",
                          arguments: "ImagePicker App");
                    } else if (index == 1) {
                      print("Grid");
                      Navigator.of(context)
                          .pushNamed("/sliverListApp", arguments: false);
//                            Navigator.of(context).pushNamed("/sliverListApp",arguments: ScreenArguments(false));
                    } else if (index == 2) {
                      print("List");
                      Navigator.of(context)
                          .pushNamed("/sliverListApp", arguments: true);
//                            Navigator.of(context).pushNamed("/sliverListApp",arguments: ScreenArguments(true));
                    } else {
                      Navigator.of(context).pushNamed(routes[index]);
                    }
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ScreenArguments {
  final bool isNormalList;

  ScreenArguments(this.isNormalList);
}
