//
//  MenuScreen.swift
//  Language-Learning-App
//
//  This file contains the forum screen, which is what the user first sees when they log in. They can click on posts, view notifications, and add their own post.
//
//  Created by ECC Chicago on 7/26/22.
//

import SwiftUI

// information for each post
struct Post: Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var image: String
    var message: String
    var date: String
    var index: Int
}

// creates the layout for the screen
struct MenuScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // array of posts from other users
    @State var posts: [Post] = [
        Post(name: "Sam", image: "profileOnePic", message: "有人想一起练习中文吗？请加我！", date: "8-2-2022", index: 1),
        Post(name: "Nicole", image: "profileTwoPic", message: "I'm looking for someone to practice my Spanish with before an interview. Please add/message me if you'd be interested in helping. Thank you!", date: "7-29-2022", index: 2),
        Post(name: "Brian", image: "profileThreePic", message: "¿alguienpuede ayudarme a practicar para mi examen oral de español?", date: "7-27-2022", index: 3),
        Post(name: "Louisa", image: "profileFourPic", message: "If anyone is available right now I'd love to practice talking in English", date: "7-20-2022", index: 4)]
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .center) {
                    // scroll view that creates every post
                    ScrollView {
                        ForEach(posts) { index in
                            PostDesign(post: index)
                        }
                    }
                }
                .navigationBarBackButtonHidden(true)
                
                // add post button
                NavigationLink(destination: AddPost(posts: $posts), label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .background(Color.white)
                        .foregroundColor(Color(red: 0.40784313725490196, green: 0.6235294117647059, blue: 0.2196078431372549))
                        .clipShape(Circle())
                        .shadow(radius: 10)
                })
                .offset(x:130, y: 280)
            }
            .background(Color(hue: 0.256, saturation: 0.17, brightness: 0.82))
            .navigationTitle("Forum")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing: Button(action: {}, label: {
                    NavigationLink(destination: Notifications()) {
                        Image(systemName: "bell.circle")
                            .resizable()
                            .foregroundColor(Color.white)
                            .frame(width: 30, height: 30)
                            .aspectRatio(contentMode: .fit)
                            .offset(x: -5, y: -6)
                    }
                })
            )
        }
        // navigation bar customization
        .onAppear {
            let appearance = UINavigationBarAppearance()
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

// code to design individual posts
struct PostDesign: View {
    var comment: String = ""
    var post: Post
    var body: some View {
        NavigationLink(destination: CommentView(postScreen: post), label: {
            ZStack {
                VStack {
                    HStack {
                        Image(post.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .shadow(radius: 10)
                        Text(post.name)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    HStack {
                        Text(post.message)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, maxHeight: 100,  alignment: .leading)
                    }
                    Divider()
                    HStack {
                        Spacer()
                        Image("Tokki50")
                            .resizable()
                            .frame(width: 100, height: 25, alignment: .leading)
                            .aspectRatio(contentMode: .fit)
                            .offset(x: -180, y: 4)
                        Text(post.date)
                            .frame(maxWidth: 90, alignment: .trailing)
                            .font(.body)
                            .offset(x: 2, y: 4)
                    }
                }
                .font(.system(size: 24, design: .rounded))
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 2, y: 2)
            }
        })
        .tint(.black)
    }
}

// screen when user clicks on a post
struct CommentView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let postScreen: Post
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Image(postScreen.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                    Text(postScreen.name)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                HStack {
                    Text(postScreen.message)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, maxHeight: .infinity,  alignment: .leading)
                }
                Divider()
                HStack {
                    Group {
                        Spacer()
                        Text(postScreen.date)
                            .frame(maxWidth: 150, alignment: .trailing)
                    }
                }
            }
            .font(.system(size: 24, design: .rounded))
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 2, y: 2)
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Forum Post")
            .toolbar {
                ToolbarItem(placement: .navigation){
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left.circle")
                            .resizable()
                            .foregroundColor(Color.white)
                            .frame(width: 30, height: 30)
                            .aspectRatio(contentMode: .fit)
                            .offset(x: 10, y: -5)
                    }
                }
            }
        }
        .background(Color(hue: 0.256, saturation: 0.02, brightness: 0.979))
    }
}

