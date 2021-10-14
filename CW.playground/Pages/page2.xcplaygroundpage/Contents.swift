//:[Previous](@previous)

import SwiftUI
import PlaygroundSupport
import AVFoundation

// CLASS FOR SOUND BACKGROUND (MUSIC ON GRADIENT)
class SoundManager{

    static let instance = SoundManager()

    var player : AVAudioPlayer?
   
    func playsound (string : String){
       
        guard let url = Bundle.main.url(forResource: string, withExtension: ".mp3")
        else {return}
        do{
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            player?.volume = 5.0
        }catch let error {
            print("Error playing sound \(error.localizedDescription)")
        }
    }
    

}

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

//SCENE 1
struct page2_1: View {
    var body: some View {
        
        ZStack{
            //BACKGROUND GRADIENT
            LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .bottom, endPoint: .top)
            //MUSIC
                .onAppear( ){
                    SoundManager.instance.playsound(string: "rest")
                            }
            
            VStack{
                ZStack{
                    //BACKGROUND IMAGE
                    Image(uiImage: UIImage(named: "medic")!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 400,alignment: .topLeading)
                    //.border(.blue)
                        .clipped()
                    
                    
                    //DOCTOR IMAGE
                    HStack{
                        Spacer()
                        Image(uiImage: UIImage (named:"doctor")!)
                            .resizable()
                            .frame(width: 100, height: 100)
                    } //HSTACK MOVEMENT
                    .frame(width:300)
                    
                    //ROB
                    HStack{
                        Image(uiImage: UIImage (named:"rob")!)
                            .resizable()
                            .frame(width: 80, height: 80)
                            .padding(EdgeInsets(top:-30, leading: -100, bottom: 50, trailing: 150))
                    }
                    
                    //BALOON
                    HStack{
                    Image(uiImage: UIImage(named: "baloon")!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200,height:110,alignment: .topLeading)
                        .clipped()
                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                        .padding(EdgeInsets(top: 15, leading: -100, bottom: 90, trailing: -40))
                    }
                    ZStack{
                        Text("Blobbity blob blobbity blobblobbity blobblobbity blobblobbity blob")
                            .font(.custom("Sans", size: 16))
                            .lineLimit(3)
                            .frame(width: 100, height: 100)
                            .padding(EdgeInsets(top: 0, leading: 22, bottom: 105, trailing: 0))
                    }
                    //PARENTS
                    HStack{
                        Image(uiImage: UIImage (named:"mom")!)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .padding(EdgeInsets(top: 195, leading: -170, bottom: 0, trailing: 0))
                        Image(uiImage: UIImage (named:"dad")!)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                            .padding(EdgeInsets(top: 195, leading: -100, bottom: 0, trailing: 0))
                    }
                }
                    
                    Text("His parents, worried about his problem,  took him to an ophthalmologist who, however, did not find any problems in Rob's vision.")
                        .padding(EdgeInsets(top: 25, leading: 0, bottom: 0, trailing: 0))
                        .frame(width: 350)
                        .lineLimit(6) //KNOW WHEN THE TEXT IS TOO LONG (...)
                        .font(.custom("Helvetica", size: 18))
                
                Spacer()
                //CHANGE SCENE BUTTON
                Button("NEXT"){
                AudioServicesPlaySystemSound(1103)
                label:do {PlaygroundPage.current.setLiveView(page2_2())
                }
                    
                }.buttonStyle(GreyButton())
                Spacer()
            }
            .frame(height:600)
        }
    }
}

