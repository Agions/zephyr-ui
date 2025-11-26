/// UI Component Repository Interface
///
/// Defines the contract for UI component data access.

import '../entities/ui_component_entity.dart';

abstract class UIComponentRepository {
  Future<UIComponentEntity?> findById(String id);
  Future<List<UIComponentEntity>> findAll();
  Future<List<UIComponentEntity>> findByType(String type);
  Future<void> save(UIComponentEntity component);
  Future<void> delete(String id);
  Future<bool> exists(String id);
  Future<int> count();
}
