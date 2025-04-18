# ClassificationModel/recommend.py
import sys, json
import joblib

def main():
    input_data = json.loads(sys.stdin.read())

    model = joblib.load("recommend_model.pkl")
    input_vector = [
        input_data["brightness"],
        input_data["hour"],
        input_data["orientation"],
        input_data["budget"]
    ]
    proba = model.predict_proba([input_vector])[0]
    top = sorted(zip(proba, model.classes_), reverse=True)[:3]

    result = {
        "recommended": [c for _, c in top],
        "score": float(max(proba))
    }
    print(json.dumps(result))

if __name__ == "__main__":
    main()
