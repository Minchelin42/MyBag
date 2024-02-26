//
//  NetworkViewModel.swift
//  SeSACShopping
//
//  Created by 민지은 on 2024/02/26.
//

import Foundation

class NetworkViewModel {
    
    var searchResultViewDidLoadTrigger: Observable<Void?> = Observable(nil)

    var inputSearchItem: Observable<String> = Observable("")
    var inputStart: Observable<Int> = Observable(1)
    var inputSortIndex: Observable<Int> = Observable(0)
    var outputSearchResultData: Observable<Result> = Observable(Result(lastBuildDate: "", total: 0, start: 0, display: 0, items: []))
    
    let sortOption = ["sim", "date", "asc", "dsc"]
    
    init() {
        searchResultViewDidLoadTrigger.bind { _ in
            self.callRequest()
        }
    }
    
    func checkPrefetching(_ indexPath: Int) {
        if self.outputSearchResultData.value.items.count - 3 == indexPath && self.inputStart.value + self.outputSearchResultData.value.display < self.outputSearchResultData.value.total {
            self.inputStart.value += self.outputSearchResultData.value.display
            self.searchResultViewDidLoadTrigger.value = ()
        }
    }
    
    private func callRequest() {
        SearchAPIManager.callRequest(query: self.inputSearchItem.value, sort: self.sortOption[self.inputSortIndex.value], start: self.inputStart.value) { result, error in
            if error == nil {
                guard let result = result else { return }
                
                if self.inputStart.value == 1 {
                    self.outputSearchResultData.value = result
                } else {
                    self.outputSearchResultData.value.items.append(contentsOf: result.items)
                }
                
            } else {
                print("에러 발생")
            }
        }
    }
    



    
}
