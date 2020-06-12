import 'package:brew_crew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew/models/brew.dart';
class DatabaseService{
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference brewCollection=Firestore.instance.collection('brews');  // brew as obj of firestore

  // create new record in brew collection for that user with prop of user as name,sugar,strength
  // for new user firestore create new unique id for all user based on that id we do all calculations

  Future updateUserData(String sugars, String name,int strength)async{

    // if we have created new user it set this all prop for new user  or update user data
    return await brewCollection.document(uid).setData({
      'sugars':sugars,
      'name':name,
      'strength':strength,
    });

  }

//brew list from snapshots   mapping data from brew list

  List<Brew>_brewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Brew(
        name: doc.data['name']?? '',
            strength: doc.data['strength']?? 0,
        sugars: doc.data['sugars']?? '0'
      );
    }).toList();
  }

  // get user data snapshot
  UserData _userDataFormSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength']
    );
  }
  
  // get brew stream
   Stream<List<Brew>>get brews{
    return brewCollection.snapshots()
    .map(_brewListFromSnapshot);
   }

  // get user doc stream

Stream <UserData>get userData{
    return brewCollection.document(uid).snapshots()
    .map(_userDataFormSnapshot);

}

}