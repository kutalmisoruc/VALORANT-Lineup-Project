import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseProcess {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //AGENT DATA PULL FROM FIREBASE
  Stream<QuerySnapshot> AgentsDataPull() {
    var ref = _firestore.collection("Agents").snapshots();

    return ref;
  }
  //LINEUP DATA PULL FROM FIREBASE
  Stream<QuerySnapshot> LineUpDataPull(String agent,String map) {
    var ref = _firestore.collection("Lineup").where("agent", isEqualTo: agent).where("map",isEqualTo: map).snapshots();

    return ref;
  }
  //SELECTED LINEUP DATA PULL FROM FIREBASE
  Stream<QuerySnapshot> LineUpDetailDataPull(String id) {
    var ref = _firestore.collection("Lineup").where("id", isEqualTo: id).snapshots();

    return ref;
  }

  /* Stream<QuerySnapshot> LineUpFavDataPull(List list) {
    List list1=[];
    
    var ref;
    for(int i=0;i<list.length;i++){
      
      ref = _firestore.collection("Lineup").where("id", isEqualTo: list[i]).snapshots();
      list1.add(ref);

    }
    
    return ref;
  } */
  
}