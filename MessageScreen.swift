//
//  MessageScreen.swift
//  Language-Learning-App
//
//  Created by ECC Chicago on 8/3/22.
//

import SwiftUI

struct Friend: Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var image: String
    var messageOne: String
    var messageTwo: String
    var messageThree: String
    var messageFour: String
    var messageFive: String
    var messageSix: String
}

struct MessageScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var message: String = ""
    @State private var messageWasSent: Bool = false
    
    @State var callWasChosen: Bool = false
    @State var messageWasChosen: Bool = false
    @State private var selection: String? = nil
    
    // arraylist of friends that will be organized by alphabetical order
    var friends: [Friend] = [
        Friend(name: "Brian", image: "profileThreePic", messageOne: "¡Hola! ¿Yo vi que estabas aprendiendo español?", messageTwo: "sí, estoy", messageThree: "Bien, yo también. ¿Hace cuanto qué estabas aprendiendo?", messageFour: "uhhh empence cuando estaba en la escuela secundaria y ahora estoy tomando clases en la universidad", messageFive: "Oh, qué bien, yo también estoy tomando clases de español en la universidad.", messageSix: "¿cuánto tiempo has estado estudiando?"),
        Friend(name: "Louisa", image: "profileFourPic", messageOne: "Hi, do you still need someone to practice with? I can help", messageTwo: "Yes! When can we call?", messageThree: "I'm free to talk in a 2 hours. Does that work for you?", messageFour: "I can call in 3 hours", messageFive: "That works for me. Talk to you later!", messageSix: "Ok"),
        Friend(name: "Nicole", image: "profileTwoPic", messageOne: "¡Oye, he visto que también te gusta viajar! ¿Cuál es su lugar favorito para visitar?", messageTwo: "Me encanta visitar a mi familia en México, y viajo allí cada año. ¿Usted?", messageThree: "Me gusta ir a Canadá a visitar a mi hermana. Se mudó allí hace unos años por trabajo.", messageFour: "Oh, yo también fui a Canadá hace unos años", messageFive: "¿De verdad? ¿A Dónde?", messageSix: "¡Ontario!"),
        Friend(name: "Sam", image: "profileOnePic", messageOne: "嘿！我看到了你发的贴，你想建一个练习中文的群。我的中文很流利，我想加入你的群！", messageTwo: "嘿！谢谢！那就太好了，我等一下就建群。", messageThree: "我很期待！你中文学多久了？", messageFour: "我前几个月刚刚开始学中文。", messageFive: "哇，真的吗？你的中文真的很好！", messageSix: "谢谢！我特别喜欢学习新的语言。")
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .center) {
                    List {
                        ForEach(friends) { index in
                            messageList(human: index, message: $message, messageWasSent: $messageWasSent)
                        }
                    }
                    
                }
                .background(Color(red: 0.949, green: 0.949, blue: 0.971))
                .navigationTitle("Messages")
                .navigationBarTitleDisplayMode(.inline)
                
                if callWasChosen == true {
                    NavigationLink(destination: matchRandomCallScreen(), tag: "A", selection: $selection) {}
                }
                
                if messageWasChosen == true {
                    NavigationLink(destination: matchRandomMessageScreen(), tag: "B", selection: $selection) {}
                }
                
                Menu {
                    Button(action: {
                        callWasChosen = true
                        selection =  "A"
                    }) {
                        Text("Matchmaker: Call")
                    }
                    
                    Button(action: {
                        messageWasChosen = true
                        selection =  "B"
                    }) {
                        Text("Matchmaker: Message")
                    }
                    
                    Button(action: {
                        messageWasChosen = true
                        selection =  "C"
                    }) {
                        Text("Create a groupchat")
                    }
                } label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .background(Color.white)
                        .foregroundColor(Color(red: 0.40784313725490196, green: 0.6235294117647059, blue: 0.2196078431372549))
                        .clipShape(Circle())
                        .shadow(radius: 10)
                }
                .offset(x:130, y: 280)
            }
        }
        
        // navigation bar customization
        .navigationBarBackButtonHidden(true)
        
        .onAppear {
            let appearance = UINavigationBarAppearance()
            
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            appearance.backgroundColor = UIColor(Color(red: 0.40784313725490196, green: 0.6235294117647059, blue: 0.2196078431372549))
            
            
            appearance.titleTextAttributes = [
                .font: UIFont(name: "ArialMT", size: 30)!,
                .foregroundColor: UIColor(red: 249/255, green: 246/255, blue: 239/255, alpha: 1),
            ]
            
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            
        }
    }
}

