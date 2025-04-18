# ClassificationModel/classify.py

import sys
import json
import joblib
import numpy as np

# 모델 로딩
model_file = "classification_model.pkl"
try:
    model = joblib.load(model_file)
except Exception as e:
    print(json.dumps({"result": -1, "message": "모델 로딩 실패", "error": str(e)}))
    sys.exit(1)

# 입력 받기
input_data = sys.stdin.read()
try:
    pixels = json.loads(input_data)
    X = np.array(pixels).reshape(1, -1)  # 1개 샘플
except Exception as e:
    print(json.dumps({"result": -1, "message": "입력 파싱 실패", "error": str(e)}))
    sys.exit(1)

# 예측 수행
try:
    pred = model.predict(X)[0]
    probas = model.predict_proba(X)[0]
    confidence = float(np.max(probas))
    result = {
        "result": int(pred),
        "message": f"이 이미지는 {int(pred)}로 분류되었습니다.",
        "confidence": round(confidence, 4)
    }
except Exception as e:
    result = {"result": -1, "message": "예측 실패", "error": str(e)}

# 결과 출력
print(json.dumps(result, ensure_ascii=True))