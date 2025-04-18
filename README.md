# 🚦 Intelligent Traffic Management Using FPGA and Computer Vision

**Team Name:** MATRIX (Nokshit Rama, Jaya Kushal, Ravi Teja, Yokeshwar Reddy, Mohammed Nabeel)  
**Event Name:** ELECTRO HACK  
**Project Title:** Intelligent Traffic Management Using FPGA and Computer Vision  

## 📌 Overview
Urbanization in metro cities like Delhi, Mumbai, Chennai, and Bengaluru has led to increased traffic congestion, delays, and pollution. This project aims to implement an **FPGA-based smart traffic management system** using **Verilog, YOLO, and OpenCV** to optimize traffic flow dynamically.

---

## 🛠 Implementation

### 🔹 Traffic Algorithm
- **One lane 2-way**: Alternating traffic flow between lanes.
- **2-lane 4-way intersection**: Uses a **Finite State Machine (FSM)** to manage lane priority and traffic signal switching efficiently.

🔗 **Reference:** [How Do Traffic Signals Work?](https://www.youtube.com/watch?v=DP62ogEZgkI)

### 🔹 FPGA Implementation
The FPGA processes traffic data from **Python-based traffic analysis** and adjusts signal timings dynamically.
- **Software Used:** AMD Vivado, Intel Quartus Prime v23.0
- **Hardware:** Altera Cyclone IV E (DE2-115), USB Blaster
- **OS:** Windows 11

🔗 **Cyclone IV E User Manual:** [Click Here](https://www.terasic.com.tw/attachment/archive/502/DE2_115_User_manual.pdf)

### 🔹 Verilog-Based Smart Traffic Controller
**Repository:** [GitHub](https://github.com/JayaKushal24/ElectroHack)

#### ⚡ Core Modules:
1. **Traffic Controller (Main Unit)** - Manages signal timing and state transitions.
2. **Reset Module** - Implements a delayed reset to prevent instability.
3. **1Hz Clock Generator** - Derives a low-frequency clock for real-world timing.
4. **State Machine** - Controls **Green-Yellow-Red** transitions dynamically based on traffic density.

---

## 🚗 Traffic Analysis Using YOLO and OpenCV

### 🤖 Why YOLO?
- **Real-time Object Detection** 🕒
- **High Accuracy & Lightweight Models**
- **Multi-Class Detection (Cars, Bikes, Pedestrians, etc.)**
- **Scalability and Flexibility**

### 🏎 Why OpenCV?
- **Preprocessing (Resizing, Filtering, Noise Reduction)**
- **Video Capture & Streaming (IP/USB Cameras)**
- **Post-processing (Bounding Boxes, Annotations, Visualization)**

### 🔗 How YOLO & OpenCV Work Together:
1. **OpenCV** captures and preprocesses video.
2. **YOLO** detects vehicles and objects.
3. **OpenCV** overlays bounding boxes and visualizes real-time results.

---

## 🖥 Python-FPGA Communication
### 📡 UART-Based Communication
- Transfers Python-generated traffic data to the FPGA via a **USB-to-UART** cable.
- FPGA processes input using a **Nios II soft-core processor** or **custom logic**.

### 🌐 Ethernet-Based Communication
- Uses **TCP/IP or UDP sockets** to send data from Python to FPGA.
- FPGA receives data, processes it, and updates traffic light logic dynamically.

---

## 🎯 Key Features
✅ **Real-time Traffic Monitoring**  
✅ **FPGA-Based Signal Control**  
✅ **Optimized for Metropolitan Traffic**  
✅ **YOLO & OpenCV for Vehicle Detection**  
✅ **Python-FPGA Data Transfer via UART/Ethernet**  

🚀 **Developed by Team MATRIX**  
📂 **Repository:** [GitHub - ElectroHack](https://github.com/JayaKushal24/ElectroHack)
