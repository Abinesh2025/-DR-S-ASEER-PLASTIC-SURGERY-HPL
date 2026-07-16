class RegularUpdateResponseModel {
  bool? success;
  RegularUpdatePagination? data;
  String? message;

  RegularUpdateResponseModel({this.success, this.data, this.message});

  factory RegularUpdateResponseModel.fromJson(Map<String, dynamic> json) {
    print("DEBUG: API Response Keys: ${json.keys.toList()}");
    
    // Some APIs return pagination fields at the top level
    // Some APIs nest them under a 'data' key which itself is a paginator
    // Some APIs have 'data' as a list and 'meta' for pagination.
    
    RegularUpdatePagination? pagination;
    
    if (json['data'] is Map<String, dynamic>) {
       pagination = RegularUpdatePagination.fromJson(json['data']);
    } else if (json['current_page'] != null || json['last_page'] != null) {
       // TOP LEVEL PAGINATION detected
       pagination = RegularUpdatePagination.fromJson(json);
    }
    
    return RegularUpdateResponseModel(
      success: json['success'],
      message: json['message'],
      data: pagination,
    );
  }
}

class RegularUpdatePagination {
  int? currentPage;
  int? lastPage;
  int? total;
  int? perPage;
  List<RegularUpdateData>? data;

  RegularUpdatePagination({this.currentPage, this.lastPage, this.total, this.perPage, this.data});

  factory RegularUpdatePagination.fromJson(Map<String, dynamic> json) {
    // Standard pagination keys (Laravel / AIP style)
    dynamic rawData = json['data'];
    List<RegularUpdateData> items = [];
    
    if (rawData is List) {
       items = rawData.map((i) => RegularUpdateData.fromJson(i)).toList();
    }
    
    print("DEBUG: Parsing Pagination. currentPage: ${json['current_page']}, lastPage: ${json['last_page']}, Data items: ${items.length}");
    
    return RegularUpdatePagination(
      currentPage: _toInt(json['current_page']),
      lastPage: _toInt(json['last_page']),
      total: _toInt(json['total']),
      perPage: _toInt(json['per_page']),
      data: items,
    );
  }
  
  static int? _toInt(dynamic value) {
    if (value is String) return int.tryParse(value);
    if (value is int) return value;
    return null;
  }
}

class RegularUpdateData {
  int? id;
  String? title;
  String? description;
  String? startDate;
  String? endDate;
  int? status;
  String? imageUrl;

  RegularUpdateData({this.id, this.title, this.description, this.startDate, this.endDate, this.status, this.imageUrl});

  factory RegularUpdateData.fromJson(Map<String, dynamic> json) {
    // Robust key mapping for both listing and detail endpoints
    String? image = (json['image_url'] ?? json['image'])?.toString();
    
    return RegularUpdateData(
      id: _toInt(json['id']),
      title: json['title']?.toString(),
      description: json['description']?.toString(),
      startDate: json['start_date']?.toString(),
      endDate: json['end_date']?.toString(),
      status: _toInt(json['status']),
      imageUrl: image,
    );
  }

  static int? _toInt(dynamic value) {
    if (value is String) return int.tryParse(value);
    if (value is int) return value;
    return null;
  }
}