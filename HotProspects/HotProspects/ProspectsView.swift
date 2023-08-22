//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Julian Saxl on 2023-08-20.
//

import SwiftUI

struct ProspectsView: View {
    @EnvironmentObject var prospects: Prospects

    enum FilterType {
        case none, contacted, uncontacted
    }
    
    let filter: FilterType
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted"
        case .uncontacted:
            return "Uncontacted"
        }
    }
    
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter {$0.isContacted}
        case .uncontacted:
            return prospects.people.filter {!$0.isContacted}
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    VStack(alignment: .leading) {
                        Text(prospect.name)
                            .font(.headline)
                        Text(prospect.email)
                            .foregroundColor(.secondary)
                    }
                }
            }
                .navigationTitle(title)
                .toolbar {
                    Button {
                        let prospect = Prospect()
                        prospect.name = "JS"
                        prospect.email = "j.s@mail.com"
                        prospects.people.append(prospect)
                    } label: {
                        Label("Scan", systemImage: "qrcode.viewfinder")
                    }
                }
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
