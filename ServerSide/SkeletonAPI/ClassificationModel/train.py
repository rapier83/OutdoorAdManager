<<<<<<< HEAD
# ClassificationModel/train.py
import time
import sys
import os
import numpy as np
from sklearn.linear_model import LogisticRegression
import joblib

status_file = "training_status.txt"
model_file = "classification_model.pkl"
data_file = "classification_data.npz"

# 상태: 학습 시작
with open(status_file, "w", encoding="utf-8") as f:
    f.write("training")

print("🚀 모델 재학습 시작...")

# 데이터 로딩 (classification_data.npz: X, y)
if not os.path.exists(data_file):
    print("❌ 데이터 파일이 존재하지 않습니다.")
    with open(status_file, "w", encoding="utf-8") as f:
        f.write("error: no data")
    sys.exit(1)

with np.load(data_file) as data:
    X = data['X']
    y = data['y']

# 모델 학습
model = LogisticRegression(max_iter=200)
model.fit(X, y)

# 모델 저장
joblib.dump(model, model_file)

# 학습 결과 로그 기록
with open("training_log.txt", "w", encoding="utf-8") as f:
    f.write("✅ 학습 완료!\n")
    f.write("모델: LogisticRegression\n")
    f.write(f"데이터 크기: {X.shape}\n")
    f.write("정확도(훈련): {:.2f}%\n".format(model.score(X, y) * 100))

# 상태: 완료
with open(status_file, "w", encoding="utf-8") as f:
    f.write("completed")

print("✅ 모델 학습 완료")
=======
# ClassificationModel/train.py
import time
import sys
import os
import numpy as np
from sklearn.linear_model import LogisticRegression
import joblib

status_file = "training_status.txt"
model_file = "classification_model.pkl"
data_file = "classification_data.npz"

# 상태: 학습 시작
with open(status_file, "w", encoding="utf-8") as f:
    f.write("training")

print("🚀 모델 재학습 시작...")

# 데이터 로딩 (classification_data.npz: X, y)
if not os.path.exists(data_file):
    print("❌ 데이터 파일이 존재하지 않습니다.")
    with open(status_file, "w", encoding="utf-8") as f:
        f.write("error: no data")
    sys.exit(1)

with np.load(data_file) as data:
    X = data['X']
    y = data['y']

# 모델 학습
model = LogisticRegression(max_iter=200)
model.fit(X, y)

# 모델 저장
joblib.dump(model, model_file)

# 학습 결과 로그 기록
with open("training_log.txt", "w", encoding="utf-8") as f:
    f.write("✅ 학습 완료!\n")
    f.write("모델: LogisticRegression\n")
    f.write(f"데이터 크기: {X.shape}\n")
    f.write("정확도(훈련): {:.2f}%\n".format(model.score(X, y) * 100))

# 상태: 완료
with open(status_file, "w", encoding="utf-8") as f:
    f.write("completed")

print("✅ 모델 학습 완료")
>>>>>>> ce9af146ce06abdf0e406970988b4dad0a069acd
