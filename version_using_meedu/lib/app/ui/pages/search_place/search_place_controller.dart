import 'dart:async';

import 'package:flutter/widgets.dart' show FocusNode, TextEditingController;
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:google_maps/app/domain/models/place.dart';
import 'package:google_maps/app/domain/repositories/search_repository.dart';
import 'package:google_maps/app/helpers/current_position.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchPlaceArguments {
  final Place? initialOrigin, initialDestination;
  final bool hasOriginFocus;

  SearchPlaceArguments({
    this.initialOrigin,
    this.initialDestination,
    required this.hasOriginFocus,
  });
}

class SearchPlaceController extends SimpleNotifier {
  final SearchRepository _searchRepository = Get.i.find<SearchRepository>();

  String _query = '';
  String get query => _query;

  late StreamSubscription _subscription;

  List<Place>? _places = [];
  List<Place>? get places => _places;
  
  Place _origin = Place(
    id: 'here:cm:namedplace:27015237',
    address: 'El Carmen, Manabí, Ecuador',
    distance: 33177,
    position: const LatLng(-0.37639, -79.50111),
    title: 'El Carmen, Manabí, Ecuador'
  );
  Place? _destination;

  Place? get origin => _origin;
  Place? get destination => _destination;

  final originFocusNode = FocusNode();
  final destinationFocusNode = FocusNode();

  final originController = TextEditingController();
  final destinationController = TextEditingController();

  late bool _originHasFocus;
  bool get originHasFocus => _originHasFocus;

  SearchPlaceController(SearchPlaceArguments arguments) {
    _originHasFocus = arguments.hasOriginFocus;

    // _origin = arguments.initialOrigin;
    _destination = arguments.initialDestination;

    // if (_origin != null) {
    //   originController.text = _origin!.title;
    // }

    if (_destination != null) {
      destinationController.text = _destination!.title;
    }

    _subscription = _searchRepository.onResults.listen(
      (results) {
        _places = results;
        notify();
      },
    );

    // originFocusNode.addListener(() {
    //   if (originFocusNode.hasFocus && !_originHasFocus) {
    //     _onOriginFocusNodeChanged(true);
    //   } else if (!originFocusNode.hasFocus && _origin == null) {
    //     originController.text = '';
    //   }
    // });

    destinationFocusNode.addListener(() {
      if (destinationFocusNode.hasFocus && _originHasFocus) {
        _onOriginFocusNodeChanged(false);
      } else if (!destinationFocusNode.hasFocus && _destination == null) {
        destinationController.text = '';
      }
    });
  }

  Timer? _debouncer;

  void _onOriginFocusNodeChanged(bool hasFocus) {
    _originHasFocus = hasFocus;
    _places = [];
    _query = '';
    notify();
  }

  void setInitialFocus() {
    if (_originHasFocus) {
      destinationFocusNode.requestFocus();
    } else {
      originFocusNode.requestFocus();
    }
  }

  void onQueryChanged(String text) {
    _query = text;
    _debouncer?.cancel();
    _debouncer = Timer(
      const Duration(milliseconds: 500),
      () {
        if (_query.length >= 3) {
          // print("🎃 Call to API $query");
          final currentPosition = CurrentPosition.i.value;
          if (currentPosition != null) {
            _searchRepository.cancel();
            _searchRepository.search(query, currentPosition);
          }
        } else {
          // print("🎃 cancel API call");
          clearQuery();
        }
      },
    );
  }

  void clearQuery() {
    _searchRepository.cancel();
    _places = [];
    if (!_originHasFocus) {
      _destination = null;
    }
    // else {
    //   _origin = null;
    // }
    notify();
  }

  void pickPlace(Place place) {
    if (_originHasFocus) {
      _origin = place;
      originController.text = place.title;
    } else {
      _destination = place;
      destinationController.text = place.title;
    }
    notify();
  }

  @override
  void dispose() {
    originController.dispose();
    destinationController.dispose();
    originFocusNode.dispose();
    destinationFocusNode.dispose();
    _debouncer?.cancel();
    _subscription.cancel();
    _searchRepository.dispose();
    Get.i.remove<SearchRepository>();
    super.dispose();
  }
}
