//
//  LoginPage.swift
//  GroupProject
//
//  Created by Gaming Lab on 15/12/24.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

struct LoginPage: View {
    @State private var email:String = "";
    @State private var pass:String = "";
    @State private var alertMessage = "";
    @State private var showAlert = false;
    
    @State private var showSignUpPage = false;
    @State private var showForgotPage = false;
    @State private var showHomePage = false;
    
    @State private var isProcessing:Bool = false;
    
    func changeFlag(id:Int) -> Void {
        showHomePage = false;
        showAlert = false;
        showForgotPage = false;
        showSignUpPage = false;
        
        if(id == 0){
            showHomePage = true;
        }
        else if(id == 1){
            showSignUpPage = true;
        }
        else if(id == 2){
            showForgotPage = true;
        }
        else if(id == -1){
            showAlert = true;
        }
    }
    
    func forgotAction(){
        changeFlag(id: 2);
    }
    
    func createAction(){
        changeFlag(id: 1);
    }
    
    func loginAction(){
        if(isProcessing){
            return;
        }
        if(email.isEmpty || pass.isEmpty){
            alertMessage = "Can't be empty";
            showAlert = true;
            return
        }
        showAlert = false;
        handleLogin(email: email, pass: pass);
        print("Login clicked");
    }
    
    func handleLogin(email:String,pass:String){

        print(email);
        print(pass);
        
   
        isProcessing = true;
        
        Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
            
            isProcessing = false;
            
            print("signin result\(result)");
            print("sigin error\(error)");
            
                if error != nil {
                    alertMessage = error?.localizedDescription ?? "";
                    showAlert = true;
                }
                else {
                    print("success")
                    changeFlag(id: 0)
                    
                    let myUid = Auth.auth().currentUser?.uid;
                    
                    let defaults = UserDefaults.standard;
                    defaults.set(true, forKey: "am_i_logged_in");
                    defaults.set(myUid,forKey: "my_user_id");
                }
        }
        
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                
                VStack{
                    NavigationLink(
                        destination: SignUpPage(),
                        isActive: $showSignUpPage,
                        label: {
                            EmptyView()
                    })
                    
                    
                    NavigationLink(
                        destination: OTPPage(),
                        isActive: $showForgotPage,
                        label: {
                            EmptyView()
                    })
                    
                    NavigationLink(
                        destination: HomeActivity(),
                        isActive: $showHomePage,
                        label: {
                            EmptyView()
                    })
                    
                    VStack{
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                       
                        VStack(alignment:.leading){
                            Text("Email")
                                .frame(minHeight:20)
                                .font(.callout)
                                .padding([.horizontal],4)
                            
                            TextField("Enter email",text:self.$email)
                                .frame(height:48)
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding([.horizontal],12)
                                .cornerRadius(8)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray)
                                )
                               
                            Text("Password")
                                .frame(minHeight:20)
                                .font(.callout)
                                .padding([.horizontal],4)
                                .padding(.top,4)
                            
                            TextField("Enter password",text:self.$pass)
                                .frame(height:48)
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding([.horizontal],12)
                                .cornerRadius(8)
                                .autocapitalization(.none)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray)
                                )
                                
                        }//vstack
                        .padding(12)
                        if showAlert{
                            VStack(alignment: .center){
                                Text(alertMessage)
                                    .font(.system(size: 10))
                                    .foregroundColor(Color.red)
                                    .frame(maxWidth:.infinity,alignment: .leading)
                            }
                            .padding(EdgeInsets(
                                    top:-4,
                                    leading: 20,
                                    bottom: 0,
                                    trailing: 0
                                )
                            )
                        }
                        
                        Spacer(minLength: 4)
                        
                        VStack{
                            
                            GeometryReader{ gm in
                                HStack {
                                    
                                    Button(action: loginAction, label: {
                                        Text("LOGIN")
                                            .fontWeight(.semibold)
                                            .frame(minWidth:0,maxWidth: .infinity)
                                            .padding()
                                    })
                                    .frame(width:gm.size.width*0.8)
                                    .foregroundColor(.white)
                                    .background(Color.black)
                                    .cornerRadius(32)
                                }
                                .frame(minWidth: 0,maxWidth: .infinity,minHeight: 0,maxHeight: .infinity)
                            }
                    
                            HStack{
                                Spacer()
                                
                                Button(action: forgotAction, label: {
                                    Text("Forgot password?")
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color.black)
                                        .padding([.horizontal],8)
                                })
                                
                                Spacer()
                            }
                            .frame(width: .infinity, height: 60, alignment: .center)
                            
                            Spacer()
                            
                            HStack{
                                Spacer()
                                
                                Text("Don't have an account? ")
                                Button(action: createAction, label: {
                                    Text("Create Account")
                                        .fontWeight(.semibold)
                                        .padding(0)
                                })
                                .foregroundColor(Color.blue)
                                
                                Spacer()
                            }
                            
     
                        }//vstack
                        .padding([.horizontal],12)
                        

                        Spacer()
                    }//Vstack
                    
                }//vstack
            
                if(isProcessing){
                    
                    VStack{
                        
                        LottieView(fileName:"lottie_progress")
                            .frame(width:150,height:150,alignment: .center)
                        
                    }//vstack
                    .padding(24)
                    .cornerRadius(12)
/*                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray)
                    )
 */
                }
                
            }//zstack
        
            .navigationTitle("Welcome")
        }//navigation
        
    }//body
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
