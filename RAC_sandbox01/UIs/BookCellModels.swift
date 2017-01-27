//
//  BooksCellModels.swift
//  RAC_sandbox01
//
//  Created by msano on 2017/01/20.
//  Copyright © 2017年 msano. All rights reserved.
//

import Foundation
import Result
import ReactiveSwift

protocol BookCellModelsType {
    var keyword: MutableProperty<String> { get }
    // var result: Property<[String]> { get }
    
    var validation: MutableProperty<Bool>? { get }
//    var action: Action<Void, [BookCellModel], NoError> { get }
//    var action: Action<String, String, NoError> { get }
    
    var cells: [BookCellModel]? { get }
    init(model: [Book])
}

struct BookCellModels: BookCellModelsType {

    let keyword: MutableProperty<String> = MutableProperty("")
//    let result: Property<[String]>
    internal var validation: MutableProperty<Bool>?
//    internal var action: Action<Void, [BookCellModel], NoError>
//    internal var action: Action<String, String, NoError>
    
    let cells: [BookCellModel]?
    init(model: [Book]) {
        cells = []
        for book: Book in model {
            self.cells?.append(BookCellModel.init(model: book))
        }
        
        
        // mod RAC
        
//        var selfObj = self
//        keyword.producer.startWithValues { value in
//            if value.characters.count >= 1 {
//                self.validation = MutableProperty(true)
//            }
//        }
        
// OK
        
//        action = Action<String, String, NoError> { (word) -> SignalProducer<String, NoError> in
//            return SignalProducer<String, NoError> { (observer, disposable) in
//                observer.send(value: word)
//                observer.sendCompleted()
//            }
//        }
        
    }
    
    static private func wordsSubSet(_ searchTerm: String, words: [String]) -> [String] {
        
        guard  searchTerm != "" else { return words }
        
        return words.filter {
            $0.range(of: searchTerm, options: .caseInsensitive) != nil
        }
    }
    
    static private func generateDataSource() -> SignalProducer<[String], NoError> {
        
        return SignalProducer { o, d in
            
            let path: String = Bundle.main.path(forResource: "words", ofType: "txt")!
            let string: String = try! String(contentsOfFile: path, encoding: String.Encoding.utf8)
            o.send(value: string.characters.split(separator: "\n").map(String.init))
            o.sendCompleted()
        }
    }
}

struct BookError: Error {
    
}
