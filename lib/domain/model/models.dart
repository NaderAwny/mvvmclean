class SliderObject {
  final String title;
  final String subTitle;
  final String image;
  SliderObject(this.title, this.subTitle, this.image);
}

class SliderViewObject {
  SliderObject sliderObject;
  int numberOfSlides;
  int currentIndex;
  SliderViewObject(this.sliderObject, this.numberOfSlides, this.currentIndex);
}

class Customer {
  String? id;
  String? name;
  int? numOfNotifications;

  Customer(this.id, this.name, this.numOfNotifications);
}

class Contacts {
  String? phone;
  String? email;
  String? link;

  Contacts(this.phone, this.email, this.link);
}

class Authentication {
  Customer? customer;
  Contacts? contacts;

  Authentication(this.customer, this.contacts);
}
