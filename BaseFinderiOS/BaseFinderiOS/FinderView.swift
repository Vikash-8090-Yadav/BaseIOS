//
//  FinderView.swift
//  BaseFinderiOS
//
//  Created by Antoine Bollengier on 31.10.22.
//

import SwiftUI

var basePath: String = "/"

struct FinderView: View {
    @State var currentPath: String = basePath
    @State var directories: [String] = []
    var body: some View {
        HStack {
            Button {
                do {
                    print(currentPath)
                    currentPath = "\((URL(string: currentPath)?.deletingLastPathComponent().absoluteString)!)"
                    print(currentPath)
                    directories = try getFilesInDirectory(path: currentPath)
                } catch {
                    print(error)
                }
            } label: {
                Image(systemName: "arrow.left")
                    .padding()
            }
            NavigationView {
                ScrollView {
                    ForEach(directories, id: \.self) { dir in
                        Button {
                            do {
                                directories = try getFilesInDirectory(path:  "\(basePath)\(dir)")
                                currentPath = "\(currentPath)\(dir)/"
                            } catch {
                                print(error)
                            }
                        } label: {
                            Text(dir)
                                .contextMenu {
                                    ShareLink(item: URL(filePath: "\(basePath)\(dir)"), preview: SharePreview("\(basePath)\(dir)", image: Image(systemName: "folder"))) {
                                        HStack {
                                            Text("Share")
                                            Image(systemName: "square.and.arrow.up")
                                        }
                                    }
                                }
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
}


struct FinderView_Previews: PreviewProvider {
    static var previews: some View {
        FinderView()
    }
}
