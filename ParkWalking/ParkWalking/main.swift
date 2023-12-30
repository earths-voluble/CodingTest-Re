//
//  main.swift
//  ParkWalking
//
//  Created by 이보한 on 2023/12/29.
//

import Foundation

/*
 지나다니는 길을 'O', 장애물을 'X'로 나타낸 직사각형 격자 모양의 공원에서 로봇 강아지가 산책을 하려합니다. 산책은 로봇 강아지에 미리 입력된 명령에 따라 진행하며, 명령은 다음과 같은 형식으로 주어집니다.
 
 ["방향 거리", "방향 거리" … ]
 예를 들어 "E 5"는 로봇 강아지가 현재 위치에서 동쪽으로 5칸 이동했다는 의미입니다. 로봇 강아지는 명령을 수행하기 전에 다음 두 가지를 먼저 확인합니다.
 
 주어진 방향으로 이동할 때 공원을 벗어나는지 확인합니다.
 주어진 방향으로 이동 중 장애물을 만나는지 확인합니다.
 위 두 가지중 어느 하나라도 해당된다면, 로봇 강아지는 해당 명령을 무시하고 다음 명령을 수행합니다.
 공원의 가로 길이가 W, 세로 길이가 H라고 할 때, 공원의 좌측 상단의 좌표는 (0, 0), 우측 하단의 좌표는 (H - 1, W - 1) 입니다.
 
 공원을 나타내는 문자열 배열 park, 로봇 강아지가 수행할 명령이 담긴 문자열 배열 routes가 매개변수로 주어질 때, 로봇 강아지가 모든 명령을 수행 후 놓인 위치를 [세로 방향 좌표, 가로 방향 좌표] 순으로 배열에 담아 return 하도록 solution 함수를 완성해주세요.
 */

// 구상
// 강아지는 park를 입력받으면, 공원, 장애물 map을 생성한다.
// 공원 map: [Int]
// 장애물 map: [[Int]]
// 프로토콜을 활용해서 객체지향 스타일로 한번 시도해볼까?


// 구상 2
// 완성
// 먼저 강아지는 공원 지도를 2차원 배열로 변환
// 변환된 2차원 배열으로 공원의 세로x가로 크기parkMap: [Int]를 구함
// 변환된 2차원 배열으로 공원의 장애물 좌표 배열obstacleMap: [[Int]]을 구함


// 미완성
// 변환된 2차원 배열으로 스타팅포인트를 구함
// routes를 명령 배열으로 변환

// 1차 시도

protocol WalkingRobot {
    //    var coordinate: [Int] { get }                                 // 강아지는 좌표를 가지고 있다?
    func generatePark2DArray(_ park: [String]) -> [[String.SubSequence]]
    func generateMaps(_ park: [[String]]) -> [Int]                    // 공원 지도를 받으면, 공원과 장애물 map을 생성한다
    func generateObstacleMaps(_ park: [[String]]) -> [[Int]]
    
    func move(
        _ order: [String],
        _ startingPoint: [Int],
        _ parkMap: [Int],
        _ obstacleMap: [[Int]]
    ) -> [Int]
}

struct RobotDog: WalkingRobot {
    func generatePark2DArray(_ park: [String]) -> [[String.SubSequence]] {
        var park2DArray = [[String.SubSequence]]()
        for i in 0...park.count - 1 {
            var arrayed = park[i].split(separator: "")
            park2DArray.append(arrayed)
        }
        
        print("2차원 배열은 \(park2DArray)")                              // 프린트
        return park2DArray                              // [[S,O,O],[O,O,O] ... ] 형식으로 반환
    }
    
    func generateMaps(_ park2DArray: [[String]]) -> [Int] {
        var parkMap = [Int]()
        parkMap.append(park2DArray.count)                   // 공원의 세로
        parkMap.append(park2DArray[0].count)                // 공원의 가로
        
        print("공원의 크기는 \(parkMap)")                                  // 프린트
        return parkMap                                  // [H, W]
    }
    
    func generateObstacleMaps(_ parkMap: [[String]]) -> [[Int]] {
        var obstacleMap = [[Int]]()
        for i in 0...parkMap.count - 1 {
            for j in 0...parkMap[i].count - 1 {
                if parkMap[i][j] == "X" {
                    obstacleMap.append([i,j])
                }
            }
        }
        
        print("장애물 지도는 \(obstacleMap)")                          // 프린트
        return obstacleMap                          // [[H,W], [H2,W2], ...]
    }
    
//    private func orderHandling(_ order: [String]) -> [String : Int] {
//        
//        for i in 0...order.count - 1 {
//            order[i].split(separator: " ")
//        }
//    }
    
    func move(
        _ order: [String],
        _ startingPoint: [Int],
        _ parkMap: [Int],
        _ obstacleMap: [[Int]]
    ) -> [Int] {
        var coordinate = startingPoint
        coordinate[0] += 1
        coordinate[1] += 1
        return coordinate
        
    }
    
    
}

func solution(_ park:[String], _ routes:[String]) -> [Int] {
    var Yuki = RobotDog()
//    var park2DArray = [[String]]()
    var park2DArray = Yuki.generatePark2DArray(park)
    
//    var parkMap = Yuki.generateMaps(park2DArray)
//    var obstacleMap = Yuki.generateObstacleMaps(park2DArray)
//    
//    
//    let result = Yuki.move(routes, [1,1], parkMap, obstacleMap)
//    
//    print(result)
    return result
}


let result = solution(["SOO","OOO","OOO"], ["E 2","S 2","W 1"])

print(result)
// ["SOO","OOO","OOO"]    ["E 2","S 2","W 1"]    [2,1]
