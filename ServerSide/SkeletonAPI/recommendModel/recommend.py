# RecommendModel/recommend.py
import json
import sys

# 입력값 받기
input_data = sys.stdin.read()
try:
    site_id = int(input_data.strip())
except ValueError:
    site_id = 0

# 더미 추천 로직
recommendations = [
    {"recommendationId": 7, "title": "비건 스킨케어", "score": 0.95},
    {"recommendationId": 3, "title": "전기 SUV 광고", "score": 0.89},
    {"recommendationId": 9, "title": "오피스용 커피머신", "score": 0.86},
    {"recommendationId": 5, "title": "보드게임 카페", "score": 0.83},
    {"recommendationId": 6, "title": "친환경 빨대", "score": 0.77}
]

# 필터 예: siteId에 따라 score에 약간 변화 주기
for rec in recommendations:
    rec["score"] = round(rec["score"] - (0.01 * (site_id % 3)), 2)

# 결과 출력
print(json.dumps(recommendations))
