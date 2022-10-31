//
//  AppView.swift
//  BaseFinderiOS
//
//  Created by Antoine Bollengier on 31.10.22.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        TabView {
            FinderView()
                .tabItem {
                    HStack {
                        ZStack {
                            Image(systemName: "folder")
                        }
                        Text("Finder")
                    }
                    .foregroundColor(Color(.darkGray))
                }
        }
        .accentColor(.green)
    }
}


struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
