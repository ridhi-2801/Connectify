import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Admin Panel'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            title: Text('Links'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AdminLinksPage(),))),
          ListTile(
            title: Text('Categories'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AdminCategoryPage(),))),
        ],
      ),
    );
  }
}

class AdminLinksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('All Links'),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('LinksData').snapshots(),
          builder: (context , snapshot) {
            if(snapshot.hasError){return Text('Error');}
            else{
              if(!snapshot.hasData){
                return CircularProgressIndicator();
              }
              final linkSnapshots = snapshot.data!.docs;
              return ListView.builder(
                itemCount: linkSnapshots.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(linkSnapshots[index].get('name')),
                    leading: IconButton(
                      icon: Icon(Icons.delete,),
                      onPressed: (){
                        final id  = linkSnapshots[index].id;
                        FirebaseFirestore.instance.collection('LinksData').doc(id).delete();
                      },
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: (){},
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class AdminCategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('All Links'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Categories').snapshots(),
          builder: (context , snapshot) {
            if(snapshot.hasError){return Text('Error');}
            else{
              if(!snapshot.hasData){
                return CircularProgressIndicator();
              }
              final linkSnapshots = snapshot.data!.docs;
              return ListView.builder(
                itemCount: linkSnapshots.length,
                itemBuilder: (context, index) {
                  final id  = linkSnapshots[index].id;

                  return ListTile(
                    title: Text(linkSnapshots[index].get('title')),
                    leading: IconButton(
                      icon: Icon(Icons.delete,),
                      onPressed: (){
                        FirebaseFirestore.instance.collection('Categories').doc(id).delete();
                      },
                    ),
                    trailing: Switch(
                      value: linkSnapshots[index].get('onHomePage'),
                      onChanged: (bool){
                        print(bool);
                        FirebaseFirestore.instance.collection('Categories').doc(id).update({'onHomePage' : bool});
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
