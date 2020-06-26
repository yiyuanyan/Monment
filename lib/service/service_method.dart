import 'dart:io';
import 'package:dio/dio.dart';
import 'dart:async';
import '../config/service_url.dart';

Future request(url, {formData}) async{
  try{
    print("开始请求数据:${servicePATH[url]}/" + "----->formData:$formData");
    Response response;
    Dio dio = Dio();
    dio.options.responseType = ResponseType.json;
    if(formData == null){
      response = await dio.post(servicePATH[url]);
    }else{
      String uri = servicePATH[url]+"/"+formData;
      print("带参数的访问地址:------------>$uri");
      response = await dio.post(uri);
    }
    if(response.statusCode == 200){
      print("数据请求成功:---------------->${servicePATH[url]}" + "$formData");
      return response.data;
    }else{
      return print("后台接口异常$url/$formData");
    }
  }catch(e){
    return print("ERROR:--------------->$e");
  }
}