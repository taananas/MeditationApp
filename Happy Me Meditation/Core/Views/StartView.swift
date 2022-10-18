//
//  StartView.swift
//  Happy Me Meditation
//
//  Created by Богдан Зыков on 17.07.2022.
//

import SwiftUI

struct StartView: View {
    @StateObject var loginVM = LoginViewModel()
    @State private var isActive: Bool = false
    var body: some View {
        Group{
            if isActive{
                if loginVM.isloggedUser{
                    MainView()
                        .environmentObject(loginVM)
                }else{
                    RootOnboardingView()
                        .environmentObject(loginVM)
                }
            }else{
                LaunchView()
                    .onAppear{
                        withAnimation(.easeInOut.delay(1)) {
                            isActive.toggle()
                        }
                    }
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
