import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:zego_calling_flutter/core/call_services.dart';
import 'package:zego_calling_flutter/main.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class MakeCallScreen extends StatefulWidget {
  const MakeCallScreen({super.key});

  @override
  _MakeCallScreenState createState() => _MakeCallScreenState();
}

class _MakeCallScreenState extends State<MakeCallScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();

  CallServices services = CallServices();
  @override
  void initState() {
    services.onUserLogin(
        userID: sharedPreferences!.getString('id')!,
        userName: sharedPreferences!.getString('userName')!);

    log('User ID:================ ${sharedPreferences!.getString('id')!}');
    log('User Name: ========================${sharedPreferences!.getString('userName')!}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: Text('Join a Call'),
        centerTitle: true,
        backgroundColor: theme.colorScheme.primaryContainer,
        foregroundColor: theme.colorScheme.onPrimaryContainer,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome 👋',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Enter your details to join a call',
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(Icons.person),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _userIdController,
              decoration: InputDecoration(
                labelText: 'User ID',
                prefixIcon: Icon(Icons.badge),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const Spacer(),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Details',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'User ID: ${sharedPreferences!.getString('id')!}',
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Username: ${sharedPreferences!.getString('userName')!}',
                      style: theme.textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (_usernameController.text.isEmpty ||
                        _userIdController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please fill all fields')),
                      );
                      return;
                    }
                    ZegoUIKitPrebuiltCallInvitationService().send(
                      isVideoCall: true,
                      resourceID: "zego_test",
                      invitees: [
                        ZegoCallUser(
                          _userIdController.text,
                          _usernameController.text,
                        ),
                      ],
                    );
                  },
                  child: Icon(Icons.video_call, color: Colors.white),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (_usernameController.text.isEmpty ||
                        _userIdController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please fill all fields')),
                      );
                      return;
                    }
                    ZegoUIKitPrebuiltCallInvitationService().send(
                      isVideoCall: false,
                      resourceID: "zego_test",
                      invitees: [
                        ZegoCallUser(
                          _userIdController.text,
                          _usernameController.text,
                        ),
                      ],
                    );
                  },
                  child: Icon(Icons.call, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _userIdController.dispose();
    super.dispose();
  }
}
