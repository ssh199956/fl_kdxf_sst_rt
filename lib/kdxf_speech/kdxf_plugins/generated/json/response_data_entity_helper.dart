import '../../bean/response_data_entity.dart';

responseDataFromJson(ResponseData data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code'] is String
				? int.tryParse(json['code'])
				: json['code'].toInt();
	}
	if (json['message'] != null) {
		data.message = json['message'].toString();
	}
	if (json['sid'] != null) {
		data.sid = json['sid'].toString();
	}
	if (json['data'] != null) {
		data.data = Data().fromJson(json['data']);
	}
	return data;
}

Map<String, dynamic> responseDataToJson(ResponseData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	data['message'] = entity.message;
	data['sid'] = entity.sid;
	data['data'] = entity.data?.toJson();
	return data;
}

dataFromJson(Data data, Map<String, dynamic> json) {
	if (json['result'] != null) {
		data.result = Result().fromJson(json['result']);
	}
	if (json['status'] != null) {
		data.status = json['status'] is String
				? int.tryParse(json['status'])
				: json['status'].toInt();
	}
	return data;
}

Map<String, dynamic> dataToJson(Data entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['result'] = entity.result?.toJson();
	data['status'] = entity.status;
	return data;
}

resultFromJson(Result data, Map<String, dynamic> json) {
	if (json['bg'] != null) {
		data.bg = json['bg'] is String
				? int.tryParse(json['bg'])
				: json['bg'].toInt();
	}
	if (json['ed'] != null) {
		data.ed = json['ed'] is String
				? int.tryParse(json['ed'])
				: json['ed'].toInt();
	}
	if (json['pgs'] != null) {
		data.pgs = json['pgs'].toString();
	}
	if (json['ws'] != null) {
		data.ws = (json['ws'] as List).map((v) => Ws().fromJson(v)).toList();
	}
	if (json['rg'] != null) {
		data.rg = (json['rg'] as List).map((v) => v is String
				? int.tryParse(v)
				: v.toInt()).toList().cast<int>();
	}
	if (json['sn'] != null) {
		data.sn = json['sn'] is String
				? int.tryParse(json['sn'])
				: json['sn'].toInt();
	}
	if (json['ls'] != null) {
		data.ls = json['ls'];
	}
	return data;
}

Map<String, dynamic> resultToJson(Result entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['bg'] = entity.bg;
	data['ed'] = entity.ed;
	data['pgs'] = entity.pgs;
	data['ws'] =  entity.ws?.map((v) => v.toJson())?.toList();
	data['rg'] = entity.rg;
	data['sn'] = entity.sn;
	data['ls'] = entity.ls;
	return data;
}

wsFromJson(Ws data, Map<String, dynamic> json) {
	if (json['bg'] != null) {
		data.bg = json['bg'] is String
				? int.tryParse(json['bg'])
				: json['bg'].toInt();
	}
	if (json['cw'] != null) {
		data.cw = (json['cw'] as List).map((v) => Cw().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> wsToJson(Ws entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['bg'] = entity.bg;
	data['cw'] =  entity.cw?.map((v) => v.toJson())?.toList();
	return data;
}

cwFromJson(Cw data, Map<String, dynamic> json) {
	if (json['sc'] != null) {
		data.sc = json['sc'] is String
				? int.tryParse(json['sc'])
				: json['sc'].toInt();
	}
	if (json['w'] != null) {
		data.w = json['w'].toString();
	}
	return data;
}

Map<String, dynamic> cwToJson(Cw entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['sc'] = entity.sc;
	data['w'] = entity.w;
	return data;
}