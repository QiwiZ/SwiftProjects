//
//  FilteredView.swift
//  CoreDataProject
//
//  Created by Julian Saxl on 2023-07-26.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    
    let content: (T) -> Content
    
    let predicateType: PredicateType
    
    init(filterKey: String, filterValue: String, predicateType: PredicateType, sortDescriptors: [SortDescriptor<T>], @ViewBuilder content: @escaping (T) -> Content) {
        self.predicateType = predicateType
        _fetchRequest = FetchRequest<T>(sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K \(predicateType) %@", filterKey, filterValue))
        self.content = content
    }
    
    var body: some View {
        List(fetchRequest, id: \.self) { object in
            self.content(object)
        }
    }
}
