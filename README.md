Intelligent Traffic Management Using FPGA and Computer Vision

Team Matrix - Electro Hack

Project Overview

This project presents an Intelligent Traffic Management System leveraging FPGA and Computer Vision to address urban congestion challenges. The system integrates Verilog-based FPGA logic with real-time traffic analysis using YOLO and OpenCV, ensuring optimized signal control for metropolitan cities.

Key Features

Smart Traffic Signal Algorithm: Implemented using Verilog FSMs for dynamic signal control.

FPGA-Based Processing: Utilizing Altera Cyclone IV E (DE2-115) for real-time signal adjustments.

Traffic Analysis with YOLO & OpenCV: Enables real-time vehicle detection and classification.

Adaptive Control: Dynamically adjusts signal durations based on traffic density.

Multi-Class Detection: Identifies cars, buses, motorcycles, and pedestrians.

Implementation Details

1. FPGA-Based Traffic Signal Control

Developed using Verilog and tested on AMD Vivado & Intel Quartus Prime v23.0.

Implements a 4-state FSM controlling two-lane, four-way intersections.

Uses clock divider logic to generate 1 Hz signal for real-time transitions.

2. Computer Vision-Based Traffic Analysis

YOLO Model: Performs real-time vehicle detection.

OpenCV Processing: Handles image preprocessing, video capture, and visualization.

Dynamic Frame Capture: Reduces computational overhead by processing frames based on traffic density.

Masking Strategy: Focuses analysis on lanes and intersections.

Hardware Acceleration: Exploring GPU support to enhance real-time performance.

3. Communication Between FPGA & Python

UART Communication: Transfers processed data from Python to FPGA for signal control.

Ethernet-Based Data Transfer: Uses TCP/IP or UDP communication for high-speed data exchange.

Tools & Technologies Used

Software: AMD Vivado, Intel Quartus Prime

Hardware: Altera Cyclone IV E (DE2-115), USB Blaster

Libraries: OpenCV, YOLO, pySerial, socket (for Ethernet communication)

OS: Windows 11

Repository

GitHub Repository: ElectroHack

Future Improvements

Integration with IoT for remote traffic monitoring.

Real-time traffic prediction using AI models.

Further optimization of FPGA resource usage.

For more details, check out the full project documentation in the repository.
