//
//  ContentView.swift
//  SlowJoggingTimer
//  一個簡單的慢跑計時器
//  Created by YiJou  on 2025/8/2.
//

import SwiftUI
import AudioToolbox // 用於震動和提示音

struct ContentView: View {
    
    @State private var timer: Timer? // 用於計時
    @State private var elapsedTime: TimeInterval = 0 // 已經過的時間
    @State private var isRunning: Bool = false // 是否正在運行
        // 由 TimerView 與 MetronomeView 傳入設定
    @State private var targetMinutes: Int = 30 // 目標時間，預設為30分鐘
    @State private var bpm: Double = 180 // 每分鐘節拍數，預設為180 BPM
    @State private var metronomeTimer: Timer? // 用於節拍器計時
    
    // 新增Alert狀態
    @State private var showAlert: Bool = false
    
    var body: some View {
        ZStack {
            // 背景圖片
            LinearGradient(
                colors: [
                    .blue.opacity(0.3),
                    .cyan.opacity(0.2)
                ],
                startPoint: .leading,
                endPoint: .trailing)
                .ignoresSafeArea()
     
            VStack(spacing: 30) {
                
                    // Header
                HeaderView()
                
                    // TimerView
                TimerView(
                    elapsedTime: $elapsedTime,
                    targetMinutes: $targetMinutes
                )
                
                    // MetronomeView
                MetronomeView(bpm: $bpm)
                
                    // 控制按鈕
                HStack(spacing: 25) {
                    Button(action: toggleTimerAndMetronome) {
                        Label(isRunning ? "暫停" : "開始", systemImage: isRunning ? "pause.fill" : "play.fill")
                            .font(.title3)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 10)
                            .background(
                                LinearGradient(colors: isRunning ? [.orange, .yellow] : [.blue, .cyan], startPoint: .leading, endPoint: .trailing)
                            )
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .shadow(radius: 3)
                    }
                    
                    Button(action: resetAll) {
                        Label("重置", systemImage: "arrow.clockwise")
                            .font(.title2)
                            .padding(.horizontal, 25)
                            .padding(.vertical, 10)
                            .background(Color.gray.opacity(0.3))
                            .foregroundColor(.black)
                            .cornerRadius(12)
                            .shadow(radius: 3)
                    }
                }
                .padding()
            }
                // 顯示Alert
            .alert("🏆 恭喜！目標時間已完成",  isPresented: $showAlert) {
                Button("確定", role: .cancel) {}
            } message: {
                Text("你已經完成了 \(targetMinutes) 分鐘的慢跑！")
            }
        }
    }
    
        // 控制計時器的開始、暫停和重置
    private func toggleTimerAndMetronome() {
        if isRunning {
            stopAll()
        } else {
            startTimer()
            startMetronome()
        }
    }
    
    private func resetAll() {
        stopAll()
        elapsedTime = 0
    }
    
    private func stopAll() {
        isRunning = false
        timer?.invalidate()
        timer = nil
        metronomeTimer?.invalidate()
        metronomeTimer = nil
    }
    
    private func startTimer() {
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            elapsedTime += 1
            
            if elapsedTime >= Double(targetMinutes * 60) {
                notifyUser() // 通知用戶
                stopAll() // 到達目標時間後停止計時器
                showAlert = true // 顯示提示框
            }
        }
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    private func notifyUser() {
        AudioServicesPlaySystemSound(1005) // 提示音
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate) // 震動
        print("✅ 目標時間到！")
    }
    
    private func startMetronome() {
        playTick()
        metronomeTimer = Timer.scheduledTimer(withTimeInterval: 60.0 / bpm, repeats: true) { _ in
            playTick()
        }
    }
    private func playTick() {
        AudioServicesPlaySystemSound(1104) // 播放滴答聲
    }
}
        
#Preview {
    ContentView()
}
