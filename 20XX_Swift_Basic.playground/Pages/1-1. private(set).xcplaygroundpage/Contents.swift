//: [Previous](@previous)
import Foundation
/*:
 ### private(set)
 - private(set)
    - setter만 접근 제어 수준을 private으로 설정한다.
 - private(set)은 데이터에 접근은 가능하나 설정은 불가능하다.
 - private은 외부에서 아예 접근이 불가능하다.
 */
struct MyStudy {
    // MARK: - Property
    private(set) var name: String = "마다가스카 코딩 클럽"
    private(set) var contents: String = "마다가스카 코딩 클럽은 지식 공유를 위해 여러 사람이 모여 컨퍼런스를 준비하는 스터디입니다."
    private var members: [String] = ["윤아", "루희", "혜수", "소연", "승현", "지훈", "이준", "태현"]
    
    // MARK: - Method
    func getMembers() -> [String] {
        return members
    }
}

let myStudy = MyStudy()
myStudy.name
myStudy.contents
myStudy.getMembers()

// 🚨 [Bad]
// myStudy.contents = "소개 없음."                       // 접근 수준이 private(set)이므로 접근은 가능하나 값을 수정할 수 없다.
// study.members                                      // 해당 프로퍼티는 접근 수준이 private이므로 외부에서 접근이 불가능하다.
/*:
생각1
 - 🙋🏻‍♂️ 객체의 프로퍼티에 직접 접근하는 것 vs 메소드를 통해서 프로퍼티에 접근하는 것
 - 💭 단순 프로퍼티 접근이라면 메소드를 매 순간 만드는 건 오히려 비효율적일 수도 있다. - 윤아
 - 💭 메소드를 사용해서 프로퍼티에 접근 했을 때 형식을 한 번 더 체크할 수 있다. - 혜수

생각2
 - 🙋🏻‍♂️ 언제 사용할 수 있을까?
 - 💭 private(set)을 싱글톤 패턴을 사용한 객체(NetworkManager)를 쓸 때 작성한다. - 윤아
 */
//: [Next](@next)
