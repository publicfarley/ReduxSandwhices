//
//  AboutView.swift
//  ReduxSandwiches
//
//  Created by Farley Caesar on 2020-08-14.
//

import SwiftUI

struct AboutView: View {
    @EnvironmentObject var store: AppStore
    
    var viewModel: AboutViewModel {
        store as AboutViewModel
    }
    
    @State private var isCopyrightMessageVisisble = false
    
    var body: some View {
        VStack {
        
            Text(viewModel.title)
                .font(.headline)
                .padding()
        
            if isCopyrightMessageVisisble {
                Text(viewModel.copyrightMessage)
                    .font(.body)
                    .padding()
            }
                
        }
        .multilineTextAlignment(.center)
        .onReceive(store.objectWillChange) { _ in
            if viewModel.isAboutViewTheCurrentView {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    withAnimation(.easeInOut(duration: 1)) {
                        isCopyrightMessageVisisble = true
                    }
                })
            }
        }
    }
}
