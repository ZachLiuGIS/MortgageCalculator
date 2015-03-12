// Playground - noun: a place where people can play

import UIKit

//Input variables
let loanAmount : Double = 225000 * 0.75

let termYear = 30
let termMonth = 30 * 12

let interestRate = 4.125


//Calculate monthly payment
func getMonthlyPayment(loanAmount: Double, termMonth: Int, interestRate: Double) ->Double {
    let r : Double = interestRate / (100 * 12)
    let m : Double = Double(termMonth)
    let l : Double = loanAmount
    
    let payment : Double = l * (r * pow((1 + r), m)) / (pow((1 + r), m) - 1)
    return payment
}

let monthlyPayment = getMonthlyPayment(loanAmount, termMonth, interestRate)


//Get remaining balance after p months
func getBalanceByMonth(loanAmount: Double, termMonth: Int, interestRate: Double, month: Int) ->Double {
    let l : Double = loanAmount
    let m : Double = Double(termMonth)
    let p : Double = Double(month)
    let r : Double = interestRate / (100 * 12)
    
    let remainingBalance = l * ( pow((1 + r), m) - pow((1 + r), p) ) / ( pow((1 + r), m) - 1)
    return remainingBalance
}

for p in 0...360 {
    if p % 12 == 0 {
        let b = getBalanceByMonth(loanAmount, termMonth, interestRate, p)
        println("The remaining balance after \(p) months is \(b)")
    }
}


//Get remaining balance after p years
func getBalanceByYear(loanAmount: Double, termMonth: Int, interestRate: Double, year: Int) ->Double {
    let l : Double = loanAmount
    let m : Double = Double(termMonth)
    let p : Double = Double(year) * 12
    let r : Double = interestRate / (100 * 12)
    
    let remainingBalance = l * ( pow((1 + r), m) - pow((1 + r), p) ) / ( pow((1 + r), m) - 1)
    return remainingBalance
}

for y in 1...termYear {
    let b = getBalanceByYear(loanAmount, termMonth, interestRate, y)
    println("The remaining balance after \(y) year(s) is \(b)")
}

//Get total interest paid
func getTotalInterestPaid(payment: Double, termMonth: Int, loanAmount: Double)->Double {
    let m = Double(termMonth)
    return payment * m - loanAmount
}

let totalInterestPaid = getTotalInterestPaid(monthlyPayment, termMonth, loanAmount)


//Get interest after p months
func getInterestByMonth(loanAmount: Double, termMonth: Int, interestRate: Double, month: Int) -> Double {
    let r : Double = interestRate / (100 * 12)
    let b = getBalanceByMonth(loanAmount, termMonth, interestRate, month - 1)
    let interest = b * r
    return interest
}

for y in 1...termYear {
    let interest = getInterestByMonth(loanAmount, termMonth, interestRate, y * 12)
    println("The monthly interest after \(y) year(s) is \(interest)")
}

//Get total interest after p months
func getTotalInterestAfterMonth(loanAmount: Double, termMonth: Int, interestRate: Double, afterMonth: Int) -> Double {
    var totalInterest: Double = 0
    for m in 1...afterMonth {
        totalInterest += getInterestByMonth(loanAmount, termMonth, interestRate, m)
    }
    return totalInterest
}

func getTotalInterestAfterMonth_2(loanAmount: Double, termMonth: Int, interestRate: Double, afterMonth: Int) -> Double {
    let r : Double = interestRate / (100 * 12)
    var totalInterest: Double = 0
    let monthlyPayment = getMonthlyPayment(loanAmount, termMonth, interestRate)
    var remainingBalance = loanAmount
    
    for m in 1...afterMonth {
        let interestPaid = remainingBalance * r
        let principalReduction = monthlyPayment - interestPaid
        totalInterest += interestPaid
        remainingBalance -= principalReduction
    }
    return totalInterest
}

//let interest = getTotalInterestByMonth(loanAmount, termMonth, interestRate, 12)
//let interest_2 = getTotalInterestByMonth_2(loanAmount, termMonth, interestRate, 12)




//Get principal after p months
func getPrincipalByMonth(loanAmount: Double, termMonth: Int, interestRate: Double, month: Int) -> Double {
    let monthlyPayment = getMonthlyPayment(loanAmount, termMonth, interestRate)
    let interest = getInterestByMonth(loanAmount, termMonth, interestRate, month)
    return monthlyPayment - interest
}

for y in 1...termYear {
    let principal = getPrincipalByMonth(loanAmount, termMonth, interestRate, y * 12)
    println("The monthly principal after \(y) year(s) is \(principal)")
}

//Get total principal after p months
func getTotalPrincipalAfterMonth(loanAmount: Double, termMonth: Int, interestRate: Double, afterMonth: Int) -> Double {
    var totalPrincipal: Double = 0
    let monthlyPayment = getMonthlyPayment(loanAmount, termMonth, interestRate)
    for m in 1...afterMonth {
        totalPrincipal += monthlyPayment - getInterestByMonth(loanAmount, termMonth, interestRate, m)
    }
    return totalPrincipal
}

let principal = getTotalPrincipalAfterMonth(loanAmount, termMonth, interestRate, 12)

//Get Payment Schedule
func getPaymentSchedule(loanAmount: Double, termMonth: Int, interestRate: Double) -> [[Double]]{
    let r : Double = interestRate / (100 * 12)
    let monthlyPayment = getMonthlyPayment(loanAmount, termMonth, interestRate)
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

func getPaymentSchedule_2(loanAmount: Double, termMonth: Int, interestRate: Double) -> [(month: Int, interest: Double, principal: Double, remainingBalancd: Double)]{
    let r : Double = interestRate / (100 * 12)
    let monthlyPayment = getMonthlyPayment(loanAmount, termMonth, interestRate)
    var totalInterest: Double = 0
    var remainingBalance = loanAmount
    var scheduleArray : [(month: Int, interest: Double, principal: Double, remainingBalancd: Double)] = []
    
    for m in 1...termMonth {
        let interest = remainingBalance * r
        let principal = monthlyPayment - interest
        totalInterest += interest
        remainingBalance -= principal
        scheduleArray += [(m, interest, principal, remainingBalance)]
    }
    return scheduleArray
}

//let paymentSchedule = getPaymentSchedule(loanAmount, termMonth, interestRate)

//Get Payment Schedule By Year

//Get Principal By Year
func getPrincipalByYear(loanAmount: Double, termMonth: Int, interestRate: Double, year: Int) -> Double {
    var yearlyPrincipal : Double = 0
    let startMonth = year * 12
    let endMonth = startMonth + 12
    let monthlyPayment = getMonthlyPayment(loanAmount, termMonth, interestRate)

    for month in startMonth ..< endMonth {
        let interest = getInterestByMonth(loanAmount, termMonth, interestRate, month)
        yearlyPrincipal += monthlyPayment - interest
    }
    return yearlyPrincipal
}

let principalYear1 = getPrincipalByYear(loanAmount, termMonth, interestRate, 1)


//Get Interest By Year
func getInterestByYear(loanAmount: Double, termMonth: Int, interestRate: Double, year: Int) -> Double {
    var yearlyInterest : Double = 0
    let startMonth = year * 12
    let endMonth = startMonth + 12
    
    for month in startMonth ..< endMonth {
        yearlyInterest += getInterestByMonth(loanAmount, termMonth, interestRate, month)
    }
    return yearlyInterest
}

let interestYear1 = getInterestByYear(loanAmount, termMonth, interestRate, 1)



