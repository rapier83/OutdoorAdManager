# recommend.py
import sys
import json

def recommend(data):
    result = []
    for item in data:
        score = item.get("budget", 0) * 0.01 + item.get("predictedImpression", 0) * 0.1
        result.append({
            "adId": item["campaignId"],
            "title": f"Predicted Campaign {item['campaignId']}",
            "score": round(score, 2)
        })
    return result

def main():
    try:
        input_str = sys.stdin.read()
        input_data = json.loads(input_str)
        predictions = recommend(input_data)
        print(json.dumps(predictions))
    except Exception as e:
        print(json.dumps({"error": str(e)}))

if __name__ == "__main__":
    main()
