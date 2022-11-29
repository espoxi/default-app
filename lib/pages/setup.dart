import 'package:espoxiapp/common/persistence.dart';
import 'package:espoxiapp/config.dart';
import 'package:espoxiapp/connection.dart';
import 'package:espoxiapp/data/wifi.dart';
import 'package:espoxiapp/pages/loading.dart';
import 'package:espoxiapp/widgets/settings/ip.dart';
import 'package:flutter/material.dart';

import 'home.dart';

const WIFICREDENTIALPATH = 'wificredentials';
const ADDRESSPATH = 'address';

class SetupPage extends StatelessWidget {
  const SetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: retrieveRaw(ADDRESSPATH),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            switch (snapshot.data) {
              case null:
              case '':
                return const ActualSetupPage();
              default:
                return const HomePage();
            }
          } else {
            return const LoadingPage();
          }
        });
  }
}

class ActualSetupPage extends StatefulWidget {
  const ActualSetupPage({super.key});

  @override
  State<ActualSetupPage> createState() => _ActualSetupPageState();
}

enum __ActualSetupPageStateState {
  initial,
  loading,
  connected,
  failed,
}

class _ActualSetupPageState extends State<ActualSetupPage> {
  bool isOnCredentialView = false;
  bool isOnAddressView = false;
  String? address;
  __ActualSetupPageStateState state = __ActualSetupPageStateState.initial;
  String? ssid;
  String? psk;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setup'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 100),
              child: Container(
                height: isOnCredentialView ? 0 : null,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                        "please turn on your espoxi and connect to its wifi"),
                    Text(
                        "its name should be something like ${WIFI_CREDS.ssid}"),
                  ],
                ),
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 100),
              child: Container(
                height: isOnCredentialView ? null : 0,
                child: Form(
                  key: _formKey,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  isOnCredentialView = false;
                                  isOnAddressView = false;
                                });
                              },
                              icon: const Icon(Icons.arrow_back),
                            ),
                            Expanded(
                              child: Text(!isOnAddressView
                                  ? "please enter your wifi credentials"
                                  : "well then, where is the espoxi?.. \n(press enter when you're done)"),
                            ),
                            if (!isOnAddressView)
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      isOnAddressView = true;
                                    });
                                  },
                                  child: const Text("skip")),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (!isOnAddressView)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              onSaved: (value) {
                                ssid = value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Yo dawg, you need to enter how your wifi is called';
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'SSID',
                              ),
                            ),
                          ),
                        if (!isOnAddressView)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              onSaved: (value) {
                                psk = value;
                              },
                              validator: (value) {
                                return null;
                              },
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              textInputAction: TextInputAction.done,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Password",
                              ),
                            ),
                          ),
                        if (isOnAddressView)
                          IPSettings(
                            key: const ValueKey('address'),
                            onSaved: onAddressSaved,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: _indicator,
            ),
          ],
        ),
      ),
    );
  }

  onAddressSaved(value) {
    address = value;
    IPSettings.defaultOnSaved(value);
    done();
  }

  Widget get _indicator {
    switch (state) {
      case __ActualSetupPageStateState.initial:
        return (!isOnAddressView)
            ? TextButton(
                onPressed: () {
                  if (!isOnCredentialView) {
                    setState(() {
                      isOnCredentialView = true;
                    });
                    return;
                  }
                  done();
                },
                child: const Text("I'm done"),
              )
            : const SizedBox.shrink();
      case __ActualSetupPageStateState.loading:
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ),
        );
      case __ActualSetupPageStateState.connected:
        return const Icon(Icons.check, color: Colors.green);
      case __ActualSetupPageStateState.failed:
        return const Icon(Icons.close, color: Colors.red);
    }
  }

  Future<void> done() async {
    if (isOnAddressView) {
      setState(() {
        state = __ActualSetupPageStateState.loading;
      });
      if (address == null) {
        _failed();
        return;
      }
      var _address = await Connection().checkConnection(address!);
      if (_address == null) {
        _failed();
        return;
      }
      setState(() {
        state = __ActualSetupPageStateState.connected;
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
      return;
    }
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        state = __ActualSetupPageStateState.loading;
      });
      if (ssid == null) {
        _failed();
        return;
      }
      var creds = Credentials(ssid: ssid!, psk: psk);
      var address = await Connection().connectEspoxiToWifi(creds);
      if (address == null) {
        _failed();
        return;
      }
      setState(() {
        state = __ActualSetupPageStateState.connected;
      });
      // await Future.delayed(const Duration(milliseconds: 100));
      await store(creds, WIFICREDENTIALPATH);
      await storeRaw(address.address, ADDRESSPATH);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  Future _failed() async {
    setState(() {
      state = __ActualSetupPageStateState.failed;
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      state = __ActualSetupPageStateState.initial;
    });
    return;
  }
}
