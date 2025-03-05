import 'dart:async';

import 'package:camera_control_dart/camera_control_dart.dart';
import 'package:camera_control_dart/src/ptp_ip/discovery/ptp_ip_discovery_handle.dart';

import '../../common/discovery/camera_discovery_adapter.dart';
import '../../common/discovery/camera_discovery_event.dart';
import '../../common/discovery/upnp/upnp_advertisement_message.dart';
import '../../common/discovery/upnp/upnp_discovery_adapter.dart';
import '../logging/ptp_ip_logger.dart';

class PtpIpCameraDiscoveryAdapter extends CameraDiscoveryAdapter {
  static const ptpIpService = 'upnp:rootdevice';
  final UpnpDiscoveryAdapter upnpDiscoveryAdapter;

  final logger = PtpIpLogger();

  PtpIpCameraDiscoveryAdapter(this.upnpDiscoveryAdapter);

  @override
  Stream<CameraDiscoveryEvent> discover() {
    return upnpDiscoveryAdapter.discover().transform(
      StreamTransformer.fromHandlers(
        handleData: (upnpMessage, sink) async {
          if (upnpMessage is UpnpAdvertisementAlive) {
            if (upnpMessage.serviceType != ptpIpService) {
              return;
            }

            final deviceDescription = await upnpDiscoveryAdapter
                .getDeviceDescription(upnpMessage.location);
            if (deviceDescription == null) {
              return;
            }

            final model = CameraModel(
                identifier: deviceDescription.uniqueDeviceName,
                name: deviceDescription.friendlyName,
                protocol: CameraControlProtocol.PtpIp);

            logger.logCameraAlive(deviceDescription.uniqueDeviceName);

            sink.add(CameraDiscoveryEvent.alive(
              handle: PtpIpDiscoveryHandle(
                address: deviceDescription.address,
                id: deviceDescription.uniqueDeviceName,
                model: model,
              ),
            ));
          } else if (upnpMessage is UpnpAdvertisementByeBye) {
            if (upnpMessage.serviceType != ptpIpService) {
              return;
            }

            logger.logCameraByeBye(upnpMessage.uniqueDeviceName);

            sink.add(CameraDiscoveryEvent.byeBye(
              id: upnpMessage.uniqueDeviceName,
            ));
          }
        },
      ),
    );
  }
}
