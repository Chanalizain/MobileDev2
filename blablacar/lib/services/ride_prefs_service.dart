import '../data/dummy_data.dart';
import '../model/ride_pref/ride_pref.dart';
import '../data/dummy_data.dart';

////
///   This service handles:
///   - History of the last ride preferences        (to allow users to re-use their last preferences)
///   - Curent selected ride preferences.
///
class RidePrefsService {
  static RidePref? selectedRidePref; // The current selected ride preference
  static List<RidePref> ridePrefsHistory = fakeRidePrefs;
}

class RidePrefChannel {
  RidePref? ridePref;

  final List<RidePrefChannelLitener> listener = [];

  void addListener(RidePrefChannelLitener newListener) {
    listener.add(newListener);
  }

  void setRidePref(RidePref newRidePref) {
    if (newRidePref != ridePref) {
      ridePref = newRidePref;
      notifyListener();
    }
  }

  void notifyListener() {
    for (RidePrefChannelLitener l in listener) {
      l.onPrefChanged(ridePref!);
    }
  }
}

abstract class RidePrefChannelLitener {
  void onPrefChanged(RidePref newRidePref);
}

class WebApp extends RidePrefChannelLitener {
  @override
  void onPrefChanged(RidePref newRidePref) {
    print(newRidePref);
  }
}

void main() {
  RidePrefChannel myChanel = RidePrefChannel();

  WebApp myListener = WebApp();
  myChanel.addListener(myListener);

  myChanel.setRidePref(fakeRidePrefs.first);
}