// screen to create a post
struct AddPost: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var postContent: String = ""
    @Binding var posts: [Post]
    
    var body: some View {
        VStack {
            Group {
                Rectangle()
                    .frame(height: 10)
                    .foregroundColor(Color.clear)
                Text("Type your post here:")
                    .font(.title2)
                    .multilineTextAlignment(.leading)
                    .offset(x: -75)
                TextEditor(text: $postContent)
                    .autocapitalization(.none)
                    .padding()
                    .foregroundColor(Color.black)
                    .frame(width: 350, height: 300)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(red: 0.40784313725490196, green: 0.6235294117647059, blue: 0.2196078431372549), lineWidth: 3)
                    )
                    .cornerRadius(10)
            }
            Spacer()
        }
        .navigationBarTitle(("Make a Post"), displayMode: .inline)
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
                        .aspectRatio(contentMode: .fit)
                        .offset(x: 10, y: -5)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .automatic){
                Button(action: {
                    if postContent != "" {
                        posts.insert(appendPost(), at: 0)
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Image(systemName: "paperplane.circle")
                        .resizable()
                        .foregroundColor(Color.white)
                        .frame(width: 30, height: 30)
                        .aspectRatio(contentMode: .fit)
                        .offset(x: -5, y: -6)
                }
            }
        }
    }
    
    // function that creates Post
    func appendPost() -> Post {
        let userPost = Post(name: "Tokki", image: "iconWBg", message: postContent, date: "8-4-2022", index: 0)
        return userPost
    }
}

// notifications screen
struct Notifications: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ScrollView {
            Group {
                HStack {
                    Image("profileFourPic")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .offset(y:3)
                    Text("You were on a call with Louisa")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .offset(y:3)
                }
                .padding()
                Divider()
                HStack {
                    Image("profileFourPic")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .offset(y:3)
                    Text("Louisa added you")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .offset(y:3)
                }
                .padding()
                Divider()
                HStack {
                    Image("profileThreePic")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .offset(y:3)
                    Text("You were on a call with Brian: 40:32")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .offset(y:3)
                }
                .padding()
                Divider()
                HStack {
                    Image("profileThreePic")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .offset(y:3)
                    Text("Brian added you")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .offset(y:3)
                }
                .padding()
                Divider()
                HStack {
                    Image("profileOnePic")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .offset(y:3)
                    Text("You were on a call with Sam: 10:34")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .offset(y:3)
                }
                .padding()
                Divider()
            }
            Group {
                HStack {
                    Image("profileTwoPic")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .offset(y:3)
                    Text("You were on a call with Nicole: 1:00:43")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .offset(y:3)
                }
                .padding()
                Divider()
                HStack {
                    Image("profileTwoPic")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .offset(y:3)
                    Text("Missed call from Nicole")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .offset(y:3)
                }
                .padding()
                Divider()
                HStack {
                    Image("profileOnePic")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                    
                        .offset(y:3)
                    Text("You were on a call with Sam: 40:21")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .offset(y:3)
                }
                .padding()
                Divider()
                HStack {
                    Image("profileTwoPic")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .offset(y:3)
                    Text("Nicole added you")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .offset(y:3)
                }
                .padding()
                Divider()
                HStack {
                    Image("profileOnePic")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .offset(y:3)
                    Text("Sam added you")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .offset(y:3)
                }
                .padding()
                Divider()
            }
            
        }
        .navigationTitle("Notifications")
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
                        .aspectRatio(contentMode: .fit)
                        .offset(x: 10, y: -5)
                }
            }
        }
    }
}

struct MenuScreen_Previews: PreviewProvider {
    static var previews: some View {
        MenuScreen()
    }
}
