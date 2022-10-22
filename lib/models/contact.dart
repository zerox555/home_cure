class Contact{
   String name;
   String telNo;

  Contact(this.name, this.telNo);


  Map<String, dynamic> toMap() {
    return {
      "contactName": name,
      "phoneNo": telNo,
    };
  }

  //to store in firebase
  static List<Map> ConvertContactsToMap(List<Contact> contactList) {
    List<Map> contacts = [];
    contactList.forEach((element) {
      Map contact = element.toMap();
      contacts.add(contact);
    });
    return contacts;
  }

}