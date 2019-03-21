//
//  Question.swift
//  Personal Quiz
//
//  Created by Ivan Nikitin on 17/03/2019.
//  Copyright © 2019 Ivan Nikitin. All rights reserved.
//

import Foundation

struct Question {
    var text: String
    var type:ResponseType
    var answers: [Answer]
    
    static func loadData() -> [Question] {
        return [
            Question(text: "Что для вас важно?",
                     type: .single,
                     answers: [
                        Answer(text: "Стабильная зарплата", type: .staff),
                        Answer(text: "Свободный график работы", type: .expert),
                        Answer(text: "Делегирование и постановка задач", type: .businessman),
                        Answer(text: "Доходность", type: .investor)
                ]),
            Question(text: "Как вы храните свои сбережения",
                     type: .single,
                     answers: [
                        Answer(text: "Живу от зарплаты до зарплаты", type: .staff),
                        Answer(text: "На счету в банке", type: .expert),
                        Answer(text: "В активах компаний", type: .businessman),
                        Answer(text: "Вкладываю в ценные бумаги", type: .investor)
                ]),
            Question(text: "Ваш доход вырос в два раза",
                     type: .multiple,
                     answers: [
                        Answer(text: "Подумаете о кредите", type: .staff),
                        Answer(text: "Подумаете о новой машине", type: .expert),
                        Answer(text: "Подумаете о расширении бизнеса или о новом бизнесе", type: .businessman),
                        Answer(text: "Вложите часть увеличившегося дохода в ценные бумаги", type: .investor)
                ]),
            Question(text: "Какую часть дохода вы сохраняете?",
                     type: .ranged,
                     answers: [
                        Answer(text: "0-10% живете от зарплаты до зарплаты", type: .staff),
                        Answer(text: "10-20% есть небольшой запас", type: .expert),
                        Answer(text: "20-30 можете не беспокоиться о завтрашнем дне", type: .businessman),
                        Answer(text: ">30% есть уверенность в завтрашнем дне", type: .investor)
                ])
        ]
    }
}

enum ResponseType {
    case single, multiple, ranged
}
