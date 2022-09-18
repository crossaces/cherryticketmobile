import 'dart:io';
import 'package:cherryticketmobile/model/auth_model.dart';
import 'package:cherryticketmobile/components/data.dart';
import 'package:cherryticketmobile/model/formevaluasi_model.dart';
import 'package:cherryticketmobile/model/formpendaftaran_model.dart';
import 'package:cherryticketmobile/model/peserta_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class APIService {
  Future<dynamic> register(RegisterRequestModel requestModel) async {
    Uri url = Uri.parse(api + 'pregister');

    var response = await http.post(
      url,
      body: json.encode(requestModel.toJson()),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }

  Future<dynamic> resend() async {
    Uri url = Uri.parse(api + 'email/resend');
    final prefs = await SharedPreferences.getInstance();

    int id = prefs.getInt('iduser') ?? '0';
    var response = await http.post(
      url,
      body: json.encode({'id': id}),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }

  Future<dynamic> updateToken(int id, String token, String bearer) async {
    Uri url = Uri.parse(api + 'ptoken/' + id.toString());

    var response = await http.put(
      url,
      body: json.encode({'token': token}),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $bearer'
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }

  Future<dynamic> addQNA(
      String namapeserta, String pertanyaan, int idevent) async {
    Uri url = Uri.parse(api + 'qna');
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '0';

    var response = await http.post(
      url,
      body: json.encode({
        'nama_peserta': namapeserta,
        'pertanyaan': pertanyaan,
        'id_event': idevent,
      }),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }

  Future<dynamic> login(LoginRequestModel requestModel) async {
    Uri url = Uri.parse(api + 'login');

    var response = await http.post(
      url,
      body: json.encode(requestModel.toJson()),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }

  Future<dynamic> checkin(int idpendaftaran) async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '0';
    int id = prefs.getInt('idpeserta') ?? '0';
    Uri url = Uri.parse(api + 'event/in');
    var response = await http.post(
      url,
      body: json.encode({
        'id_peserta': id,
        'id_pendaftaran': idpendaftaran,
      }),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }

  Future<dynamic> checkout(int idpendaftaran) async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '0';
    int id = prefs.getInt('idpeserta') ?? '0';
    Uri url = Uri.parse(api + 'event/out');
    var response = await http.post(
      url,
      body: json.encode({
        'id_peserta': id,
        'id_pendaftaran': idpendaftaran,
      }),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }

  Future<dynamic> gantipassword(PasswordRequestModel requestModel) async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '0';
    int id = prefs.getInt('iduser') ?? '0';
    Uri url = Uri.parse(api + 'changepass/' + id.toString());
    var response = await http.put(
      url,
      body: json.encode({
        'lastpassword': requestModel.passwordlama,
        'newpassword': requestModel.password,
        'cpassword': requestModel.cpassword
      }),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }

  Future<dynamic> createTransaksi(
      List<Jawaban> jawaban, List<Order> order, String method) async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '0';
    int id = prefs.getInt('idpeserta') ?? '0';
    Uri url = Uri.parse(api + 'transaksi');
    var response = await http.post(
      url,
      body: json.encode({
        'method': method,
        'jawaban': jawaban.map((tag) => tag.toJson()).toList(),
        'order': order.map((tag) => tag.toJson()).toList(),
        'idpeserta': id
      }),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }

  Future<dynamic> evaluation(
      List<PertanyaanE> jawaban, int idform, int idpendaftaran) async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '0';
    Uri url = Uri.parse(api + 'evaluasi');
    var response = await http.post(
      url,
      body: json.encode({
        "id_form_evaluasi": idform,
        "id_pendaftaran": idpendaftaran,
        'data_jawaban': jawaban.map((tag) => tag.toJson()).toList(),
      }),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }

  Future<dynamic> changeprofile(Peserta requestModel) async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '0';
    int id = prefs.getInt('iduser') ?? '0';
    Uri url = Uri.parse(api + 'peserta/' + id.toString());
    var response = await http.put(
      url,
      body: json.encode({
        'no_hp': requestModel.nohp,
        'nama_depan': requestModel.namadepan,
        'nama_belakang': requestModel.namabelakang,
        'alamat': requestModel.alamat
      }),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }

  Future<dynamic> changepicture(File image) async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '0';
    int id = prefs.getInt('idpeserta') ?? '0';
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(api + 'pgambar/' + id.toString()),
    );
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    request.headers.addAll(headers);
    final httpImage = http.MultipartFile.fromBytes(
        'gambar', image.readAsBytesSync(),
        contentType: MediaType('image', 'jpeg,png,jpg'), filename: 'image.png');
    request.files.add(httpImage);
    request.headers.addAll(headers);

    var res = await request.send();
    return res.statusCode;
  }

  Future<dynamic> uploadTransksi(File image, int id) async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '0';
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(api + 'uploadt/' + id.toString()),
    );
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    request.headers.addAll(headers);
    final httpImage = http.MultipartFile.fromBytes(
        'gambar', image.readAsBytesSync(),
        contentType: MediaType('image', 'jpeg,png,jpg'), filename: 'image.png');
    request.files.add(httpImage);
    request.headers.addAll(headers);

    var res = await request.send();
    return res.statusCode;
  }
}