//SCENE 2
struct page2_2: View {
    @State var i=0
    @State private var opacity = 1.0
    @State var isAnimating = false
    @State var isAnimatingblob = false
    @State var robsitionX = 189.0
    @State var robsitionY = 50.0
    @State var positionY = 0
    @State var ghostposX = -450
    @State var ghostposY = 0.0
    let array = ["Rob had tried explaining to the other blobs how he saw the world and all its various shades. He began to give different names to the various colors he saw: the sky was blue, the grass was green, the sun was yellow.", "No one wanted to listen to him though and slowly he was labeled as a delusional madman. The other blobs, for fear of being infected by his disease, avoided contact with him and this led him to be more and more marginalized and isolated from the likes of him."]
    var body: some View {
        
        ZStack{
            //BACKGROUND GRADIENT
            LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .bottom, endPoint: .top)
            
            VStack{
                ZStack{
                    //BACKGROUND IMAGE
                    Image(uiImage: UIImage(named: "puff")!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 400,alignment: .topLeading)
                    //.border(.blue)
                        .clipped()
                    
                    //ROB AND BLOBS IMAGES
                    if i==0 { //DISPLAY FIRST SCENE
                    HStack{
                        Image(uiImage: UIImage (named:"grey")!)
                            .resizable()
                            .frame(width: 100, height: 80)
                            .offset(y: CGFloat(positionY))
                            .animation(Animation.easeInOut(duration: 0.8).repeatForever(), value: positionY) // <4>
                                        .onAppear {
                                              positionY-=40
                                        }
                            .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 300))
                    }
                    HStack{
                        Image(uiImage: UIImage (named:"grey")!)
                            .resizable()
                            .frame(width: 100, height: 80)
                            .offset(y: CGFloat(positionY))
                            .animation(Animation.easeInOut(duration: 0.7).repeatForever(), value: positionY)
                                        .onAppear {
                                              positionY-=0
                                        }
                            .padding(EdgeInsets(top: 160, leading: 0, bottom: 0, trailing: 280))
                    }
                    HStack{
                        Image(uiImage: UIImage (named:"rob")!)
                            .resizable()
                            .frame(width: 80, height: 80)
                            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                            .padding(EdgeInsets(top: 100, leading: 120, bottom: 0, trailing: 0))
                        }
                    //BALOON
                    HStack{
                        Image(uiImage: UIImage(named: "baloon")!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200,height:110,alignment: .topLeading)
                            .clipped()
                            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 140))
                        }
                    ZStack{
                            Text("Blabbibboroba bitebo ORA ORA ORA ORA ORA ORA")
                                .font(.custom("Sans", size: 16))
                                .lineLimit(3)
                                .frame(width: 100, height: 100)
                                .padding(EdgeInsets(top: 70, leading: -59, bottom: 105, trailing: 0))
                        }
                    }
                    else{ //DISPLAY SECOND SCENE
                        HStack{
                            Image(uiImage: UIImage (named:"grey")!)
                                .resizable()
                                .frame(width: 100, height: 80)
                                .opacity(self.isAnimatingblob ? 0: 1)
                                .animation(Animation.linear(duration: 1))
                                            .onAppear {
                                                self.isAnimatingblob = true
                                            }
                                .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 300))
                        }
                        HStack{
                            Image(uiImage: UIImage (named:"grey")!)
                                .resizable()
                                .frame(width: 100, height: 80)
                                .opacity(self.isAnimatingblob ? 0: 1)
                                .animation(Animation.linear(duration: 1))
                                            .onAppear {
                                                self.isAnimatingblob = true
                                            }
                                .padding(EdgeInsets(top: 160, leading: 0, bottom: 0, trailing: 280))
                        }
                        HStack{
                            Image(uiImage: UIImage (named:"sadrob")!)
                                .resizable()
                                .frame(width: 80, height: 80)
                                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                                .offset(x: robsitionX, y: robsitionY)
                                .onAppear( ){
                                            SoundManager.instance.playsound(string: "sadcut")
                                            }
                        HStack{
                            Image(uiImage: UIImage (named:"sadrob")!)
                                .resizable()
                                .frame(width: 250, height: 250)
                                .opacity(0.5)
                                .offset(x:CGFloat(ghostposX), y:CGFloat(ghostposY))
                                .animation(Animation.easeOut(duration: 40))
                                .onAppear{
                                    ghostposX+=900
                                }
                                
                        }
                        }
                    }
                }
                
                //TEXT CHANGE + INDEX LIMIT
                if i < array.count {
                    Text(array[i])
                                .padding(EdgeInsets(top: 25, leading: 0, bottom: 0, trailing: 0))
                                .frame(width: 350)
                                .lineLimit(7) //KNOW WHEN THE TEXT IS TOO LONG (...)
                                .font(.custom("Helvetica", size: 16))
                                .onTapGesture {
                                    i=i+1 //out of index
                                }
                       //BLINKING CONTINUE "BUTTON"
                        if i==0 {
                            Text(">>")
                                .opacity(self.isAnimating ? 0.2: 1)
                                .animation(Animation.linear(duration: 1).repeatForever())
                                            .onAppear {
                                                self.isAnimating = true
                                            }
                                .padding(EdgeInsets(top: 20, leading: 300, bottom: 0, trailing: 0))
                        }
                }
                  
                else {
                    Text(array[1])
                        .padding(EdgeInsets(top: 25, leading: 0, bottom: 0, trailing: 0))
                        .frame(width: 350)
                        .lineLimit(7)
                        .font(.custom("Helvetica", size: 16))
                }
                Spacer()
            }
            .frame(height:600)
        }
    }
}
    
PlaygroundPage.current.setLiveView(page2_1())

//:[Next](@next)
