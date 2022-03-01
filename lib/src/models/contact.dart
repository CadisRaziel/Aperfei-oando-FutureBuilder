class Contact {
  String? name;
  int? number;
  int? id;
  Contact({
    this.name,
    this.number,
    this.id,
  });

  @override
  String toString() => 'Contact(name: $name, number: $number, id: $id)';
}
