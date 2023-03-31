//
//  AuthViewModel.swift
//  TClothes
//
//  Created by Time Ruchutrakool on 3/29/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: ObservableObject{
    
    let db = Firestore.firestore()
    let auth = Auth.auth()
    let webservice = Webservice()
    
    var user: User? {
        didSet{
            objectWillChange.send()
        }
    }
    
    func listenToAuthState(){
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else{
                return
            }
            self.user = user
        }
    }
    
    func createAccount(username: String,email:String,password: String){
        auth.createUser(withEmail: email, password: password){ authResult,error in
            if let error = error{
                print(error.localizedDescription)
            }
            self.db.collection("Customers").document(self.auth.currentUser?.uid ?? UUID().uuidString).setData([
                "username" : username,
                "email": email,
                "wishlist": []
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
            
        }
    }
    
    func logIn(email: String, password: String){
        auth.signIn(withEmail: email, password: password){ authResult, error in
            if let error = error{
                print(error.localizedDescription)
            }
            print("Log In Succeeded")
        }
    }
    
    
    
    func logOut(){
        do{
            try auth.signOut()
        }
        catch{
            print(error)
        }
    }
}
