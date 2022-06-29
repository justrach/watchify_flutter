//
//  ContentView.swift
//  
//
//  Created by Rach Pradhan on 1/8/22.
//

import SwiftUI
import WatchConnectivity

struct ContentView: View {
    @ObservedObject var session = WatchHandler()
    @State var count = 0
    @State private var bustStopNumber: String = ""
    


    var body: some View {
        ScrollView {
            TextField(
                
                "Bus Stop Number",
                text: $bustStopNumber
            )
            .onSubmit {
                
            }
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .border(.secondary)
            
            Text(bustStopNumber)
                .foregroundColor(.blue)
            
            Text("Reachable: \(session.reachable.description)")
            Text("Context: \(session.context.description)")
            Text("Received context: \(session.receivedContext.description)")
            Button("Refresh") { session.refresh() }
            Spacer().frame(height: 8)
            Text("Send")
            HStack {
                Button("Message") { session.sendMessage(["data": bustStopNumber]) }
                Button("Context") {
                    count += 1
                    session.updateApplicationContext(["data": count])
                }
            }
            VStack{
                Spacer().frame(height: 8)
                Text("Log")
                ForEach(session.log.reversed(), id: \.self) {
                    Text($0)
                }
            }}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
