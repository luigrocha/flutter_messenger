import 'package:chat/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPage extends StatefulWidget {
  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  final usuarios = [
    Usuario(uid: '1', nombre: 'Maria', email: 'test@gmail.com', online: true),
    Usuario(uid: '2', nombre: 'Melisa', email: 'test2@gmail.com', online: false),
    Usuario(uid: '3', nombre: 'Fernando', email: 'test3@gmail.com', online: true),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Mi nombre',
            style: TextStyle(color: Colors.black54),
          ),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.black54),
            onPressed: () {},
          ),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.check_circle,
                color: Colors.blue[400],
              ),
              //child: Icon(Icons.offline_bolt, color: Colors.red,),
            )
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: _onRefresh,
          header: WaterDropHeader(
              complete: Icon(
                Icons.check,
                color: Colors.blue[400],
              ),
              waterDropColor: Colors.blue),
          child: _listViewUsuarios(),
        ));
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) => _usuarioListTile(usuarios[i]),
      separatorBuilder: (_, i) => Divider(),
      itemCount: usuarios.length,
    );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        child: Text(usuario.nombre.substring(0, 2)),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: usuario.online ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(100)),
      ),
    );
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

   void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length+1).toString());
    if(mounted)
    setState(() {

    });
    _refreshController.loadComplete();
  }
}
