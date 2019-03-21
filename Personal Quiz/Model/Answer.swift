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
    case staff = "👨‍🔧 Работник по найму", expert = "🤵 Специалист", businessman = "🕺 Бизнесмен", investor = "💼 Инвестор"
    
    var definition: String {
        switch self {
        case .staff:
            return "Вы и любите безопасность, поэтому вам нужна стабильная зарплата"
        case .expert:
            return "Вы знаете себе цену и не будете тратить зря свое время"
        case .businessman:
            return "Вы знаете как найти и организовать людей для получения прибыли"
        case .investor:
            return "Вы знаете что деньги могут приносить еще больше денег"
        }
    }
}
