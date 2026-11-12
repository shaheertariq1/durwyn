import '../../../../core/utils/app_exports.dart';
import '../../data/models/contact_model.dart';
import '../../domain/entities/contact_entity.dart';
import '../../domain/repositories/contacts_repository.dart';

class ContactsController extends ChangeNotifier {
  ContactsController() {
    fetchContacts();
  }

  final ContactsRepository _repository = locator<ContactsRepository>();

  List<ContactEntity> _contacts = [];
  List<ContactEntity> get contacts => _contacts;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasLoaded = false;
  bool get hasLoaded => _hasLoaded;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchContacts({bool showLoading = true}) async {
    if (showLoading) {
      _isLoading = true;
      notifyListeners();
    }
    try {
      _contacts = await _repository.listContacts();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      _hasLoaded = true;
      notifyListeners();
    }
  }

  Future<bool> addContact({
    required String name,
    required String phone,
    required String relationship,
    String email = '',
    bool allowGps = true,
    bool allowAudio = true,
    bool allowVideo = false,
    SubscriptionPlan plan = SubscriptionPlan.free,
  }) async {
    final maxContacts = plan.maxContacts;
    if (_contacts.length >= maxContacts) {
      Prompts.showToast(
        '${plan.name.toUpperCase()} Plan allows up to $maxContacts Emergency Contact${maxContacts > 1 ? 's' : ''}. Upgrade plan to add more.',
        isSuccess: false,
      );
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final newContact = ContactModel(
        name: name.trim(),
        phone: phone.trim(),
        relationship: relationship.trim(),
        email: email.trim(),
        allowGps: allowGps,
        allowAudio: allowAudio,
        allowVideo: allowVideo,
      );

      final created = await _repository.createContact(newContact);
      _contacts = [created, ..._contacts];
      _errorMessage = null;
      notifyListeners();
      Prompts.showToast('Emergency contact added successfully.');
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      Prompts.showToast(
        e.toString().replaceAll('Exception:', '').trim(),
        isSuccess: false,
      );
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateContact({
    required String contactId,
    required String name,
    required String phone,
    required String relationship,
    String email = '',
    bool allowGps = true,
    bool allowAudio = true,
    bool allowVideo = false,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final updateModel = ContactModel(
        id: contactId,
        name: name.trim(),
        phone: phone.trim(),
        relationship: relationship.trim(),
        email: email.trim(),
        allowGps: allowGps,
        allowAudio: allowAudio,
        allowVideo: allowVideo,
      );

      final updated = await _repository.updateContact(contactId, updateModel);
      _contacts = _contacts.map((c) => c.id == contactId ? updated : c).toList();
      _errorMessage = null;
      notifyListeners();
      Prompts.showToast('Emergency contact updated.');
      return true;
    } catch (e) {
      Prompts.showToast(
        e.toString().replaceAll('Exception:', '').trim(),
        isSuccess: false,
      );
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteContact(String contactId) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _repository.deleteContact(contactId);
      _contacts = _contacts.where((c) => c.id != contactId).toList();
      notifyListeners();
      Prompts.showToast('Emergency contact deleted.');
      return true;
    } catch (e) {
      Prompts.showToast(
        e.toString().replaceAll('Exception:', '').trim(),
        isSuccess: false,
      );
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

final contactsControllerProvider = ChangeNotifierProvider<ContactsController>(
  (ref) => ContactsController(),
);
