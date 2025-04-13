
# 🧩 Haskell-Swift Integration Spec

## 📘 시스템 아키텍처 개요
- **클라이언트**: Swift (iOS 앱)
- **로컬 저장소**: Core Data (MediaSite, AdPlacement, Advertisement)
- **서버**: Haskell + Servant
- **모델 실행**: Python 스크립트 (`ClassificationModel/classify.py`)

---

## 🔗 Haskell API 정의 (Api.hs)

```haskell
type API = "classify" :> ReqBody '[JSON] [Int] :> Post '[JSON] ClassificationResult
```

- **요청 타입**: `[Int]` (예: 이미지 픽셀 데이터)
- **응답 타입**:

```json
{
  "result": 7,
  "message": "이 숫자는 7로 분류됨"
}
```

---

## ⚙️ 서버 처리 흐름 (Handler.hs)

```haskell
classifyHandler :: [Int] -> Handler ClassificationResult
classifyHandler pixels = do
  let inputJSON = BL.unpack (encode pixels)
  output <- liftIO $ readProcess "python" ["ClassificationModel/classify.py"] inputJSON

  liftIO $ writeFile "debug_output.txt" output

  let decoded = decode (BL.pack output)
  case decoded of
    Just res -> return res
    Nothing -> throwError err500 { errBody = BL.pack "Parsing Error." }
```

- `[Int]` 배열을 Python 스크립트로 전달
- `output`은 JSON 형태의 `ClassificationResult`

---

## 🔄 Swift ↔ Haskell 연동 계획

### 요청 구조
- Swift에서 `[Int]` 배열을 JSON 인코딩하여 `/classify`로 POST
- Haskell 서버가 Python 통해 분류 결과 반환

### Swift 모델
```swift
struct ClassificationResult: Codable {
    let result: Int
    let message: String
}
```

### Swift API 호출 함수 (샘플)
```swift
func classify(pixels: [Int], completion: @escaping (ClassificationResult?) -> Void) {
    let url = URL(string: "http://localhost:8080/classify")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    do {
        let jsonData = try JSONEncoder().encode(pixels)
        request.httpBody = jsonData
    } catch {
        print("Encoding error: \(error)")
        completion(nil)
        return
    }

    URLSession.shared.dataTask(with: request) { data, _, _ in
        if let data = data {
            let result = try? JSONDecoder().decode(ClassificationResult.self, from: data)
            completion(result)
        } else {
            completion(nil)
        }
    }.resume()
}
```

---

## 📁 파일 구조 예시
```
/HaskellServer
  ├── src/
  │   ├── Api.hs
  │   ├── Handler.hs
  ├── Main.hs
  ├── ClassificationModel/classify.py

/SwiftClient
  ├── Models/
  │   └── ClassificationResult.swift
  ├── API/
  │   └── ClassificationAPI.swift
```

---

## 🚨 예외 처리 흐름

- Haskell 서버에서 Python 출력이 파싱되지 않으면:
  ```haskell
  throwError err500 { errBody = BL.pack "Parsing Error." }
  ```
- Swift에서 결과 디코딩 실패 시:
  ```swift
  let result = try? JSONDecoder().decode(ClassificationResult.self, from: data)
  ```
  → 실패 시 completion(nil)

---

## 📈 API 확장 계획

### 예비 추가 API 제안:
- `GET /health` → 서버 상태 확인
- `POST /train` → 모델 재학습 요청
- `GET /logs` → 최근 분류 로그 확인
- `POST /upload-image` → 실제 이미지 전송 및 분류 요청

---

## 🔐 인증/보안 구조 (예정)

- 현재는 인증 없음 (개발 중 환경)
- 추후 JWT 또는 API Key 인증 도입 고려
- HTTPS 적용 필요 (로컬 환경 외 배포 시)

---

## 🧪 JSON 예제 샘플

### 요청 예시
```json
[0, 0, 255, 255, 128, 64, 0, 0, 1, 1, 0, 0]
```

### 응답 예시
```json
{
  "result": 9,
  "message": "입력된 숫자는 9로 예측됨"
}
```

---

## ✅ 메모 요약
- Haskell 서버는 Servant 기반 `/classify` 엔드포인트 제공
- Swift는 `[Int]` 배열을 전송하고 결과를 받아 출력
- Python은 실제 분류 모델을 실행
- 현재 Swift는 실행 불가 상태이므로 코드 설계만 준비 중
- 확장성과 안정성을 고려한 구조 정리 완료
