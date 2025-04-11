# ClassificationModel/classify.py

import sys
import json

def fake_classifier(inputs):
    score = sum(inputs)
    if score < 3:
        return 1, "Low population area"
    elif score < 5:
        return 3, "Medium-sized commercial area"
    else:
        return 7, "Hot place recommendation!"

def main():
    try:
        # Receive JSON from standard input (passed from Haskell)
        input_data = json.load(sys.stdin)  # ex: [1, 0, 1, 1]

        result_id, message = fake_classifier(input_data)

        output = {
            "result": result_id,
            "message": message
        }

        json.dump(output, sys.stdout, ensure_ascii=True)
        sys.stdout.flush()
    except Exception as e:
        json.dump({"error": str(e)}, sys.stdout, ensure_ascii=True)
        sys.stdout.flush()

if __name__ == "__main__":
    main()
