import 'package:get/get.dart';
import 'package:pyc/data/models/notice/responses/notice_list_response.dart';
import 'package:pyc/data/models/notice/responses/notice_response.dart';
import 'package:pyc/data/providers/notice/notice_provider_interface.dart';
import 'package:pyc/data/repositories/notice/notice_repository_interface.dart';

class NoticeRepository extends GetxService implements INoticeRepository {
  final INoticeProvider provider;
  NoticeRepository(this.provider);

  @override
  Future<void> write(String title, String content) async {
    await provider.write(title, content);
  }

  @override
  Future<NoticeListResponse> findAll({int offset = 0, int limit = 20}) async {
    final response = await provider.findAll(offset: offset, limit: limit);
    return NoticeListResponse.fromJSON(response.data);
  }

  @override
  Future<NoticeResponse> findById(int id) async {
    final response = await provider.findById(id);
    return NoticeResponse.fromJSON(response.data);
  }

  @override
  Future<void> modify(int id, String title, String content) async {
    await provider.modify(id, title, content);
  }

  @override
  Future<void> deleteById(int id) async {
    await provider.deleteById(id);
  }
}
