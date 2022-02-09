# 1. 조건문

> ☀️ 기초 문법 공부의 필요성을 느껴서 초심으로 돌아가 조금씩 공부하려고 한다. 지금 공부하고자 하는 것들이 단순 정리가 되지 않도록 계속 고민하고 연구하는 자세를 가지도록 하자. 기초는 가장 쉬워서가 아니라 가장 중요해서 그 의미가 있음을 깨닫자.

<br />

### if 문

> 🙋🏻‍♂️ 특정 조건에서만 코드를 실행해야 하거나 또는 실행하지 말아야 하거나 하는 상황에서 쓰인다. 말 그대로 조건에 따라 다른 처리를 해주고 싶을 때 사용한다. 하나의 프로그램을 만들다 보면 정말 필수적으로 조건문을 사용해서 조건에 따른 처리를 해주는 상황이 발생하기 때문에 필수적으로 알고 있어야 하는 내용이다.

> 중요한 건 if문을 사용할 수 있는 상황에서 switch-case문을 사용할 수 있다는 것인데 어떻게 코드를 작성해야 할지는 적절한 판단이 필요하다.


✅ 조건에 따른 행위를 처리할 때 기본이 되는 구문이다.  
✅ 특정 조건을 만족하거나 만족하지 않는 상황에서 무언가를 해야할 때 사용한다.  
✅ if문으로 쓰일 수 있는 코드를 switch-case로도 작성할 수 있는 경우가 많은데 적절한 판단이 필요하다.

**if ~ else 구문 예시**

```swift
// 가장 Basic한 if ~ else 조건문의 형태
import UIKit

var isDarkMode: Bool = true

// 1
if (isDarkMode == true) {
	print("다크모드 입니다.")
} else {
	print("다크모드가 아닙니다.")
}

// 2
if (isDarkMode == true) {
	print("다크모드 입니다.")
} else {
	print("다크모드가 아닙니다.")
}

// 3
if isDarkMode {
	print("다크모드 입니다.")
} else {
	print("다크모드가 아닙니다.")
}

// 개인적으로 3번의 형태가 가장 깔끔하지 않나 생각한다.
// Boolean 값의 경우 그 자체로 맥락을 판단할 수 있기 때문이다.
```

<br />

### if문 vs 삼항 연산자: 동일한 조건문인데 어떤 경우에 사용해야 할까?

**삼항 연산자 예시**

```swift
// 삼항 연산자도 생각보다 코드를 작성하면서 많이 활용된다.
// 콜론(:)을 else의 의미로 생각하면 편하다.
var title: String = isDarkMode == true ? "다크모드 입니다." : "다크모드가 아닙니다."
var title: String = isDarkMode ? "다크모드 입니다." : "다크모드가 아닙니다."
```

이 부분은 **가독성**을 고려하는 것이 가장 중요해보인다.

 

삼항 연산자는 조건을 단 2가지로 나눌 수 있을 때 사용할 수 있다. 짧게 처리할 수 있는 상황이라면 삼항 연산자의 사용이 더 좋아보이긴 하나, 무작정 남용해서는 안 된다고 생각한다. 어떤 경우에는 if-else문이 더 가독성이 좋은 때가 있고, 어떤 경우에는 삼항 연산자가 더 가독성이 좋은 때가 있다. 가독성을 잘 고려하면 적절한 판단 기준이 되지 않을까 싶다.

<br />

### if문 친구: if let 구문

자세한 내용은 다른 페이지에 따로 기술할 예정이다. (관련: 옵셔널 바인딩)
✅ guard let 구문과 함께 옵셔널 바인딩의 방법 중 하나이다.
✅ 조건문이라고 볼 수 있는데 조건을 nil인 경우, 그리고 아닌 경우로 나눌 수 있다는 것이 특징이다.

✔️ 값이 있는 경우 즉, nil이 아닌 경우는 true를 반환한다.
✔️ 값이 없는 경우 즉, nil인 경우는 false를 반환한다.


```swift
// Alamofire/Source/Result+Alamofire.swift

// 이런 느낌으로 사용될 수 있을 것 같다. 정말 깔끔하다.
// error가 nil이면 error와 함께 실패를 던지고,
// error가 nil이 아니면 value와 함께 성공을 던진다.
init(value: Success, error: Failure?) {
    if let error = error {
        self = .failure(error)
    } else {
        self = .success(value)
    }
}
```

<br />

### 오픈 소스에서 찾아본 if문

**SnapKit에서 찾아본 if문**

사실 if문의 경우 프로젝트 전반에 걸쳐서 다양한 경우에 사용되기 때문에 특정 예시를 찾는 것이 무의미할 수도 있다. 그러나 이렇게 오픈 소스를 뜯어보는 것도 좋은 경험이라고 생각한다.

다음은 SnapKit의 코드 일부이다.

