//
//  SpaceshipScreen.swift
//  State Spaceship (aka Stateship)
//
//  Created by Jane Madsen on 9/29/25.
//

import SwiftUI

@Observable
class ShipComputer {
    var availablePower = 10
    var heading = ""
    var weaponsPower = 0
    var shieldPower = 0
    var enginePower = 0
    var usedPower: Int {
        weaponsPower + shieldPower + enginePower
    }
    
    var remainingPower: Int {
        availablePower - usedPower
    }
}

struct SpaceshipScreen: View {
    @State var computer = ShipComputer()

    var body: some View {
        Form {
            Section("Helm Station") {
                HelmStation()
            }
            
            Section("Weapons Station") {
                WeaponsStation()
            }
            
            Section("Shield Station") {
                ShieldStation()
            }
            
            Section("Engine Station") {
                EngineStation()
            }
            
            Text("Available Power: \(computer.remainingPower)")
        }
        .environment(computer)
        .padding()
    }
}

struct HelmStation: View {
    @Environment(ShipComputer.self)
    var shipComputer
    @State var inChair = false
    
    var body: some View {
        @Bindable var shipComputer = shipComputer
        
        HStack {
            CrewChair(crewMember: .dog, inChair: $inChair)
            
            TextField("Heading", text: $shipComputer.heading)
                .disabled(!inChair)
        }
    }
}

struct WeaponsStation: View {
    @Environment(ShipComputer.self) var shipComputer
    @State var inChair = false
    @State var weaponsEnabled = false
    
    var body: some View {
        @Bindable var shipComputer = shipComputer
        
        HStack {
            CrewChair(crewMember: .cat, inChair: $inChair)
            
            VStack {
                Toggle("Weapons Power: \(shipComputer.weaponsPower)", isOn: $weaponsEnabled)
                    .disabled(!inChair)
                    .onAppear {
                        weaponsEnabled = shipComputer.weaponsPower > 0
                    }
                    .onChange(of: inChair) { _, newValue in
                        if !newValue {
                            weaponsEnabled = false
                            shipComputer.weaponsPower = 0
                        }
                    }
                    .onChange(of: weaponsEnabled) { _, newValue in
                        if !inChair {
                            weaponsEnabled = false
                            shipComputer.weaponsPower = 0
                            return
                        }
                        
                        if newValue {
                            if shipComputer.remainingPower >= 3 {
                                shipComputer.weaponsPower = 3
                            } else {
                                weaponsEnabled = false
                            }
                        } else {
                            shipComputer.weaponsPower = 0
                        }
                    }
                
                Button("Fire!") {
                    print("PEW!")
                }
                .disabled(!inChair || shipComputer.weaponsPower == 0)
            }
        }
    }
}

struct ShieldStation: View {
    @Environment(ShipComputer.self) var shipComputer
    @State var inChair = false
    @State var localShieldPower = 0
    
    var body: some View {
        @Bindable var shipComputer = shipComputer
        
        HStack {
            CrewChair(crewMember: .lizard, inChair: $inChair)
            
            Stepper("Shield Power: \(localShieldPower)", value: $localShieldPower, in: 0...shipComputer.availablePower)
                .disabled(!inChair)
                .onAppear {
                    localShieldPower = shipComputer.shieldPower
                }
                .onChange(of: inChair) { _, newValue in
                    if !newValue {
                        localShieldPower = 0
                        shipComputer.shieldPower = 0
                    }
                }
                .onChange(of: localShieldPower) { _, newValue in
                    if !inChair {
                        localShieldPower = 0
                        shipComputer.shieldPower = 0
                        return
                    }
                    
                    let maxAllowed = shipComputer.remainingPower + shipComputer.shieldPower
                    let clamped = min(max(newValue, 0), maxAllowed)
                    if clamped != newValue {
                        localShieldPower = clamped
                    }
                    shipComputer.shieldPower = clamped
                }
        }
    }
}

struct EngineStation: View {
    @Environment(ShipComputer.self) var shipComputer
    @State var inChair = false
    @State var localEnginePower = 0
    
    var body: some View {
        @Bindable var shipComputer = shipComputer
        
        HStack {
            CrewChair(crewMember: .hare, inChair: $inChair)
            
            Stepper("Engine Power: \(localEnginePower)", value: $localEnginePower, in: 0...shipComputer.availablePower)
                .disabled(!inChair)
                .onAppear {
                    localEnginePower = shipComputer.enginePower
                }
                .onChange(of: inChair) { _, newValue in
                    if !newValue {
                        localEnginePower = 0
                        shipComputer.enginePower = 0
                    }
                }
                .onChange(of: localEnginePower) { _, newValue in
                    if !inChair {
                        localEnginePower = 0
                        shipComputer.enginePower = 0
                        return
                    }
                    
                    let maxAllowed = shipComputer.remainingPower + shipComputer.enginePower
                    let clamped = min(max(newValue, 0), maxAllowed)
                    if clamped != newValue {
                        localEnginePower = clamped
                    }
                    shipComputer.enginePower = clamped
                }
        }
    }
}

struct CrewChair: View {
    @Environment(ShipComputer.self) var shipComputer
    var crewMember: Crew
    @Binding var inChair: Bool
    
    var body: some View {
        Button {
            inChair.toggle()
        } label: {
            if inChair {
                crewMember.icon
            } else {
                Image(systemName: "person.slash")
            }
        }
        .padding(5)
        .background {
            Circle()
                .foregroundStyle(.gray)
        }
    }
}

enum Crew: String {
    case dog
    case cat
    case lizard
    case hare
    
    var icon: Image {
        switch self {
        case .dog:
            Image(systemName: "dog")
        case .cat:
            Image(systemName: "cat")
        case .lizard:
            Image(systemName: "lizard")
        case .hare:
            Image(systemName: "hare")
        }
    }
}

#Preview {
    SpaceshipScreen()
}
