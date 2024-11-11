//
//  ContentView.swift
//  game MTT
//
//  Created by Gaming Lab on 31/10/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var playercard="card2"
    @State var cpucard="card3"
    
    @State var playerscore=0
    @State var cpuscore=0
    
    
    var body: some View {
        ZStack {
            Image("background-plain")
                .resizable().ignoresSafeArea()
            VStack{
                Spacer()
                Image("logo")
                Spacer()
                
                HStack{
                    Spacer()
                    Image(playercard)
                    Spacer()
                    
                    Image(cpucard)
                    Spacer()
                    
                }
                Spacer()
                Button{
                    deal()
                }label: {
                    
                    
                    Image("button")
                }
                Spacer()
                HStack{
                    Spacer()
                    VStack{
                        
                        Text("Player")
                            .font(.headline)
                            .padding(.bottom,10.0)
                        
                        Text(String(playerscore))
                            .font(.largeTitle)
                        
                        
                        
                    }
                    Spacer()
                    VStack{
                        
                        Text("CPU")
                            .font(.headline)
                            .padding(.bottom,10.0)
                        Text(String(cpuscore))
                            .font(.largeTitle)
                    }
                    Spacer()
                }
                Spacer()
            }
            .foregroundColor(.white)
            Spacer()
        }
        
    }
    
    
    func deal(){
        var playerValue = Int.random(in: 2...14)
        playercard = "card" + String(playerValue)
        
        
       var cpucardValue = Int.random(in: 2...14)
        cpucard="card" + String(cpucardValue)
        
        if playerValue > cpucardValue {
            
        playerscore+=1
        }
        else if playerValue < cpucardValue {
            cpuscore+=1
        }
        }
    }
    
    
    
    
    struct ContentView_Previews: PreviewProvider{
        static var previews: some View{
            ContentView()
        }
    }