// friend list design
struct messageList: View {
    var human: Friend
    @Binding var message: String
    @Binding var messageWasSent: Bool
    
    var body: some View {
        NavigationLink(destination: DirectMessageScreen(profileScreen: human, message: $message, messageWasSent: $messageWasSent), label: {
            ZStack {
                VStack(spacing: 0) {
                    HStack {
                        Image(human.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                        VStack() {
                            Text(human.name)
                                .foregroundColor(Color.black)
                                .padding()
                                .font(.title2)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(human.messageSix)
                                .frame(maxWidth: 220, maxHeight: 15, alignment: .leading)
                                .offset(x: 5, y: -10)
                                .foregroundColor(Color.gray)
                        }
                    }
                }
                .background(Color.white)
                .ignoresSafeArea(.all)
            }
        })
        
    }
}


// creates a new profile screen for every user
struct DirectMessageScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let profileScreen: Friend
    @Binding var message: String
    @Binding var messageWasSent: Bool
    //For dark mode
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(red: 0.8627450980392157, green: 0.8784313725490196, blue: 0.803921568627451))
                .frame(width: .infinity, height: .infinity)
            ScrollView {
                ZStack {
                    VStack {
                        Spacer()
                        Text("Your conversation with \(profileScreen.name) starts here")
                            .offset(y:3)
                        Divider()
                        Spacer()
                            .frame(height: 10)
                        // message one
                        Group {
                            HStack {
                                Text(profileScreen.messageOne)
                                    .padding()
                                    .background(Color(red: 0.40784313725490196, green: 0.6235294117647059, blue: 0.2196078431372549))
                                    .cornerRadius(30)
                                    .foregroundColor(Color.black)
                                    .frame(maxWidth: 230, alignment: .trailing)
                                Image("iconWBg")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    .shadow(radius: 10)
                            }
                            .padding(.horizontal)
                            .frame(maxWidth: 380, alignment: .trailing)
                            
                            //messagetwo
                            HStack {
                                Image(profileScreen.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    .shadow(radius: 10)
                                Text(profileScreen.messageTwo)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(30)
                                    .foregroundColor(Color.black)
                                    .frame(maxWidth: 230, alignment: .leading)
                            }
                            .padding()
                            .frame(maxWidth: 380, alignment: .leading)
                            
                            //messageThree
                            HStack {
                                Text(profileScreen.messageThree)
                                    .padding()
                                    .background(Color(red: 0.40784313725490196, green: 0.6235294117647059, blue: 0.2196078431372549))
                                    .cornerRadius(30)
                                    .foregroundColor(Color.black)
                                    .frame(maxWidth: 230, alignment: .trailing)
                                Image("iconWBg")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    .shadow(radius: 10)
                            }
                            .padding(.horizontal)
                            .frame(maxWidth: 380, alignment: .trailing)
                            
                            //messagefour
                            HStack {
                                Image(profileScreen.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    .shadow(radius: 10)
                                Text(profileScreen.messageFour)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(30)
                                    .foregroundColor(Color.black)
                                    .frame(maxWidth: 230, alignment: .leading)
                            }
                            .padding()
                            .frame(maxWidth: 380, alignment: .leading)
                            
                            //messageFive
                            HStack {
                                Text(profileScreen.messageFive)
                                    .padding()
                                    .background(Color(red: 0.40784313725490196, green: 0.6235294117647059, blue: 0.2196078431372549))
                                    .cornerRadius(30)
                                    .foregroundColor(Color.black)
                                    .frame(maxWidth: 230, alignment: .trailing)
                                Image("iconWBg")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    .shadow(radius: 10)
                            }
                            .padding(.horizontal)
                            .frame(maxWidth: 380, alignment: .trailing)
                            
                            //messageSix
                            HStack {
                                Image(profileScreen.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    .shadow(radius: 10)
                                Text(profileScreen.messageSix)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(30)
                                    .foregroundColor(Color.black)
                                    .frame(maxWidth: 230, alignment: .leading)
                            }
                            .padding()
                            .frame(maxWidth: 380, alignment: .leading)
                            
                            //our message
                            if messageWasSent {
                                SentMessage(message: $message)
                            }
                        }
                    }
                    .navigationBarTitle(profileScreen.name, displayMode: .inline)
                    .navigationBarItems(trailing: Button(action: {}, label: {
                        NavigationLink(destination: CallFriendScreen(profileScreen: profileScreen), label: {
                            Image(systemName: "phone.circle")
                                .resizable()
                                .foregroundColor(Color.white)
                                .frame(width: 30, height: 30)
                        })
                    }))
                    .navigationBarBackButtonHidden(true)
                    .toolbar {
                        ToolbarItem(placement: .navigation){
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(systemName: "arrow.left.circle")
                                    .resizable()
                                    .foregroundColor(Color.white)
                                    .frame(width: 30, height: 30)
                            }
                        }
                    }
                }
                
            }
            .frame(width: .infinity, height: .infinity, alignment: .top)
            ZStack {
                Rectangle()
                    .foregroundColor(Color(red: 0.8627450980392157, green: 0.8784313725490196, blue: 0.803921568627451))
                    .overlay(
                        Rectangle()
                            .stroke(Color(red: 0.40784313725490196, green: 0.6235294117647059, blue: 0.2196078431372549), lineWidth: 1)
                    )
                    .frame(width: .infinity, height: 100, alignment: .bottom)
                
                HStack {
                    TextField("", text: $message)
                        .padding()
                        .frame(width: 300, height: 50, alignment: .leading)
                        .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.826))
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(Color(red: 0.40784313725490196, green: 0.6235294117647059, blue: 0.2196078431372549), lineWidth: 3)
                        )
                        .cornerRadius(30)
                    Button(action: {
                        if message != "" {
                            messageWasSent = true
                        }
                    }) {
                        Image(systemName: "paperplane.circle")
                            .resizable()
                            .foregroundColor(Color(red: 0.40784313725490196, green: 0.6235294117647059, blue: 0.2196078431372549))
                            .frame(width: 35, height: 35)
                            .aspectRatio(contentMode: .fit)
                            .offset(x: 5)
                    }
                }
            }
            .offset(y:285)
        }
        
    }
}