```swift
// SnapKit/Sources/Constraint.swift

public final class Constraint {
	// ..
	internal func activateIfNeeded(updatingExisting: Bool = false) {
      guard let item = self.from.layoutConstraintItem else {
          print("WARNING: SnapKit failed to get from item from constraint. Activate will be a no-op.")
          return
      }
      let layoutConstraints = self.layoutConstraints

			// 1️⃣
			// Constraint가 업데이트 되는 것이 있다면 업데이트를 해주고
			// 그렇지 않다면 그대로 Constraint를 유지하는 것 같다.

      if updatingExisting {
          var existingLayoutConstraints: [LayoutConstraint] = []
          for constraint in item.constraints {
              existingLayoutConstraints += constraint.layoutConstraints
          }

          for layoutConstraint in layoutConstraints {
							// 2️⃣
							// ✨ first 구문: 조건을 만족하는 가장 첫 번째 요소를 반환
							// ✨ 정말 많이 보이는 구문이다.
              let existingLayoutConstraint = existingLayoutConstraints.first { $0 == layoutConstraint }
              guard let updateLayoutConstraint = existingLayoutConstraint else {
                  fatalError("Updated constraint could not find existing matching constraint to update: \(layoutConstraint)")
              }

							// 3️⃣
							// 이 부분에서는 왜 삼항 연산자를 사용했을까?
							// 가로로 길어지는 코드 임에도 불구하고, 가독성이 별로 좋지 않아보이는데 도대체 왜?
              let updateLayoutAttribute = (updateLayoutConstraint.secondAttribute == .notAnAttribute) ? updateLayoutConstraint.firstAttribute : updateLayoutConstraint.secondAttribute
              updateLayoutConstraint.constant = self.constant.constraintConstantTargetValueFor(layoutAttribute: updateLayoutAttribute)
          }
      } else {
          NSLayoutConstraint.activate(layoutConstraints)
          item.add(constraints: [self])
      }
  }
	// ..
}
```

1️⃣  updatingExisting 이라는 Boolean 값에 의해서 if-else로 분기 처리되고 있다.

2️⃣  first 구문: 조건을 만족하는 가장 첫 번째 요소를 반환

3️⃣  삼항 연산자 사용

이건 취향 차이의 문제인 것 같은데, 개인적으로 이 코드의 경우에는 2번째가 더 가독성이 좋아보인다. 왜 이렇게 작성했을까? (조건이 단 2개이고, 실행되는 코드가 한 줄씩이므로) 이런 이유일까? 작동상의 문제는 없기 때문에 크게 신경 쓸 부분은 아닌 것 같다.

```swift
let updateLayoutAttribute = (updateLayoutConstraint.secondAttribute == .notAnAttribute) ? updateLayoutConstraint.firstAttribute : updateLayoutConstraint.secondAttribute
```

```swift
if updateLayoutConstraint.secondAttribute == .notAnAttribute {
	updateLayoutAttribute = updateLayoutConstraint.firstAttribute
} else {
	updateLayoutAttribute = updateLayoutConstraint.secondAttribute
}
```

<br />

### 추가로 생각해보기

코드를 작성하다보면 그런 생각이 들 때가 있다. if문으로 코드를 작성하다보면 뭔가 코드가 지저분해지는 느낌이 들어서 괜히 삼항 연산자와 switch-case문을 써야 하지 않을까라는 생각이다.

예를 들어서 이런 코드가 있다. 홈 탭에서는 내 스케줄을 불러와야 하고, 공유 탭에서는 친구 스케줄을 불러와야 한다. 그래서 나는 탭 타입에 따라서 다른 종류의 함수 호출을 하려고 한다.

또한 나는 이런 생각을 하고 있는 상황이다. switch-case문을 알고 나니까 코드가 더 깔끔해진 것 같다. 그래서 나는 프로젝트마다 if문 대신에 switch-case문을 계속해서 써보려고 한다.

아래의 코드 중에 어느 것이 더 나아보일까? 단순히 조건은 2개로 나뉘어져 있고, 조건이 더 이상 추가될 것 같지 않다. 그렇다면 굳이 위의 예시처럼 switch-case문을 써야할까? 뭔가 코드 상으로 좀 더 깔끔한 것 같은 왠지 모른 느낌이 들지만 불필요한 default case가 들어가 있다. 물론 share 케이스 안에 들어가 있는 녀석을 default 케이스 안에 써줄 수 있지만 그럼 코드 상으로 이미 직관적이지 못하다고 생각한다. 

```swift
switch tabType {
case .home:
    getSchedules(date: selectedDate)
    getPillList(date: selectedDate)
case .share:
    getFriendSchedules(memberId: memberId, date: selectedDate)
    getFriendPillList(id: memberId, date: selectedDate)
default:
    return
}

// or

switch tabType {
case .home:
    getSchedules(date: selectedDate)
    getPillList(date: selectedDate)
default:
    getFriendSchedules(memberId: memberId, date: selectedDate)
    getFriendPillList(id: memberId, date: selectedDate)
}
```

```swift
if tabType == .home {
    getSchedules(date: selectedDate)
    getPillList(date: selectedDate)
} else if tabType == .share {
    getFriendSchedules(memberId: memberId, date: selectedDate)
    getFriendPillList(id: memberId, date: selectedDate)
}
```
개인적으로는 이 경우에는 if문이 더 적절해보인다.(아닐 수도 있다. 그래도 위에서 나름 근거는 들었다.. ) 사실 코드 작성에는 정답이 절대 없다고 생각한다. 정말 코드를 잘 짜는 사람도 그렇게 이야기 하지 않을까. (물론 더 나은 코드는 있겠지?)

 

상황에 따라 코드의 작성 방법이나 형태가 달라질 수 밖에 없을텐데, 그럴 때마다 본인의 기준에 따라서 또는 관용적으로 쓰이는 형태에 따라 적절한 판단을 해서 코드를 작성할 필요가 있다.

<br />

### 느낀 점

> 가장 크게 느낀 것은 if문에 대한 문법보다도 쉬운 문법에 속하는 조건문 조차 작성하려고 할 때 고민과 생각을 해봐야 한다는 것이다. 코드를 작성할 때 쉬운 코드라도 한 번 더 생각하는 습관을 들이자.
