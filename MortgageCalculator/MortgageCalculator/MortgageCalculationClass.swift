//
//  MortgageCalculationClass.swift
//  MortgageCalculator
//
//  Created by Zhiqiang Liu on 2/26/15.
//  Copyright (c) 2015 Zhiqiang Liu. All rights reserved.
//

import UIKit

class MortgageCalculationClass: NSObject {
    class func getMonthlyPayment(loanAmount: Double, termMonth: Int, interestRate: Double) ->Double {
        let r : Double = interestRate / (100 * 12)
        let m : Double = Double(termMonth)
        let l : Double = loanAmount
        
        let payment : Double = l * (r * pow((1 + r), m)) / (pow((1 + r), m) - 1)
        return payment
    }
    
    class func getPaymentSchedule(loanAmount: Double, termMonth: Int, interestRate: Double) -> [[Double]]{
        let r : Double = interestRate / (100 * 12)
        let monthlyPayment = getMonthlyPayment(loanAmount, termMonth: termMonth, interestRate: interestRate)
        var totalInterest: Double = 0
        var remainingBalance = loanAmount
        var scheduleArray : [[Double]] = []
        
        for m in 1...termMonth {
            let interest = remainingBalance * r
            let principal = monthlyPayment - interest
            totalInterest += interest
            remainingBalance -= principal
            scheduleArray += [[interest, principal, remainingBalance]]
        }
        return scheduleArray
    }
}
