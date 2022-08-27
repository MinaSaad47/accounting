import 'dart:io';

class ServerScanner {
  static Future<List<String>> getServers({
    required int port,
    void Function(int)? onProgress,
  }) async {
    List<String> servers = [];
    var nics = await NetworkInterface.list();
    for (var n in nics) {
      var address = n.addresses[1].address;
      var subnet = address.substring(1, address.lastIndexOf('.'));
      for (int i = 2; i < 255; i++) {
        if (onProgress != null) {
          onProgress(i);
        }
        var host = '$subnet.$i';
        await Socket.connect(host, port,
                timeout: const Duration(milliseconds: 50))
            .then((socket) async {
          await InternetAddress(socket.address.address).reverse().then((host) {
            servers.add(host.address);
          }).catchError((error) => null);
          socket.destroy();
        }).catchError((error) => null);
      }
    }
    return servers;
  }
}
