# ClassificationModel/recommend_train.py
import pandas as pd
from sklearn.ensemble import RandomForestClassifier
import joblib

# 데이터 생성
data = pd.DataFrame([
    {"brightness": 0.8, "hour": 9,  "orientation": 0, "budget": 50000, "label": "Campaign A"},
    {"brightness": 0.6, "hour": 20, "orientation": 1, "budget": 80000, "label": "Campaign B"},
    {"brightness": 0.9, "hour": 22, "orientation": 1, "budget": 90000, "label": "Campaign B"},
    {"brightness": 0.5, "hour": 13, "orientation": 0, "budget": 40000, "label": "Campaign A"},
    {"brightness": 0.7, "hour": 18, "orientation": 1, "budget": 70000, "label": "Campaign C"},
])

X = data[["brightness", "hour", "orientation", "budget"]]
y = data["label"]

model = RandomForestClassifier(n_estimators=100, random_state=42)
model.fit(X, y)

joblib.dump(model, "recommend_model.pkl")
print("✅ 모델 저장 완료: recommend_model.pkl")
