# classification_sample_data_generator.py
import numpy as np

# 샘플: 100개, 28x28 = 784차원 입력, 클래스는 0~9 사이 숫자
np.random.seed(42)
X = np.random.rand(100, 784)  # 0~1 사이 랜덤 픽셀
y = np.random.randint(0, 10, size=100)  # 10개 클래스

np.savez("classification_data.npz", X=X, y=y)
print("✅ 샘플 학습 데이터 저장 완료!")
