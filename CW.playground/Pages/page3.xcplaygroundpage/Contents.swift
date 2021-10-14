//:[Previous](@previous)

import SwiftUI
import PlaygroundSupport
import AVFoundation

 
// BUTTON STYLE FUNCTION
struct GreyButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(configuration.isPressed ? Color.yellow : Color.gray)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.3), value: configuration.isPressed)
    }
    
}
 
 
 
// CLASS FOR SOUND BACKGROUND
class SoundManager{
    
    static let instance = SoundManager()
    
    var player : AVAudioPlayer?
    
    func playsound (string : String){
        
        guard let url = Bundle.main.url(forResource: string, withExtension: ".mp3")
        else {return}
        do{
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            player?.volume = 2.0
        }catch let error {
            print("Error playing sound \(error.localizedDescription)")
        }
    }
    
}
 
//TEXT ANIMATION
 
struct AnimatableSystemFontModifier: AnimatableModifier {
    var size: CGFloat
    var weight: Font.Weight
    var design: Font.Design
    
    var animatableData: CGFloat {
        get { size }
        set { size = newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: size, weight: weight, design: design))
    }
}
 
 
extension View {
    func animatableSystemFont(size: CGFloat, weight: Font.Weight = .regular, design: Font.Design = .default) -> some View {
        self.modifier(AnimatableSystemFontModifier(size: size, weight: weight, design: design))
    }
}
  
//CHAPTER 3 SCENE 1
 
struct page3_1: View {
    @State var i=0
    @State var PositionY = -40
    @State var PositionX = -150
    @State var isAnimating = false
    @State var isAnimatingop = false
    
    let array = ["One day, while he was turning the corner of a street, he collided with another blob.","In the impact, the two blobs hit their heads.                                                                                       ㅤ","Rob apologized and wanted to continue on his way, but the blob he had bumped into started screaming: “Where are the colors? Where is the grey?”. "]
    @ViewBuilder
    var body: some View {
        
        ZStack{
            //BACKGROUND GRADIENT
            LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .bottom, endPoint: .top)
                .onAppear( ){
                 SoundManager.instance.playsound(string: "piano")
                 }
            
            
            
            VStack{
                ZStack{
                    //BACKGROUND IMAGE
                  
                        Image(uiImage: UIImage(named: "city")!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 400,alignment: .topLeading)
                            .clipped()
                    
                    
                    //BLOBS
                    Spacer()
                    if i == 0 {
                        HStack{
                            Image(uiImage: UIImage (named:"sadrob")!)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .padding(EdgeInsets(top: 50, leading: 100, bottom: -70, trailing: 100))
                                .offset(x:CGFloat(PositionX))
                                .animation(Animation.easeInOut(duration: 1))
                                .onAppear{
                                    PositionX+=58
                                }
                        }
                        
                        HStack{
                            Image(uiImage: UIImage (named:"greyashhappy")!)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .padding(EdgeInsets(top: 50, leading: 100, bottom: -70, trailing: 100))
                                .offset(x:CGFloat(PositionX))
                                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                                .animation(Animation.easeInOut(duration: 1))
                                .onAppear{
                                    PositionX+=50
                                }
                        }
                    }
                    if i == 1 {
                        HStack{
                            Image(uiImage: UIImage (named:"sadrob")!)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .padding(EdgeInsets(top: 50, leading: 100, bottom: -70, trailing: 100))
                                .offset(x:CGFloat(PositionX))
                        
                        }
                        
                        HStack{
                            Image(uiImage: UIImage (named:"greyash")!)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .padding(EdgeInsets(top: 50, leading: 100, bottom: -70, trailing: 100))
                                .offset(x:CGFloat(PositionX))
                                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                        }
                          
                        HStack{
                            Image(uiImage: UIImage (named:"explosion")!)
                                .resizable()
                                .frame(width: 80, height: 80)
                                .padding(EdgeInsets(top: 0, leading: 180, bottom: -50, trailing: 100))
                                .offset(x:CGFloat(PositionX))
                                
                        }
                    }
                    if i >= 2 {
                        HStack{
                            Image(uiImage: UIImage (named:"sadrob")!)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .padding(EdgeInsets(top: 50, leading: 100, bottom: -70, trailing: 100))
                                .offset(x:CGFloat(PositionX))
                        
                        }
                        
                        HStack{
                            Image(uiImage: UIImage (named:"sadash")!)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .padding(EdgeInsets(top: 50, leading: 100, bottom: -70, trailing: 100))
                                .offset(x:CGFloat(PositionX))
                                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                            }
                     }
                }
                
                if i<array.count{
                    
                    Text(array[i])
                        .padding(EdgeInsets(top: 25, leading: 0, bottom: 0, trailing: 0))
                        .frame(width: 350)
                        .lineLimit(6) //KNOW WHEN THE TEXT IS TOO LONG (...)
                        .font(.custom("Helvetica", size: 20))
                        .onTapGesture {
                            i=i+1 //out of index
                            
                            
                        }
                    
                    //FRECCIA BALLERINA
                    if i<array.count-1 {
                        Text(">>")
                            .opacity(self.isAnimatingop ? 0.2: 1)
                            .animation(Animation.linear(duration:1).repeatForever())
                            .onAppear {
                                self.isAnimatingop = true
                            }
                            .padding(EdgeInsets(top: 20, leading: 300, bottom: 0, trailing: 0))
                    }
                }
                else{
                    Text(array[array.count-1])
                        .padding(EdgeInsets(top: 25, leading: 0, bottom: 0, trailing: 0))
                        .frame(width: 350)
                        .lineLimit(6) //KNOW WHEN THE TEXT IS TOO LONG (...)
                        .font(.custom("Helvetica", size: 20))
                }
                
                
                //SHOW THE BUTTON FOR THE NEXT SCENE
                if(i>=array.count-1) {
                    Spacer()
                    Button("NEXT"){
                        AudioServicesPlaySystemSound(1103)
                    label:do{
                        PlaygroundPage.current.setLiveView(page3_2())
                    }
                        
                    }.buttonStyle(GreyButton())
                }
                
                
                
                Spacer()
                
                // Spacer()
            }
            .frame(height:600)
        }
    }
}
 
 
 
