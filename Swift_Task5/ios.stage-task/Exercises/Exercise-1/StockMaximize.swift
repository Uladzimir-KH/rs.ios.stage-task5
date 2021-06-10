import Foundation

class StockMaximize {

    func countProfit(prices: [Int]) -> Int {
        var allPrices = prices
        var sharesCounter = 0
        var currentPrice = 0
        var lossCounter = 0
        var profitCounter = 0
        
        for _ in 0..<prices.count {
            currentPrice = allPrices.removeFirst()
            if currentPrice < allPrices.max() ?? 0 {
                sharesCounter += 1
                lossCounter -= currentPrice
            } else {
                if sharesCounter != 0 {
                    profitCounter += sharesCounter * currentPrice + lossCounter
                    sharesCounter = 0
                    lossCounter = 0
                }
            }
        }
        
        return profitCounter
    }
}
