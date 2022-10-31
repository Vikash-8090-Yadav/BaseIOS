//
//  FinderView.swift
//  BaseFinderiOS
//
//  Created by Antoine Bollengier on 31.10.22.
//

import SwiftUI

struct FinderView: View {
    @State var basePath: String = "/"
    @State var directories: [String] = []
    var body: some View {
        NavigationView {
            Button {
                do {
                    directories = try getFilesInDirectory(path: basePath)
                } catch {
                    print(error)
                }
            } label: {
                Image(systemName: "arrow.left")
            }
            ScrollView {
                ForEach(directories, id: \.self) { dir in
                    Button {
                        do {
                            directories = try getFilesInDirectory(path:  "\(basePath)\(dir)")
                        } catch {
                            print(error)
                        }
                    } label: {
                        Text(dir)
                    }
                    .buttonStyle(.bordered)
                }
                .onAppear {
                    do {
                        directories = try getFilesInDirectory(path: basePath)
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
}

struct FinderView_Previews: PreviewProvider {
    static var previews: some View {
        FinderView()
    }
}
