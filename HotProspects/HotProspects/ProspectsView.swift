//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Julian Saxl on 2023-08-20.
//

import CodeScanner
import SwiftUI
import UserNotifications

struct ProspectsView: View {
    @EnvironmentObject var prospects: Prospects
    
    @State private var isShowingScanner = false
    @State private var isShowingConfirmationDialog = false
    
    enum SortType {
        case name, date
    }
    @State private var sorting: SortType = .name

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
        var filtered: [Prospect]
        switch filter {
        case .none:
            filtered = prospects.people
        case .contacted:
            filtered = prospects.people.filter {$0.isContacted}
        case .uncontacted:
            filtered = prospects.people.filter {!$0.isContacted}
        }
        switch sorting {
        case .date:
            return filtered.sorted {
                $0.date < $1.date
            }
        case .name:
            return filtered.sorted {
                $0.name < $1.name
            }
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else {return}
            let person = Prospect()
            person.name = details[0]
            person.email = details[1]
            prospects.add(person)
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.email
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("Hm I guess not then.")
                    }
                }
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.email)
                                .foregroundColor(.secondary)
                        }
                        if filter == .none {
                            if prospect.isContacted {
                                Image(systemName: "person.crop.circle.fill.badge.checkmark")
                            } else {
                                Image(systemName: "person.crop.circle.badge.xmark")
                            }
                        }
                    }.swipeActions {
                        if prospect.isContacted {
                            Button {
                                prospects.toggle(prospect)
                            } label: {
                                Label("Mark uncontacted", systemImage: "person.crop.circle.badge.xmark")
                            }
                            .tint(.blue)
                        } else {
                            Button {
                                prospects.toggle(prospect)
                            } label: {
                                Label("Mark contacted", systemImage: "person.crop.circle.fill.badge.checkmark")
                            }.tint(.green)
                            Button {
                                addNotification(for: prospect)
                            } label: {
                                Label("Remind me", systemImage: "bell")
                            }.tint(.orange)
                        }
                    }
                }
            }
                .navigationTitle(title)
                .toolbar {
                    Button {
                        isShowingScanner = true
                    } label: {
                        Label("Scan", systemImage: "qrcode.viewfinder")
                    }
                    Button {
                        isShowingConfirmationDialog = true
                    } label: {
                        Label("Sort", systemImage: "line.3.horizontal.decrease.circle")
                    }
                }
                .sheet(isPresented: $isShowingScanner) {
                    CodeScannerView(
                        codeTypes: [.qr],
                        simulatedData: "Paul Hudson\npaul@hackingwithswift.com",
                        completion: handleScan)
                }
                .confirmationDialog("", isPresented: $isShowingConfirmationDialog) {
                    Button("Name") {
                        sorting = .name
                    }
                    Button("Date") {
                        sorting = .date
                    }
                    Button("Cancel", role: .cancel) {}
                } message: {
                    Text("Sort by")
                }
        }
    }
}
