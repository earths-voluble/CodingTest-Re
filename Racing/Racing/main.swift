//
//  main.swift
//  Racing
//
//  Created by 이보한 on 2023/12/26.
//

/*
 얀에서는 매년 달리기 경주가 열립니다. 해설진들은 선수들이 자기 바로 앞의 선수를 추월할 때 추월한 선수의 이름을 부릅니다. 예를 들어 1등부터 3등까지 "mumu", "soe", "poe" 선수들이 순서대로 달리고 있을 때, 해설진이 "soe"선수를 불렀다면 2등인 "soe" 선수가 1등인 "mumu" 선수를 추월했다는 것입니다. 즉 "soe" 선수가 1등, "mumu" 선수가 2등으로 바뀝니다.

 선수들의 이름이 1등부터 현재 등수 순서대로 담긴 문자열 배열 players와 해설진이 부른 이름을 담은 문자열 배열 callings가 매개변수로 주어질 때, 경주가 끝났을 때 선수들의 이름을 1등부터 등수 순서대로 배열에 담아 return 하는 solution 함수를 완성해주세요.
 */
import Foundation

func solution(_ players:[String], _ callings:[String]) -> [String] {
    var result: [String]
    result = players
    for i in 0...callings.count - 1 {
        for j in 0...result.count - 1 {
            if callings[i] != result[j] {
        
            } else if callings[i] == result[j] {
                result[j] = result[j - 1]
                result[j - 1] = callings[i]
            }
        }
    }
    return result
}

var result = solution(["mumu", "soe", "poe", "kai", "mine"], ["kai", "kai", "mine", "mine", "soe", "poe"])
print(result)


// 1차 실패
//func solution(_ players:[String], _ callings:[String]) -> [String] {
//    var result: [String]
//    result = players
//    for i in 0...callings.count - 1 {
//        for j in 0...result.count - 1 {
//            if callings[i] != result[j] {
//        
//            } else if callings[i] == result[j] {
//                result[j] = result[j - 1]
//                result[j - 1] = callings[i]
//                
//            }
//        }
//    }
//    return result
//}

// 짧은 테스트는 통과하지만, 긴 테스트에서 시간초과가 뜨고 만다. 62.5점짜리 함수다.

/*
 왜 시간초과가 뜨는가?
 players와 callings배열이 길어질수록, callings가 players 배열에서 자신이 언제 호명되는지, 검색하기 위해 비교하는 시행횟수 자체가 기하급수적으로 길어진다.
 이중포문을 사용하지 않는 방법이 있는지 모르겠으나, 이중포문을 사용하는 이상은, 이 검색의 시행횟수를 줄이는 수밖에 없다.
 ---그렇다면 callings에 호명되는 사람 이름이, players에서 몇 번째에 위치하는지 기억하게 할 수 있다면 어떨까?
 한 번 검색한 이후로는, 검색하기 위해서 비교하는 시행횟수를 스킵할 수 있을지도 모른다!
 
 ---그렇다면, 자신의 위치를 기억하게 하는 콜렉션은 어떤 자료형을 사용하면 될까?
 [String : Int]라면 가능할지 모른다.
 */

//func solution(_ players:[String], _ callings:[String]) -> [String] {
//    var address: [String : Int]
//    address = [:]
//    var result: [String]
//    result = players
//
//    for i in 0...callings.count - 1 {
//        if (address[(callings[i])] != nil) {
//            var calledAddress = address[(callings[i])]!
//            result[calledAddress] = result[calledAddress - 1]
//            address[result[calledAddress - 1]] = calledAddress
//            result[calledAddress - 1] = callings[i]
//            address[(callings[i])] = calledAddress - 1
//        } else {
//            for j in 0...result.count - 1 {
//                if callings[i] != result[j] {
//                } else if callings[i] == result[j] {
//                    result[j] = result[j - 1]
//                    result[j - 1] = callings[i]
//                    address[callings[i]] = j - 1
//                    address[result[j]] = j
//                }
//            }
//        }
//    }
//    print(address)
//    return result
//}

/*
 딕셔너리를 이용해 위치를 기억하게 한다는 아이디어는 유효했다.
 실행속도가 눈에 띄게 줄었다.
 하지만 여전히 네 개의 테스트에서 시간 초과가 출력된다.
 75점짜리 함수다.
 이제 뭘 할 수 있을까?
 최초에는 players를 통해서 선수와 등수 배열이 주어진다. 최초 dictionary는 이것을 통해 탐색 없이 만들 수 있다.
 */

func solution2(_ players:[String], _ callings:[String]) -> [String] {
    var address: [String : Int]
    address = [:]
    for k in 0...players.count - 1 {
        address[players[k]] = k
    }
    var result: [String]
    result = players
    for i in 0...callings.count - 1 {
        if (address[(callings[i])] != nil) {
            var calledAddress = address[(callings[i])]! // calledAddress는 주솟값 Int
            result[calledAddress] = result[calledAddress - 1]
            address[result[calledAddress - 1]] = calledAddress
            result[calledAddress - 1] = callings[i]
            address[(callings[i])] = calledAddress - 1
        } else if i > 0 && (address[(callings[i - 1])] != nil) {
                var calledAddressAhead = address[(callings[i - 1])]! // calledAddressAhead는 호명된 주소의 앞 주솟값 Int
                result[i] = result[calledAddressAhead]
                address[result[calledAddressAhead]] = i
                result[calledAddressAhead] = callings[i]
                address[(callings[i])] = calledAddressAhead
        } else {
            for j in 0...result.count - 1 {
                if callings[i] != result[j] {
                } else if callings[i] == result[j] {
                    result[j] = result[j - 1]
                    result[j - 1] = callings[i]
                    address[callings[i]] = j - 1
                    address[result[j]] = j
                }
            }
        }
    }
    return result
}
var result2 = solution2(["mumu", "soe", "poe", "kai", "mine"], ["kai", "kai", "mine", "mine", "soe", "poe"])
print(result2)


// ["mumu", "soe",  "kai", "poe", "mine"]

// result: ["mumu", "kai", "mine", "soe", "poe"]

