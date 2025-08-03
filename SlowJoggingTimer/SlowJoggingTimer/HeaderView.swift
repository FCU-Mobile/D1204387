    //
    //  HeaderView.swift
    //  SlowJoggingTimer
    //
    //  Created by YiJou  on 2025/8/3.
    //

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack(spacing: 10){
            Image(systemName: "figure.run")
                .resizable()
                .scaledToFit()
                .frame(width: 35, height: 35)
                .foregroundStyle(.white)
            
            Text("超慢跑計時器")
                .font(.title2)
                .bold()
                .foregroundStyle(.white)
        }
        .padding()
//        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(
                colors: [.blue, .cyan],
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .cornerRadius(16)
        .shadow(radius: 3)
    }
}

#Preview {
    HeaderView()
}



