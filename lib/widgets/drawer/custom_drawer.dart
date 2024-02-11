import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/pages/login_page.dart';
import 'package:loja_virtual/widgets/drawer/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';
import 'drawer_back.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Stack(
        children: [
          const DrawerBack(),
          ListView(
            padding: const EdgeInsets.only(left: 32.0, top: 16),
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 8.0),
                padding: const EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 180.0,
                child: Stack(
                  children: [
                    const Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: Text(
                        'Flutter´s\nClothing',
                        style: TextStyle(
                          fontSize: 34.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: ScopedModelDescendant<UserModel>(
                        builder: (BuildContext context, Widget? child,
                            UserModel model) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Olá, ${!model.isLoggedIn() ? '' : model.userData['name']}',
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              GestureDetector(
                                child: Text(
                                  !model.isLoggedIn() ? 'Entre ou cadastre-se >' : 'Sair',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: () {
                                  if (!model.isLoggedIn()) {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => const LoginPage()));
                                  } else {
                                    model.signOut();
                                  }
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              DrawerTile(
                icon: Icons.home,
                text: 'Inicio',
                controller: pageController,
                page: 0,
              ),
              DrawerTile(
                icon: Icons.list,
                text: 'Produtos',
                controller: pageController,
                page: 1,
              ),
              DrawerTile(
                icon: Icons.location_on,
                text: 'Lojas',
                controller: pageController,
                page: 2,
              ),
              DrawerTile(
                icon: Icons.playlist_add_check,
                text: 'Meus Pedidos',
                controller: pageController,
                page: 3,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
