import 'package:rxdart/rxdart.dart';

import '../../ptp_ip/discovery/ptp_ip_camera_discovery_adapter.dart';
import 'camera_discovery_event.dart';
import 'upnp/upnp_discovery_adapter.dart';

class CameraDiscoveryService {
  final UpnpDiscoveryAdapter upnpDiscoveryAdapter;

  CameraDiscoveryService({
    UpnpDiscoveryAdapter? upnpDiscoveryAdapter,
  }) : upnpDiscoveryAdapter = upnpDiscoveryAdapter ?? UpnpDiscoveryAdapter();

  Stream<CameraDiscoveryEvent> discover() {
    return MergeStream([
      PtpIpCameraDiscoveryAdapter(upnpDiscoveryAdapter).discover(),
    ]);
  }
}
