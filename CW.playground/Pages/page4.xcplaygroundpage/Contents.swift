//: [Previous](@previous)

import Foundation
import SwiftUI
import UIKit
import PlaygroundSupport
import AVFoundation

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

struct LivingRoomDiscussion: View {
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .gray
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        UISegmentedControl.appearance().backgroundColor = .lightGray
    }
    
    @State var i = 0
    let array = ["""
                As the other blob told Rob, there were other blobs wondering about their grey worldview.
                The two decided to share their peculiarity with whoever wanted to see the world with new eyes.
                """, """
They found out that yes, not everyone was ready to that change, but when a blob would have been brave enough to call themselves into question, sharing this new colorful point of view was a great idea.
"""]
    @State var isAnimating = false
 
    var text: String = "Choose your ending!"
    @State var animation = false
    
    @State var positionXgreenNC = 0
    @State var positionYgreenNC = 0
    @State var positionXrobNC = 0
    @State var positionYrobNC = 0
    
    @State var positionXgreenGR = 0
    @State var positionYgreenGR = 0
    @State var positionXrobGR = 0
    @State var positionYrobGR = 0
    
    @State var positionXgray1GR = -100
    @State var positionYgray1GR = 0
    @State var positionXgray2GR = 100
    @State var positionYgray2GR = 0
    
    @State var positionXgreenCL = 0
    @State var positionYgreenCL = 100
    @State var positionXrobCL = 0
    @State var positionYrobCL = 100
    
    @State var positionXgray1CL = 0
    @State var positionYgray1CL = 70
    @State var positionXgray2CL = 0
    @State var positionYgray2CL = 70
    
    @State var selectedEnd = "No choice"
    let ends = ["Grey", "No choice", "Colored"]
    let endsSelection = ["Grey", "Colored"]
 
 
    
    var body: some View {
        ZStack {
            switch selectedEnd {
            case "No choice":
                LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .bottom, endPoint: .top)
            case "Grey":
                LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .bottom, endPoint: .top)
            case "Colored":
                LinearGradient(gradient: Gradient(colors: [.white, .orange]), startPoint: .bottom, endPoint: .top)
            default:
                Text("Enjoy your bug!")
            }
            VStack {
                switch selectedEnd {
                case "No choice":
                    ZStack {
                        VStack {
                            Image(uiImage: UIImage(named: "puff.png")!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 400)
                                .clipped()
                                .onAppear( ){
                                 SoundManager.instance.playsound(string: "notfornothing")
                                 }
 
                            Spacer()
 
                        }
                        VStack {
                            Spacer()
                            HStack {
                                Image(uiImage: UIImage(named: "ash.png")!)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .offset(x: CGFloat(positionXgreenNC), y: CGFloat(positionYgreenNC))
                                    .animation(Animation.easeOut(duration: 10))
                                    .onAppear() {
                                        positionXgreenNC = 210
                                        positionYgreenNC = 115
                                    }
                                Spacer()
                            }
                            .frame(width: 400)
                        }
                        .frame(height: 130)
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Image(uiImage: UIImage(named: "rob.png")!)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .offset(x: CGFloat(positionXrobNC), y: CGFloat(positionYrobNC))
                                    .animation(Animation.easeOut(duration: 10))
                                    .onAppear() {
                                        positionXrobNC = 75
                                        positionYrobNC = 85
                                        
                                    }
                            }
                            .frame(width: 250)
                        }
                        .frame(height: 190)
                    }
                    
                case "Grey":
                    ZStack {
                        VStack {
                            Image(uiImage: UIImage(named: "city.png")!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 400)
                                .clipped()
 
                            Spacer()
                        }
                        VStack {
                            HStack {
                                Image(uiImage: UIImage(named: "grey.png")!)
                                    .resizable()
                                    .frame(width: 100, height: 80)
                                    .offset(x: CGFloat(positionXgray1GR), y: CGFloat(positionYgray1GR))
                                    .animation(Animation.easeOut(duration: 10))
                                    .onAppear() {
                                        positionXgray1GR = 100
                                        positionYgray1GR = 105
                                    }
                                Spacer()
                                Image(uiImage: UIImage(named: "grey.png")!)
                                    .resizable()
                                    .frame(width: 100, height: 80)
                                    .offset(x: CGFloat(positionXgray2GR), y: CGFloat(positionYgray2GR))
                                    .animation(Animation.easeOut(duration: 10))
                                    .onAppear() {
                                        positionXgray2GR = -100
                                        positionYgray2GR = 105
                                    }
                            }
                            HStack {
                                Spacer()
                                Image(uiImage: UIImage(named: "ash.png")!)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .offset(x: CGFloat(positionXgreenGR), y: CGFloat(positionYgreenGR))
                                    .animation(Animation.easeOut(duration: 10))
                                    .onAppear() {
                                        positionXgreenGR = -330
                                        positionYgreenGR = 130
                                    }
                                Image(uiImage: UIImage(named: "rob.png")!)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .offset(x: CGFloat(positionXrobGR), y: CGFloat(positionYrobGR))
                                    .animation(Animation.easeOut(duration: 10))
                                    .onAppear() {
                                        positionXrobGR = 330
                                        positionYrobGR = 130
                                    }
                                Spacer()
                            }
 
                        }
                    }
                    
                case "Colored":
                    ZStack {
                        VStack {
                            Image(uiImage: UIImage(named: "coloredcity.png")!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 400)
                                .clipped()
 
                            Spacer()
                        }
                        VStack {
                            HStack {
                                Image(uiImage: UIImage(named: "ash.png")!)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .offset(x: CGFloat(positionXgreenCL), y: CGFloat(positionYgreenCL))
                                    .animation(Animation.easeOut(duration: 10).repeatForever(autoreverses: true).speed(4))
                                    .onAppear() {
                                        positionXgreenCL = 105
                                        positionYgreenCL = 190
                                    }
                                Spacer()
                                Image(uiImage: UIImage(named: "rob.png")!)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .offset(x: CGFloat(positionXrobCL), y: CGFloat(positionYrobCL))
                                    .animation(Animation.easeOut(duration: 10).repeatForever(autoreverses: true).speed(4))
                                    .onAppear() {
                                        positionXrobCL = -105
                                        positionYrobCL = 190
                                    }
                            }
                            HStack {
                                Spacer()
                                Image(uiImage: UIImage(named: "grey.png")!)
                                    .resizable()
                                    .frame(width: 100, height: 80)
                                    .offset(x: CGFloat(positionXgray1CL), y: CGFloat(positionYgray1CL))
                                    .animation(Animation.easeOut(duration: 4))
                                    .onAppear() {
                                        positionXgray1CL = -200
                                        positionYgray1CL = 160
                                    }
                                Image(uiImage: UIImage(named: "grey.png")!)
                                    .resizable()
                                    .frame(width: 100, height: 80)
                                    .offset(x: CGFloat(positionXgray2CL), y: CGFloat(positionYgray2CL))
                                    .animation(Animation.easeOut(duration: 4))
                                    .onAppear() {
                                        positionXgray2CL = 200
                                        positionYgray2CL = 160
                                    }
                                Spacer()
 
                            }
                            Spacer()
                        }
                        .frame( height: 400)
                    }
                default:
                    Text("Enjoy your bug!")
                }
 
                switch selectedEnd {
                case "No choice":
                    Text("""
                    Rob then helped the stranger get used to his new "world view".
                    Once the stranger got used to colors, said: "Why don't we try to convince others to see the world as we do?".
                    """)
                        .font(Font.custom("Helvetica", size: 16))
                        .multilineTextAlignment(.leading)
                        .frame(width: 350)
                case "Grey":
                    Text("""
                        And Rob, who had tried to convince other blobs in the past, said: “Better not, people don't like changes. They prefer to live in ignorance of a grey world rather than go further and see one with a multitude of colors“.
                        """)
                        .font(Font.custom("Helvetica", size: 15))
                        .multilineTextAlignment(.leading)
                        .frame(width: 350)
                case "Colored":
                    //TEXT CHANGE + INDEX LIMIT
                            if i < array.count {
                                Text(array[i])
                                    .multilineTextAlignment(.leading)
                                    .padding(EdgeInsets(top: -32, leading: 0, bottom: 0, trailing: 0))
                                    .font(Font.custom("Helvetica", size: 15))
                                    .frame(width: 350)
                                    .lineLimit(7) //KNOW WHEN THE TEXT IS TOO LONG (...)
                                    .onTapGesture {
                                        i=i+1 //out of index
                                    }
                                //BLINKING CONTINUE "BUTTON"
                                if i==0 {
                                    ZStack {
                                        Text(">>")
                                            .font(Font.custom("Helvetica", size: 15))
                                            .padding(EdgeInsets(top: 0, leading: 300, bottom: 0, trailing: 0))
                                            .opacity(self.isAnimating ? 0.2: 1)
                                            .animation(Animation.easeOut(duration: 10).repeatForever(autoreverses: true).speed(4))
                                            .onAppear {
                                                    self.isAnimating = true
                                                    }
 
                                    }
                                }
                            }
                            else {
                                Text(array[1])
                                   .padding(EdgeInsets(top: -32, leading: 0, bottom: 0, trailing: 0))
                                    .frame(width: 350)
                                    .lineLimit(7)
                                    .font(Font.custom("Helvetica", size: 15))
                                    .multilineTextAlignment(.leading)
 
                            }
 
 
                default:
                    Text("Enjoy your bug!")
                }
                Text(text)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                    .padding()
                    .font(Font.custom("Helvetica", size: 13))
                    .background(Color.gray).opacity(1)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .frame(width: 300)
                Spacer()
                Picker("Choose your end !", selection: $selectedEnd) {
                    ForEach(endsSelection, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                .frame(width: 300)
                Spacer()
            }
        } .frame(width: 400, height: 600)
    }
}
 
 
PlaygroundPage.current.setLiveView(LivingRoomDiscussion())
