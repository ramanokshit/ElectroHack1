import logging
import cv2
import numpy as np
from ultralytics import YOLO
import math

Weights = [1,0.5,2]

# Set logger level to suppress info messages
logging.getLogger("ultralytics").setLevel(logging.WARNING)

# Load the YOLO model
model = YOLO('yolo11l.pt', verbose=False)

# Define custom colors for specific classes (BGR format)
custom_colors = {
    2: (0, 0, 255),     # Red for cars (class 2)
    3: (255, 255, 0),   # Cyan for motorcycles (class 3)
    7: (255, 0, 255)    # Magenta for trucks (class 7)
}

# Open the video file
video_path = "indian_traffic.mp4"
cap = cv2.VideoCapture(video_path)

if not cap.isOpened():
    print("Error: Could not open video.")
    exit()

# Load and prepare the mask
mask_path = "mask2.png"
mask = cv2.imread(mask_path, cv2.IMREAD_GRAYSCALE)
if mask is None:
    print("Error: Could not load the mask image.")
    exit()

# Adjust mask size to match video dimensions
ret, first_frame = cap.read()
if not ret:
    print("Error: Could not read the first frame.")
    exit()

height, width = first_frame.shape[:2]
if mask.shape != (height, width):
    mask = cv2.resize(mask, (width, height))

cap.set(cv2.CAP_PROP_POS_FRAMES, 0)

# Video properties
fps = cap.get(cv2.CAP_PROP_FPS)
frame_count = 0
next_process_frame = 0  # Track next frame to process

while True:
    ret, frame = cap.read()
    if not ret:
        break

    if frame_count >= next_process_frame:
        # Apply mask and draw outline
        masked_frame = cv2.bitwise_and(frame, frame, mask=mask)
        contours, _ = cv2.findContours(mask, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
        cv2.drawContours(frame, contours, -1, (0, 255, 255), 2)

        # YOLO inference
        results = model(masked_frame, verbose=False)

        # Build detection summary
        detected_objects = {}
        for result in results[0].boxes:
            class_id = int(result.cls)
            if class_id not in [2, 3, 7]:
                continue
            label = model.names[class_id]
            detected_objects[label] = detected_objects.get(label, 0) + 1

        # Calculate delay
        required_keys = ["car", "motorcycle", "truck"]
        values = [detected_objects.get(key, 0) for key in required_keys]
        delay = 0
        output = ""
        for index in range(len(values)):
            output = output + bin(values[index])[2:].zfill(8)
            delay = delay + (values[index] * Weights[index])
        delay = math.ceil(delay)
        delay = math.ceil(delay)
        print(f"count for car bikes trucks :{values}")
        print(f"Total vechiles:{delay}")
        print(f"output in binary : {output} \n")

        # Calculate next processing frame based on dynamic delay
        next_process_frame = frame_count + int(delay * fps)

        # Annotate frame with detections
        annotated_frame = frame.copy()
        for result in results[0].boxes:
            class_id = int(result.cls)
            if class_id not in [2, 3, 7]:
                continue

            color = custom_colors.get(class_id, (255, 255, 255))
            bbox = result.xyxy[0].cpu().numpy()
            conf = result.conf.cpu().numpy()

            x1, y1, x2, y2 = map(int, bbox)
            cv2.rectangle(annotated_frame, (x1, y1), (x2, y2), color, 2)

            label_text = f"{model.names[class_id]} {conf[0]:.2f}"
            cv2.putText(annotated_frame, label_text, (x1, y1 - 10),
                        cv2.FONT_HERSHEY_SIMPLEX, 0.9, color, 2)

        cv2.imshow("YOLO Inference", annotated_frame)
        cv2.waitKey(0)  # Show frame briefly
    else:
        cv2.imshow("YOLO Inference", frame)
        cv2.waitKey(1)

    frame_count += 1

cap.release()
cv2.destroyAllWindows()