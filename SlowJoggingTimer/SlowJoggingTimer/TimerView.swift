//
//  TimerView.swift
//  SlowJoggingTimer
//
//  Created by YiJou  on 2025/8/3.
//

import SwiftUI

struct TimerView: View {
    @Binding var elapsedTime: TimeInterval
    @Binding var targetMinutes: Int
    
    var body: some View {
        let progress = elapsedTime / Double(targetMinutes * 60)
        let progressColor = progress >= 0.8 ? LinearGradient(colors: [.green, Color(red: 0.7, green: 1.0, blue: 0.3)], startPoint: .leading, endPoint: .trailing)
        : LinearGradient(colors: [.blue, .cyan], startPoint: .leading, endPoint: .trailing)
        
        VStack(spacing: 20) {
            ZStack {
                    // 圓形背景
                Circle()
                    .fill(Color.white.opacity(0.6))
                    .frame(width: 200, height: 200)
                    .shadow(radius: 3)
                    // 圓形進度環
                Circle()
                    .trim(from: 0, to: CGFloat(min(progress, 1.0)))
                    .stroke(progressColor,
                        style: StrokeStyle(
                            lineWidth: 10,
                            lineCap: .round)
                        )
                    .rotationEffect(.degrees(-90))
                    .frame(width: 200, height: 200)
                    .animation(.easeInOut(duration: 0.5), value: progress)
                
                VStack {
                        // 顯示已經過的時間
                    Text("\(Int(elapsedTime)/60)  分鐘")                      .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundStyle(.blue)
                    
                    Text("目標\(targetMinutes) 分鐘")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundStyle(.gray)
                }
            }
            
                // 設定目標時間的滑桿
            VStack(spacing: 5) {
                Text("設定目標時間: \(targetMinutes) 分鐘")
                    .font(.headline)
                    .foregroundStyle(.blue)
                Slider(value: Binding(get: {
                    Double(targetMinutes)
                }, set: { newValue in
                    targetMinutes = Int(newValue)
                }), in: 1...60, step: 1)
                .accentColor(.blue)
                .padding(.horizontal)
                
                HStack {
                    Text("1 分鐘")
                        .font(.caption)
                    Spacer()
                    Text("60 分鐘")
                        .font(.caption)
                }
                .foregroundStyle(.gray)
                .padding(.horizontal, 5)
            }
        }
        .padding()
        .background(Color.white.opacity(0.7))
        .cornerRadius(12)
        .shadow(radius: 2)
            
    }
}

#Preview {
    TimerView(elapsedTime: .constant(120), targetMinutes: .constant(30))
}
