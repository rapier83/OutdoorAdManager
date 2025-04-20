# recommend_train.py
import sys
import json

def main():
    data = json.load(sys.stdin)
    print("✅ Received training data with", len(data), "entries.")
    # 모델 학습 로직 자리
    print("🎉 Training complete")

if __name__ == "__main__":
    main()
