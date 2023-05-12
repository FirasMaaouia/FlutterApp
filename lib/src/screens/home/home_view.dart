import 'package:esprit/src/screens/home/home_controller.dart';
import 'package:esprit/src/screens/settings/settings_view.dart';
import 'package:esprit/src/widgets/chat_card.dart';
import 'package:esprit/src/widgets/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static final String routeName = "/chat";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatController _chatController;

  @override
  void initState() {
    super.initState();
    _chatController = ChatController(context: context);
  }

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _chatController.initProvider();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: _chatController.streamController.stream,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: CustomAppBar(
            title: Text(_chatController.loading ? 'Connecting...' : 'Chats'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.of(context).pushNamed(SettingsScreen.routeName);
                },
              ),
            ],
          ),
          body: SafeArea(
            child: usersList(context),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _chatController.openAddChatScreen,
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(
              Icons.message,
              color: Theme.of(context).accentColor,
            ),
          ),
        );
      },
    );
  }

  Widget usersList(BuildContext context) {
    // if (_chatController.loading) {
    //   return SliverFillRemaining(
    //     child: Center(
    //       child: CupertinoActivityIndicator(),
    //     ),
    //   );
    // }
    // if (_chatController.error) {
    //   return SliverFillRemaining(
    //     child: Center(
    //       child: Text('Ocorreu um erro ao buscar suas conversas.'),
    //     ),
    //   );
    // }
    if (_chatController.chats.length == 0) {
      return Center(
        child: Text('No conversations found!'),
      );
    }
    bool theresChatsWithMessages = _chatController.chats.where((chat) {
          return chat.messages.length > 0;
        }).length >
        0;
    if (!theresChatsWithMessages) {
      return Center(
        child: Text('You have conversations!'),
      );
    }
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: _chatController.chats.map((chat) {
            if (chat.messages.length == 0) {
              return Container(height: 0, width: 0);
            }
            return Column(
              children: <Widget>[
                ChatCard(
                  chat: chat,
                ),
              ],
            );
          }).toList(),
        );
      },
    );
  }
}
