//
//  MetronomeView.swift
//  SlowJoggingTimer
//
//  Created by YiJou  on 2025/8/3.
//
// 建立節拍器視圖，並且加入發聲(滴答聲)功能
import SwiftUI


struct MetronomeView: View {
    @Binding var bpm: Double
    
    var body: some View {
        
        VStack(spacing: 10) {
            Text("節拍器設定")
                .font(.headline)
                .foregroundStyle(.blue)
            
            Text("\(Int(bpm)) BPM")
                .font(.title3)
                .bold()
                .foregroundStyle(.gray)
            
            Slider(value: $bpm, in: 120...240, step: 10)
                .accentColor(.blue)
                .padding(.horizontal, 30)
        }
        .padding()
        .background(Color(.systemGray5))
        .cornerRadius(12)
    }
}

    
    #Preview {
        MetronomeView(bpm: .constant(180.0))
    }
                
                





