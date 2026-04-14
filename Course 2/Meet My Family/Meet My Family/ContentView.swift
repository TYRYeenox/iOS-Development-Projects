//
//  ContentView.swift
//  Meet My Family
//
//  Created by TYR on 4/10/26.
//

import SwiftUI

struct ContentView: View {
    let familyMembers = [
        FamilyMember(id: "mom", name: "Mom", imageName: "mom", details: "Likes: Reading books - a lot of them - a very sweet mom!"),
        FamilyMember(id: "dad", name: "Dad", imageName: "dad", details: "Likes: TV and watching AI slop -_- - pretty chill dude!"),
        FamilyMember(id: "brother", name: "Brother", imageName: "brother", details: "Likes: Mainly games when not working - and pretty cool!"),
        FamilyMember(id: "myself", name: "Myself", imageName: "myself", details: "Likes: Gaming and outdoors!")
    ]
    
    @State private var selectedMember: FamilyMember?
    @State private var viewedMembers: Set<String> = []
    
    let columns = [
        GridItem(),
        GridItem()
    ]
    
    var body: some View {
        VStack {
            Text("US")
                .font(.largeTitle)
            
            LazyVGrid(columns: columns) {
                ForEach(familyMembers) { member in
                    Button {
                        selectedMember = member
                        viewedMembers.insert(member.id)
                    } label: {
                        VStack {
                            Image(member.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipped()
                            
                            HStack {
                                Text(member.name)
                                
                                if viewedMembers.contains(member.id) {
                                    Text("✅")
                                }
                            }
                            .foregroundColor(.black)
                        }
                        .padding()
                    }
                }
            }
        }
        .padding()
        .sheet(item: $selectedMember) { member in
            VStack(spacing: 20) {
                Image(member.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .clipped()
                
                Text(member.name)
                    .font(.largeTitle)
                
                Text(member.details)
                    .padding()
            }
            .padding()
        }
    }
}

struct FamilyMember: Identifiable {
    let id: String
    let name: String
    let imageName: String
    let details: String
}

#Preview {
    ContentView()
}
