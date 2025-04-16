# test_classify_api.sh
#!/bin/bash

# 테스트 입력 데이터 파일 생성 (간단한 랜덤 784 벡터)
python3 -c "import json, random; print(json.dumps([round(random.random(), 3) for _ in range(784)]))" > test_input.json

# classify API 호출
curl -X POST http://localhost:8080/classify \
  -H "Content-Type: application/json" \
  -d @test_input.json | jq

# 결과 로그 확인
echo "\n🔍 분류 API 테스트 완료!"