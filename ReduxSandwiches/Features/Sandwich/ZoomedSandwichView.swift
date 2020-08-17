//
//  ZoomedSandwichView.swift
//  ReduxSandwiches
//
//  Created by Farley Caesar on 2020-08-16.
//

import SwiftUI

struct ZoomedSandwichView: View {
    let sandwich: String
    
    var body: some View {
        ZStack {
            Image(sandwich)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text(sandwich)
                    .bold()
                    .frame(alignment: .center)
                    .background(Color(UIColor.systemBackground).opacity(0.05))
                    .font(.largeTitle)
                
                Spacer()
            }
        }
    }
}

struct ZoomedSandwichViewLight_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ZoomedSandwichView(sandwich: "Avocado Toast").environment(\.colorScheme, .light)
            
            ZoomedSandwichView(sandwich: "Avocado Toast").environment(\.colorScheme, .dark)
        }
    }
}