struct SentMessage: View {
    @Binding var message: String
    
    var body: some View {
        return HStack {
            Text(message)
                .padding()
                .background(Color(red: 0.40784313725490196, green: 0.6235294117647059, blue: 0.2196078431372549))
                .cornerRadius(30)
                .foregroundColor(Color.black)
                .frame(maxWidth: 230, alignment: .trailing)
            
            Image("iconWBg")
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .shadow(radius: 10)
            
            
        }
        .padding(.horizontal)
        .frame(maxWidth: 380, alignment: .trailing)
    }
}

struct CallFriendScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let profileScreen: Friend
    //For dark mode
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.black)
                .frame(width: .infinity, height: .infinity)
            VStack {
                Image(profileScreen.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                Text("Calling \(profileScreen.name)...")
                    .padding()
                    .font(.title)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: 230, alignment: .center)
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "phone.circle")
                        .resizable()
                        .foregroundColor(Color.red)
                        .frame(width: 50, height: 50)
                        .aspectRatio(contentMode: .fit)
                }
                
                
            }
            .ignoresSafeArea(.all)
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
        .ignoresSafeArea(.all)
        
    }
    
}

struct matchRandomCallScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.black)
                .frame(width: .infinity, height: .infinity)
            
            VStack {
                Text("Finding someone to call...")
                    .multilineTextAlignment(.center)
                    .padding()
                    .font(.title)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: 300, alignment: .center)
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "x.circle")
                        .resizable()
                        .foregroundColor(Color.red)
                        .frame(width: 70, height: 70)
                        .aspectRatio(contentMode: .fit)
                }
            }
            .ignoresSafeArea(.all)
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            
        }
        .ignoresSafeArea(.all)
    }
}

struct matchRandomMessageScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.black)
                .frame(width: .infinity, height: .infinity)
            
            VStack {
                Text("Finding someone to message...")
                    .multilineTextAlignment(.center)
                    .padding()
                    .font(.title)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: 300, alignment: .center)
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "x.circle")
                        .resizable()
                        .foregroundColor(Color.red)
                        .frame(width: 70, height: 70)
                        .aspectRatio(contentMode: .fit)
                }
            }
            .ignoresSafeArea(.all)
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            
        }
        .ignoresSafeArea(.all)
    }
}

struct MessageScreen_Previews: PreviewProvider {
    static var previews: some View {
        MessageScreen()
    }
}
