# 📱 iOS Purple Calculator

![Swift](https://img.shields.io/badge/Swift-FA7343?style=for-the-badge&logo=Swift&logoColor=white)
![SwiftUI](https://img.shields.io/badge/SwiftUI-007ACC?style=for-the-badge&logo=Swift&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-15.0+-000000?style=for-the-badge&logo=Apple&logoColor=white)

A stylish, minimalist calculator app for iOS inspired by Apple's classic design but reimagined in a deep purple color scheme. Built entirely with **SwiftUI** using a modern architecture and a custom responsive button grid.

---

## 🎨 Preview

<p align="center">
  <img src="https://github.com/VadimTan/mobile-ios-calculator/raw/main/AppIcon.png" width="200" alt="Calculator Icon" style="border-radius: 20%;"/>
</p>

> *Tip: You can add an actual app screenshot here later:*
> `<img src="path_to_screenshot.png" width="300" alt="App Screenshot"/>`

---

## ✨ Features

*   **Custom UI Grid**: Button layouts are built using an adaptive `LazyVGrid`, ensuring a flawless interface on all screen sizes—from iPhone SE to iPhone Pro Max.
*   **Animated Splash Screen**: Includes a custom loading screen upon app launch featuring a smooth dissolve (`opacity transition`) animation.
*   **Real-time Math Engine**: Seamlessly handles basic arithmetic operations (addition, subtraction, multiplication, division).
*   **Smart Formatting**: Dynamically formats output numbers (hides trailing zeros for integers and handles decimals cleanly using a standard `,` separator).

---

## 🛠 Tech Stack & Architecture

*   **Language:** Swift 5
*   **Framework:** SwiftUI
*   **Layout Components:** `LazyVGrid`, `VStack`, `HStack`
*   **State Management:** `@State` property wrappers for reactive, real-time UI rendering during calculations.

---

## 🚀 Getting Started

1. Clone the repository:
   ```bash
   git clone [https://github.com/VadimTan/mobile-ios-calculator.git](https://github.com/VadimTan/mobile-ios-calculator.git)
