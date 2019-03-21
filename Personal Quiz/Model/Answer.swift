//
//  Response.swift
//  Personal Quiz
//
//  Created by Ivan Nikitin on 17/03/2019.
//  Copyright © 2019 Ivan Nikitin. All rights reserved.
//

import Foundation

struct Answer {
    var text: String
    var type: PersonType
}

enum PersonType: String {
    case staff = "☹️ Работник по найму", expert = "😐 Хороший специалист", businessman = "🙂 Бизнесмен", investor = "😀 Инвестор"
    
    var definition: String {
        switch self {
        case .staff:
            return "Вы работаете по найму, и любите безопасность"
        case .expert:
            return "Вы знаете себе цену"
        case .businessman:
            return "Вы знаете как найти и организовать людей для получения прибыли"
        case .investor:
            return "Вы знаете как заставить капиталл работать"
        }
    }
}
