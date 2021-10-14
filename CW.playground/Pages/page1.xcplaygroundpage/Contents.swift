import SwiftUI
import PlaygroundSupport
import AVFoundation


PlaygroundPage.current.setLiveView(page1_0())

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


//INTRO CHAPTER
struct page1_0: View{
    @State private var fontSize: CGFloat = 50
    var body: some View{
        
        ZStack{
            Color.black
            .onAppear( ){
             SoundManager.instance.playsound(string: "notfornothing")
             }
            Text("POINT OF VIEW")
                .animatableSystemFont(size: fontSize,weight: .regular)
                .foregroundColor(.white)
                .onAppear{
                    withAnimation(.spring(response: 4.5, dampingFraction: 1, blendDuration: 1)) {
                        fontSize = 28}
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.5){
                    label:do {
                        PlaygroundPage.current.setLiveView(page1_1())
                        
                    }
                    }
                }.frame(width:400,height: 600)
            
        }
        
    }
}

//CHAPTER 1 SCENE 1

struct page1_1: View {
    @State var i=0
    @State var PositionY = -40
    @State var PositionX = -150
    @State var isAnimating = false
    
    let array = ["Once upon a time, there was a city in grayscale. Everything was gray: the houses, the objects and even the inhabitants of the city themselves. ","One of the inhabitants of this town, Rob, had a peculiarity: he saw the world in a different way than all the others of his kind.","He could see a multitude of different colors than the usual grayscale. "]
    @ViewBuilder
    var body: some View {
        
        ZStack{
            //BACKGROUND GRADIENT
            LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .bottom, endPoint: .top)
            
            
            
            
            VStack{
                ZStack{
                    //BACKGROUND IMAGE
                    if i<2{
                        Image(uiImage: UIImage(named: "city")!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 400,alignment: .topLeading)
                            .clipped()
                    }
                    if i>=2{
                        Image(uiImage: UIImage(named: "coloredcity")!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 400,alignment: .topLeading)
                            .clipped()
                    }
                    
                    //BLOBS
                    Spacer()
                    if i == 0 {
                        HStack{
                            Image(uiImage: UIImage (named:"grey")!)
                                .resizable()
                                .frame(width: 100, height: 80)
                                .padding(EdgeInsets(top: 120, leading: 200, bottom: -80, trailing: 0))
                                .offset(y:CGFloat(PositionY))
                                .animation(Animation.easeInOut(duration: 0.8).repeatForever())
                                .onAppear{
                                    PositionY-=50
                                }
                        }
                        
                        HStack{
                            Image(uiImage: UIImage (named:"grey")!)
                                .resizable()
                                .frame(width: 100, height: 80)
                                .padding(EdgeInsets(top: 120, leading: 0, bottom: -80, trailing: 200))
                                .offset(y:CGFloat(PositionY))
                                .animation(Animation.easeInOut(duration: 0.7).repeatForever())
                                .onAppear{
                                    PositionY-=0
                                }
                        }
                    }
                    if i == 1 {
                        Image(uiImage: UIImage (named:"rob")!)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .padding(EdgeInsets(top: 100, leading: 0, bottom: 0, trailing: 200))
                            .offset(x:CGFloat(PositionX))
                            .animation(Animation.easeOut(duration: 3))
                            .onAppear{
                                PositionX+=300
                            }
                    }
                    if i >= 2 {
                        Image(uiImage: UIImage (named:"rob")!)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .padding(EdgeInsets(top: 100, leading: 100, bottom: -180, trailing: 0))
                            .offset(y:CGFloat(PositionY))
                            .animation(Animation.easeInOut(duration: 0.8).repeatForever())
                            .onAppear{
                                PositionY-=40
                            }
                    }
                    
                    
                    
                    //  .frame(width: 100)
                    //with .frame u can move characters on the zstack
                    
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
                
                
                //SHOW THE BUTTON FOR THE NEXT SCENE
                if(i>=array.count-1) {
                    Spacer()
                    Button("NEXT"){
                        AudioServicesPlaySystemSound(1103)
                    label:do{
                        PlaygroundPage.current.setLiveView(page1_2())
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



//PAGE 2
struct page1_2: View {
    @State var i=0
    let array = ["He had realized this as a child when he tried to explain to his parents that the broccoli they were eating was not light gray but another color - which he called green."]
    var body: some View {
        
        ZStack{
            //BACKGROUND GRADIENT
            LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .bottom, endPoint: .top)
            
            VStack{
                ZStack{
                    //BACKGROUND IMAGE
                    Image(uiImage: UIImage(named: "kitchen")!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 400,alignment: .topLeading)
                    //.border(.blue)
                        .clipped()
                    
                    //ROB IMAGE
                    HStack{
                        Image(uiImage: UIImage (named:"broccoli")!)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding(EdgeInsets(top: -60, leading: 100, bottom: 0, trailing: 0))
                    }
                    HStack{
                        Spacer()
                        Image(uiImage: UIImage (named:"rob")!)
                            .resizable()
                            .frame(width: 80, height: 80)
                            .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 265))
                    }
                    HStack{
                        Spacer()
                        Image(uiImage: UIImage (named:"mom")!)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 45))
                            
                    }
                    HStack{
                        Spacer()
                        Image(uiImage: UIImage (named:"dad")!)
                            .resizable()
                            .frame(width: 100, height: 100)
                           // .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 150))
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

//:[Next](@next)