//CHAPTER 3 SCENA 2
struct page3_2: View {
    @State var isAnimating = false
    @State var i=0
    let array = ["At first, Rob did not immediately understand what had happened, and asked: \"What do you see?\".","The other replied: \"There is no more grey, I see everything different\".                                                                                        ㅤ","Then Rob realized that perhaps even the stranger was able to see colors like him and hypothesized that it was the contact with him that caused this to happen."]
    var body: some View {
        
        ZStack{
            //BACKGROUND GRADIENT
            LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .bottom, endPoint: .top)
                .onAppear( ){
                 SoundManager.instance.playsound(string: "sanstheme")
                 }
            
            VStack{
                ZStack{
                    //BACKGROUND IMAGE
                    Image(uiImage: UIImage(named: "coloredcity")!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 400,alignment: .topLeading)
                    //.border(.blue)
                        .clipped()
                    
                    //ROB IMAGE
                    if i <= 1 {
                    HStack{
                        Spacer()
                        Image(uiImage: UIImage (named:"sadrob")!)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .padding(EdgeInsets(top: 80, leading: 0, bottom: -40, trailing: 220))
                    }
                    }
                    HStack{
                        Spacer()
                        Image(uiImage: UIImage (named:"sadash")!)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                            .padding(EdgeInsets(top: 80, leading: 0, bottom: -40, trailing: 80))
                            
                    }
                    if i >= 2 {
                    HStack{
                        Spacer()
                        Image(uiImage: UIImage (named:"rob")!)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .padding(EdgeInsets(top: 80, leading: 0, bottom: -40, trailing: 220))
                    }
                    }
                    
                    // TEXT BUBBLES
                  if i < 1 {
                    HStack{
                        Spacer()
                        Image(uiImage: UIImage (named:"baloon")!)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .padding(EdgeInsets(top: 80, leading: 0, bottom: 100, trailing: 150))
                    }
                      ZStack{
                      Text("Bloba blob blibub blub ora ora?")
                              .padding(EdgeInsets(top: -50, leading: 0, bottom: 0, trailing: 0))
                              .frame(width: 80)
                              .font(.custom("Sans", size: 16))
                          
                      }
                      
                }
                      if i == 1 {
                          HStack{
                              Spacer()
                              Image(uiImage: UIImage (named:"baloon")!)
                                  .resizable()
                                  .frame(width: 100, height: 100)
                                  .padding(EdgeInsets(top: 80, leading: 150, bottom: 100, trailing: 0))
                                  .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                          }
                            ZStack{
                            Text("Blobbichu blobatch em blob")
                                    .padding(EdgeInsets(top: -50, leading: 28, bottom: 0, trailing: 20))
                                    .frame(width: 120)
                                    .font(.custom("Sans", size: 16))
                      }
                  }
                    
                }
                
                if i<array.count{
                    
                    Text(array[i])
                        .padding(EdgeInsets(top: 25, leading: 0, bottom: 0, trailing: 0))
                        .frame(width: 350)
                        .lineLimit(6) //KNOW WHEN THE TEXT IS TOO LONG (...)
                        .font(.custom("Helvetica", size: 20))
                        .onTapGesture {
                            i=i+1 //out of index
                        }
                    if i<array.count-1 {
                        Text(">>")
                            .opacity(self.isAnimating ? 0.2: 1)
                            .animation(Animation.linear(duration: 1).repeatForever())
                            .onAppear {
                                self.isAnimating = true
                            }
                            .padding(EdgeInsets(top: 20, leading: 300, bottom: 0, trailing: 0))
                    }
                }
                else{
                    Text(array[array.count-1])
                        .padding(EdgeInsets(top: 25, leading: 0, bottom: 0, trailing: 0))
                        .frame(width: 350)
                        .lineLimit(6) //KNOW WHEN THE TEXT IS TOO LONG (...)
                        .font(.custom("Helvetica", size: 20))
                }
                Spacer()
            }
            .frame(height:600)
        }
    }
}



PlaygroundPage.current.setLiveView(page3_1())

//:[Next](@next)
