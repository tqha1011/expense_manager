
import 'package:supabase_flutter/supabase_flutter.dart';

// class chua cac ham lien quan den dang nhap, dang ky, dang xuat
class AuthServices {
  // ham lay thong tin nguoi dung hien tai
  final GoTrueClient auth = Supabase.instance.client.auth;
  final SupabaseClient supabaseClient = Supabase.instance.client;
  // lay thong tin nguoi dung hien tai
  User? get currentUser => auth.currentUser;
  // lay phien dang nhap hien tai
  Session? get currentSession => auth.currentSession;

  // ham ho tro check email hop le
  bool checkEmailValid(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
  // ham dang nhap
  Future<AuthResponse> signIn(String input,String password) async {
    String email = input;
    if(!checkEmailValid(email)){
      try{
        final response = await supabaseClient
            .from('profiles')
            .select('email')
            .eq('username', input)
            .maybeSingle();
        if(response == null){
          throw AuthException('Username does not exist');
        }
        else{
          // trao hang de dang nhap
          email = response['email'];
        }
      }
      catch(e){
        rethrow;
      }
    }
    return await auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // ham dang ki
  Future<AuthResponse> signUp(String username,String email, String password) async {
    // dang ki tai khoan voi email va mat khau , dung phuong thuc auth.signUp cua supabase
    final response = await auth.signUp(
      email: email,
      password: password,
      data: {
        'username': username,
      },
    ); 
    // neu dang ki thanh cong thi tao them thong tin trong bang users
    if(response.user != null){
      await supabaseClient.from('profiles').insert({
        'id': response.user!.id,
        'username': username, // luu username de hien thi trong ung dung va dang nhap
        'email': email, // luu email de sau nay lay lai mat khau va dang nhap = email
        'current_money': 0.0, // so du ban dau la 0
      });
    }
    return response;
  }

  // dang xuat
  Future<void> signOut() async {
    await auth.signOut();
  }
}

