import '../entities/contact_entity.dart';
import '../../data/models/contact_model.dart';

abstract class ContactsRepository {
  Future<List<ContactEntity>> listContacts();
  Future<ContactEntity> createContact(ContactModel contact);
  Future<ContactEntity> updateContact(String contactId, ContactModel contact);
  Future<void> deleteContact(String contactId);
}
