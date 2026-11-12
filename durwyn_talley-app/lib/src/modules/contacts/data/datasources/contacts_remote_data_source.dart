import 'dart:convert';
import '../../../../core/services/network_service/base_api_service.dart';
import '../../../../core/services/network_service/entities/loader_entity.dart';
import '../../../../core/services/network_service/routes/api_routes.dart';
import '../models/contact_model.dart';

abstract class ContactsRemoteDataSource {
  Future<List<ContactModel>> listContacts({required String token});
  Future<ContactModel> createContact({
    required String token,
    required ContactModel contact,
  });
  Future<ContactModel> updateContact({
    required String token,
    required String contactId,
    required ContactModel contact,
  });
  Future<void> deleteContact({
    required String token,
    required String contactId,
  });
}

class ContactsRemoteDataSourceImpl implements ContactsRemoteDataSource {
  final BaseApiService _apiService;

  ContactsRemoteDataSourceImpl(this._apiService);

  Map<String, String> _headers(String token) => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

  @override
  Future<List<ContactModel>> listContacts({required String token}) async {
    final response = await _apiService.requestGET(
      apiRoute: ApiRouteEntity(baseUrl: null, endpoint: ApiRoutes.contacts),
      headers: _headers(token),
    );

    final dynamic data = response is String ? jsonDecode(response) : response;
    if (data is List) {
      return data.map((e) => ContactModel.fromJson(e as Map<String, dynamic>)).toList();
    }
    return [];
  }

  @override
  Future<ContactModel> createContact({
    required String token,
    required ContactModel contact,
  }) async {
    final response = await _apiService.requestPOST(
      apiRoute: ApiRouteEntity(baseUrl: null, endpoint: ApiRoutes.contacts),
      headers: _headers(token),
      body: contact.toJson(),
    );

    final Map<String, dynamic> data =
        response is String ? jsonDecode(response) : response;
    return ContactModel.fromJson(data);
  }

  @override
  Future<ContactModel> updateContact({
    required String token,
    required String contactId,
    required ContactModel contact,
  }) async {
    final response = await _apiService.requestPUT(
      apiRoute: ApiRouteEntity(
        baseUrl: null,
        endpoint: ApiRoutes.contact(contactId),
      ),
      headers: _headers(token),
      body: contact.toJson(),
    );

    final Map<String, dynamic> data =
        response is String ? jsonDecode(response) : response;
    return ContactModel.fromJson(data);
  }

  @override
  Future<void> deleteContact({
    required String token,
    required String contactId,
  }) async {
    await _apiService.requestDELETE(
      apiRoute: ApiRouteEntity(
        baseUrl: null,
        endpoint: ApiRoutes.contact(contactId),
      ),
      headers: _headers(token),
    );
  }
}
