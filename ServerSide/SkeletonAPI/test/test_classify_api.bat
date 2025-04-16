:: test_classify_api.bat
@echo off

:: JSON 파일 생성 (Python 사용)
python -c "import json, random; print(json.dumps([round(random.random(), 3) for _ in range(784)]))" > test_input.json

:: API 호출
curl -X POST http://localhost:8080/classify -H "Content-Type: application/json" -d @test_input.json

echo.
echo 🔍 분류 API 테스트 완료!
pause
