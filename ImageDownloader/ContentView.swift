//
//  ContentView.swift
//  PhotoLibrary
//
//  Created by Vova on 15/09/2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var vm: ViewModel = ViewModel()
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    var body: some View {
        ScrollView {
            VStack {
                
                HStack {
                    TextField("Enter Photo URL:", text: $vm.text)
                    Button {
                        vm.downloadImage(url: vm.text)
                        vm.text = ""
                    } label: {
                        Text("Download")
                            .foregroundColor(.white)
                            .padding(5)
                            .background(Color.blue)
                            .cornerRadius(15)
                    }
                }
                
                LazyVGrid(columns: columns, spacing: 5) {
                    ForEach(vm.photos, id: \.self) { photo in
                        Image(uiImage: photo)
                            .resizable()
                            .frame(width: 100, height: 100)
                        
                            .clipShape(Rectangle())
                    }
                }

            }
            .padding(.horizontal, 10)
        }
        .alert("\(vm.error)", isPresented: $vm.isShowAlert) {
            Button("OK", role: .cancel) {  }
        }
    }
    
    func getImageSize() -> CGFloat{
        (UIScreen.main.bounds.size.width - 20) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

