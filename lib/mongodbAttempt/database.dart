import 'package:mongo_dart/mongo_dart.dart';
import 'userClass.dart';
import 'constants.dart';

//mongodb+srv://kandykane:7Rs0WO5uBv1P71SF@roommatefinder.aido8.mongodb.net/USERS?retryWrites=true&w=majority
//mongodb+srv://kandykane:7Rs0WO5uBv1P71SF@roommatefinder.aido8.mongodb.net/RoommateFinder?retryWrites=true&w=majority

class MongoDatabase {
  static var db;
  static var userCollection;
  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    userCollection = db.collection(USER_COLLECTION);
  }

  static Future<List<Map<String, dynamic>>> getDocuments() async {
    try {
      final users = await userCollection.find().toList();
      return users;
    } catch (e) {
      print(e);
      return Future.value(e) as Future<List<Map<String, dynamic>>>;
    }
  }

  static insert(User user) async {
    await userCollection.insertAll([user.toMap()]);
  }

  static update(User user) async {
    var u = await userCollection.findOne({"_id": user.id});
    u!["name"] = user.name;
    u["username"] = user.username;
    u["password"] = user.password;
    await userCollection.save(u);
  }

  static delete(User user) async {
    await userCollection.remove(where.id(user.id));
  }
}
