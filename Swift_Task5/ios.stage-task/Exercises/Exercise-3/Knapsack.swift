import Foundation

public typealias Supply = (weight: Int, value: Int)

public final class Knapsack {
    let maxWeight: Int
    let drinks: [Supply]
    let foods: [Supply]
    var maxKilometers: Int {
        findMaxKilometres()
    }
    
    init(_ maxWeight: Int, _ foods: [Supply], _ drinks: [Supply]) {
        self.maxWeight = maxWeight
        self.drinks = drinks
        self.foods = foods
    }
    
    func findMaxKilometres() -> Int {
        var drinkss = drinks
        var foodss = foods
        var maxWeightt = maxWeight
        var maxDistance = 0
        var drinksMaxWeight: Int
        var foodsMaxWeight: Int
        var drinksMaxDistance = 0
        var foodsMaxDistance = 0
        var drinksMaxDistanceFirstPart = 0
        var foodsMaxDistanceFirstPart = 0

        
        if maxWeight > 250 {
            drinkss.sort {
                Float16($0.value) / Float16($0.weight) >= Float16($1.value) / Float16($1.weight)
            }
            foodss.sort {
                Float16($0.value) / Float16($0.weight) >= Float16($1.value) / Float16($1.weight)            }
//            print(drinkss)
//            print(foodss)
            
            while maxWeightt > 250 {
                if drinksMaxDistanceFirstPart <= foodsMaxDistanceFirstPart {
                    drinksMaxDistanceFirstPart += drinkss[0].value
                    maxWeightt -= drinkss[0].weight
                    drinkss.removeFirst()
                } else {
                    foodsMaxDistanceFirstPart += foodss[0].value
                    maxWeightt -= foodss[0].weight
                    foodss.removeFirst()
                }
            }
            
        }
    
        drinkss.insert(Supply(0,0), at: 0)
        foodss.insert(Supply(0,0), at: 0)

        
        
       // if maxWeight < 100 {
            for weight in 1..<maxWeightt {
                drinksMaxWeight = weight
                foodsMaxWeight = maxWeightt - weight
                
                // [foodOrDrinkNumber[weight:distance]]
                var drinkTable: [Int:[Int:Int]] = [0:[:]]
                var foodTable: [Int:[Int:Int]] = [0:[:]]
                for i in 1...drinksMaxWeight {
                    drinkTable[0]![i] = 0
                }
                for i in 1...foodsMaxWeight {
                    foodTable[0]![i] = 0
                }
                
                for drinkN in 1..<drinkss.count {
                    drinkTable[drinkN] = [:]
                    for w in 1...drinksMaxWeight {
                        if w < drinkss[drinkN].weight {
                            drinkTable[drinkN]![w] = drinkTable[drinkN - 1]![w]!
                        } else {
                            drinkTable[drinkN]![w] = max(drinkTable[drinkN - 1]![w]!, (drinkss[drinkN].value + ((drinkTable[drinkN - 1]![w - drinkss[drinkN].weight]) ?? 0)))
                        }
               
                    }
                }
                
                drinksMaxDistance = max(drinksMaxDistance, drinkTable[drinkss.count-1]![drinksMaxWeight]!)
                
                for foodN in 1..<foodss.count {
                    foodTable[foodN] = [:]
                    for w in 1...foodsMaxWeight {
                        if w < foodss[foodN].weight {
                            foodTable[foodN]![w] = foodTable[foodN - 1]![w]!
                        } else {
                            foodTable[foodN]![w] = max(foodTable[foodN - 1]![w]!, (foodss[foodN].value + ((foodTable[foodN - 1]![w - foodss[foodN].weight]) ?? 0)))
                        }
                        
                    }
                }
                
                foodsMaxDistance = max(foodsMaxDistance, foodTable[foodss.count-1]![foodsMaxWeight]!)
                
                maxDistance = max(maxDistance, min(drinksMaxDistanceFirstPart + drinksMaxDistance, foodsMaxDistanceFirstPart + foodsMaxDistance))
                
                drinksMaxDistance = 0
                foodsMaxDistance = 0
    //            print("drink table: \(drinkTable)")
    //            print("food table: \(foodTable)")
                
            }
//        } else {
//            var weight = maxWeight / 2
//            var shift = weight
//            while shift >= 5 {
//                drinksMaxWeight = weight
//                foodsMaxWeight = maxWeight - weight
//
//                // [foodOrDrinkNumber[weight:distance]]
//                var drinkTable: [Int:[Int:Int]] = [0:[:]]
//                var foodTable: [Int:[Int:Int]] = [0:[:]]
//                for i in 1...drinksMaxWeight {
//                    drinkTable[0]![i] = 0
//                }
//                for i in 1...foodsMaxWeight {
//                    foodTable[0]![i] = 0
//                }
//
//                for drinkN in 1..<drinkss.count {
//                    drinkTable[drinkN] = [:]
//                    for w in 1...drinksMaxWeight {
//                        if w < drinkss[drinkN].weight {
//                            drinkTable[drinkN]![w] = drinkTable[drinkN - 1]![w]!
//                        } else {
//                            drinkTable[drinkN]![w] = max(drinkTable[drinkN - 1]![w]!, (drinkss[drinkN].value + ((drinkTable[drinkN - 1]![w - drinkss[drinkN].weight]) ?? 0)))
//                        }
//
//                    }
//                }
//
//                drinksMaxDistance = max(drinksMaxDistance, drinkTable[drinkss.count-1]![drinksMaxWeight]!)
//
//                for foodN in 1..<foodss.count {
//                    foodTable[foodN] = [:]
//                    for w in 1...foodsMaxWeight {
//                        if w < foodss[foodN].weight {
//                            foodTable[foodN]![w] = foodTable[foodN - 1]![w]!
//                        } else {
//                            foodTable[foodN]![w] = max(foodTable[foodN - 1]![w]!, (foodss[foodN].value + ((foodTable[foodN - 1]![w - foodss[foodN].weight]) ?? 0)))
//                        }
//
//                    }
//                }
//
//                foodsMaxDistance = max(foodsMaxDistance, foodTable[foodss.count-1]![foodsMaxWeight]!)
//
//                shift = shift / 2
//                if drinksMaxDistance < foodsMaxDistance {
//                    weight = weight + shift
//                } else {
//                    weight = weight - shift
//                }
//
//                maxDistance = max(maxDistance, min(drinksMaxDistance, foodsMaxDistance))
//
//                drinksMaxDistance = 0
//                foodsMaxDistance = 0
//    //            print("drink table: \(drinkTable)")
//    //            print("food table: \(foodTable)")
//
//            }
//            let rangeStart = weight-60 > 0 ? weight - 60 : 1
//            let rangeFinish = weight+60 <= maxWeight ? weight+60 : maxWeight - 1
//            for weight in rangeStart...rangeFinish {
//                drinksMaxWeight = weight
//                foodsMaxWeight = maxWeight - weight
//
//                // [foodOrDrinkNumber[weight:distance]]
//                var drinkTable: [Int:[Int:Int]] = [0:[:]]
//                var foodTable: [Int:[Int:Int]] = [0:[:]]
//                for i in 1...drinksMaxWeight {
//                    drinkTable[0]![i] = 0
//                }
//                for i in 1...foodsMaxWeight {
//                    foodTable[0]![i] = 0
//                }
//
//                for drinkN in 1..<drinkss.count {
//                    drinkTable[drinkN] = [:]
//                    for w in 1...drinksMaxWeight {
//                        if w < drinkss[drinkN].weight {
//                            drinkTable[drinkN]![w] = drinkTable[drinkN - 1]![w]!
//                        } else {
//                            drinkTable[drinkN]![w] = max(drinkTable[drinkN - 1]![w]!, (drinkss[drinkN].value + ((drinkTable[drinkN - 1]![w - drinkss[drinkN].weight]) ?? 0)))
//                        }
//
//                    }
//                }
//
//                drinksMaxDistance = max(drinksMaxDistance, drinkTable[drinkss.count-1]![drinksMaxWeight]!)
//
//                for foodN in 1..<foodss.count {
//                    foodTable[foodN] = [:]
//                    for w in 1...foodsMaxWeight {
//                        if w < foodss[foodN].weight {
//                            foodTable[foodN]![w] = foodTable[foodN - 1]![w]!
//                        } else {
//                            foodTable[foodN]![w] = max(foodTable[foodN - 1]![w]!, (foodss[foodN].value + ((foodTable[foodN - 1]![w - foodss[foodN].weight]) ?? 0)))
//                        }
//
//                    }
//                }
//
//                foodsMaxDistance = max(foodsMaxDistance, foodTable[foodss.count-1]![foodsMaxWeight]!)
//
//                maxDistance = max(maxDistance, min(drinksMaxDistance, foodsMaxDistance))
//
//                drinksMaxDistance = 0
//                foodsMaxDistance = 0
//    //            print("drink table: \(drinkTable)")
//    //            print("food table: \(foodTable)")
//
//            }
//
//        }
//        print(maxDistance)
        return maxDistance
    }
}
