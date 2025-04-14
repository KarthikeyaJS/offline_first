// GENERATED CODE DO NOT EDIT
part of '../brick.g.dart';

Future<Note> _$NoteFromSupabase(
  Map<String, dynamic> data, {
  required SupabaseProvider provider,
  OfflineFirstWithSupabaseRepository? repository,
}) async {
  return Note(
    content: data['content'] as String,
    createdAt: data['created_at'] as String,
    id: data['id'] as String?,
  );
}

Future<Map<String, dynamic>> _$NoteToSupabase(
  Note instance, {
  required SupabaseProvider provider,
  OfflineFirstWithSupabaseRepository? repository,
}) async {
  return {
    'content': instance.content,
    'created_at': instance.createdAt,
    'id': instance.id,
  };
}

Future<Note> _$NoteFromSqlite(
  Map<String, dynamic> data, {
  required SqliteProvider provider,
  OfflineFirstWithSupabaseRepository? repository,
}) async {
  return Note(
    content: data['content'] as String,
    createdAt: data['created_at'] as String,
    id: data['id'] as String,
  )..primaryKey = data['_brick_id'] as int;
}

Future<Map<String, dynamic>> _$NoteToSqlite(
  Note instance, {
  required SqliteProvider provider,
  OfflineFirstWithSupabaseRepository? repository,
}) async {
  return {
    'content': instance.content,
    'created_at': instance.createdAt,
    'id': instance.id,
  };
}

/// Construct a [Note]
class NoteAdapter extends OfflineFirstWithSupabaseAdapter<Note> {
  NoteAdapter();

  @override
  final supabaseTableName = 'notes';
  @override
  final defaultToNull = true;
  @override
  final fieldsToSupabaseColumns = {
    'content': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'content',
    ),
    'createdAt': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'created_at',
    ),
    'id': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'id',
    ),
  };
  @override
  final ignoreDuplicates = false;
  @override
  final uniqueFields = {'id'};
  @override
  final Map<String, RuntimeSqliteColumnDefinition> fieldsToSqliteColumns = {
    'primaryKey': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: '_brick_id',
      iterable: false,
      type: int,
    ),
    'content': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'content',
      iterable: false,
      type: String,
    ),
    'createdAt': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'created_at',
      iterable: false,
      type: String,
    ),
    'id': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'id',
      iterable: false,
      type: String,
    ),
  };
  @override
  Future<int?> primaryKeyByUniqueColumns(
    Note instance,
    DatabaseExecutor executor,
  ) async {
    final results = await executor.rawQuery(
      '''
        SELECT * FROM `Note` WHERE id = ? LIMIT 1''',
      [instance.id],
    );

    // SQFlite returns [{}] when no results are found
    if (results.isEmpty || (results.length == 1 && results.first.isEmpty)) {
      return null;
    }

    return results.first['_brick_id'] as int;
  }

  @override
  final String tableName = 'Note';

  @override
  Future<Note> fromSupabase(
    Map<String, dynamic> input, {
    required provider,
    covariant OfflineFirstWithSupabaseRepository? repository,
  }) async => await _$NoteFromSupabase(
    input,
    provider: provider,
    repository: repository,
  );
  @override
  Future<Map<String, dynamic>> toSupabase(
    Note input, {
    required provider,
    covariant OfflineFirstWithSupabaseRepository? repository,
  }) async =>
      await _$NoteToSupabase(input, provider: provider, repository: repository);
  @override
  Future<Note> fromSqlite(
    Map<String, dynamic> input, {
    required provider,
    covariant OfflineFirstWithSupabaseRepository? repository,
  }) async =>
      await _$NoteFromSqlite(input, provider: provider, repository: repository);
  @override
  Future<Map<String, dynamic>> toSqlite(
    Note input, {
    required provider,
    covariant OfflineFirstWithSupabaseRepository? repository,
  }) async =>
      await _$NoteToSqlite(input, provider: provider, repository: repository);
}
