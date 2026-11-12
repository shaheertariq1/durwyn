import '../../../../core/services/local_db_service/secure_storage.dart';
import '../../domain/entities/contact_entity.dart';
import '../../domain/repositories/contacts_repository.dart';
import '../datasources/contacts_remote_data_source.dart';
import '../models/contact_model.dart';

class ContactsRepositoryImpl implements ContactsRepository {
  final ContactsRemoteDataSource _remoteDataSource;
  final Prefs _prefs;

  ContactsRepositoryImpl(this._remoteDataSource, this._prefs);

  Future<String> _getToken() async {
    final token = await _prefs.fetchToken();
    if (token == null || token.isEmpty) {
      throw Exception('Not authenticated. Please log in.');
    }
    return token;
  }

  @override
  Future<List<ContactEntity>> listContacts() async {
    final token = await _getToken();
    return await _remoteDataSource.listContacts(token: token);
  }

  @override
  Future<ContactEntity> createContact(ContactModel contact) async {
    final token = await _getToken();
    return await _remoteDataSource.createContact(token: token, contact: contact);
  }

  @override
  Future<ContactEntity> updateContact(
    String contactId,
    ContactModel contact,
  ) async {
    final token = await _getToken();
    return await _remoteDataSource.updateContact(
      token: token,
      contactId: contactId,
      contact: contact,
    );
  }

  @override
  Future<void> deleteContact(String contactId) async {
    final token = await _getToken();
    await _remoteDataSource.deleteContact(token: token, contactId: contactId);
  }
}
