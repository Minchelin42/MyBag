//
//  ProfileModel.swift
//  SeSACShopping
//
//  Created by 민지은 on 2024/02/26.
//

import Foundation

class ProfileModel {
    
    let symbolList = ["@","#","$","%"]
    let numberList = ["0","1","2","3","4","5","6","7","8","9"]
    
    var symbol = false
    var number = false
    var count = false

    let settingList = ["공지사항", "자주 묻는 질문", "1:1 문의", "알림 설정","처음부터 시작하기"]
    
    var inputName = Observable(UserDefaultManager.shared.nickName)
    var selectImage = Observable(UserDefaultManager.shared.profileIndex)
    var editType = Observable(ProfileSettingType.new)
    var userLike = Observable(UserDefaultManager.shared.likeItems.count.prettyNumber)
    
    var outputText = Observable("")
    var isPossible = Observable(false)
    
    init() {
        print("viewModel init")
        
        inputName.bind { value in
            self.checkName(name: value)    
        }
    }
    
    private func checkName(name: String) {
        
        for index in 0...symbolList.count - 1 {
            if name.contains(symbolList[index]) {
                outputText.value = "닉네임에 @,#,$,% 는 포함할 수 없어요"
                symbol = true
                break
            }
            symbol = false
        }
        
        for index in 0...numberList.count - 1 {
            if name.contains(numberList[index]) {
                outputText.value = "닉네임에 숫자는 포함할 수 없어요"
                number = true
                break
            }
            number = false
        }
        
        var lastInput = ""
        
        if !(name.isEmpty) {
            lastInput = String(name.last!)
        }
        
        if symbolList.contains(lastInput){
            outputText.value = "닉네임에 @,#,$,% 는 포함할 수 없어요"
        }

        if numberList.contains(lastInput){
            outputText.value = "닉네임에 숫자는 포함할 수 없어요"
        }

        if name.count > 10 || name.count < 2{
            outputText.value = "닉네임은 2글자 이상 10글자 미만으로 설정해주세요"
            count = true
        } else {
            count = false
        }
        
        if !symbol && !number && !count{
            outputText.value = "사용 가능한 닉네임입니다"
            isPossible.value = true
        } else {
            isPossible.value = false
        }

    }
}
