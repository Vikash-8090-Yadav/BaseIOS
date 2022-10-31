//
//  FinderView.swift
//  BaseFinderiOS
//
//  Created by Antoine Bollengier on 31.10.22.
//

import SwiftUI

var basePath: String = "/"

struct FinderView: View {
    @State var currentPath: String = basePath {
        didSet {
            displayedPath = currentPath
        }
    }
    @State var displayedPath: String = basePath
    @State var directories: [String] = []
    @State private var searchText = ""
    @State var errorMessage: String = ""
    var body: some View {
        VStack {
            Button {
                if (currentPath != basePath) {
                    currentPath = "\((URL(string: currentPath)?.deletingLastPathComponent().absoluteString)!)"
                }
                var result: Bool
                (directories, result) = getFilesInDirectory(path: currentPath)
                if (!result) {
                    errorMessage = "Can't access to this directory"
                } else {
                    if (directories.count < 1) {
                        errorMessage = "Diretory empty"
                    }
                    errorMessage = ""
                }
            } label: {
                Image(systemName: "arrow.left")
                    .padding()
            }
            HStack (spacing: 10) {
                RoundedRectangle(cornerRadius: 10).foregroundColor(Color.gray).opacity(0.2).frame(height: 35).overlay(content: {
                    TextField("Your library", text: $displayedPath)
                        .disableAutocorrection(true)
                        .padding()
                })
                Button {
                    var result: Bool
                    (directories, result) = getFilesInDirectory(path: currentPath)
                    if (!result) {
                        errorMessage = "Can't access to this directory"
                    } else {
                        if (directories.count < 1) {
                            errorMessage = "Diretory empty"
                            currentPath = displayedPath
                        }
                        errorMessage = ""
                        currentPath = displayedPath
                    }
                } label: {
                    Text("Go")
                }
                .buttonStyle(.borderless)
            }
            .padding()
            .padding()
            NavigationView {
                ScrollView {
                    ForEach(directories.filter { dir in
                        if (searchText == "") {
                            return true
                        } else {
                            if dir.contains(searchText) {
                                return true
                            } else {
                                return false
                            }
                        }
                    }, id: \.self) { dir in
                        Button {
                            var result: Bool
                            (directories, result) = getFilesInDirectory(path:  "\(basePath)\(dir)")
                            if (!result) {
                                errorMessage = "Can't access to this directory"
                            } else {
                                if (directories.count < 1) {
                                    errorMessage = "Diretory empty"
                                }
                                errorMessage = ""
                            }
                            currentPath = "\(currentPath)\(dir)/"
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
                        var result: Bool
                        (directories, result) = getFilesInDirectory(path: currentPath)
                        if (!result) {
                            errorMessage = "Can't access to this directory"
                        } else {
                            if (directories.count < 1) {
                                errorMessage = "Diretory empty"
                            }
                            errorMessage = ""
                        }
                    }
                }
                .frame(alignment: .leading)
            }
            .searchable(text: $searchText)
            Text(errorMessage)
                .foregroundColor(.red)
                .padding()
        }
    }
}


struct FinderView_Previews: PreviewProvider {
    static var previews: some View {
        FinderView()
    }
}
