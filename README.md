# TipCalcApp

TipCalcApp is a minimal, user-focused iOS application built with SwiftUI that helps users quickly calculate tips or work backwards from a desired total.

---

## Overview

This application was designed to solve two common real-world scenarios:

1. A user wants to quickly calculate a tip based on a bill amount.
2. A user wants to cap their total spend and determine what tip percentage that implies.

Rather than combining both workflows into a single cluttered interface, the app separates them into two distinct modes using a segmented control. This improves usability by aligning the interface with the user’s intent.

---

## Features

- **Tip Percentage Mode**
  - Input a pre-tax bill amount
  - Adjust the tip using a slider
  - Instantly view calculated tip and total

- **Target Total Mode**
  - Input a pre-tax bill amount
  - Input a desired final total
  - Automatically calculates tip amount and effective tip percentage

- **Real-Time Calculations**
  - All values update instantly as inputs change

- **Large Total Display**
  - Inspired by Apple Pay’s visual hierarchy
  - Prioritizes the most important value: the final total

- **Haptic Feedback**
  - Subtle feedback when adjusting the tip slider (run on a physical device to feel haptic feedback)
  - Improves perceived responsiveness

- **Dark Mode Support**
  - Uses system settings for a consistent native appearance

---

## Design Decisions

### 1. Separation of Concerns (Two Modes)
The app uses a segmented control to separate "Tip %" and "Target Total" workflows.

These represent two different mental models:
- Forward calculation (bill → tip → total)
- Reverse calculation (bill + target → tip)

Combining them into one screen would introduce conflicting inputs and reduce clarity. Separating them ensures each screen remains simple and purpose-driven.

---

### 2. Minimal Input Friction
Text fields:
- Do not pre-fill values
- Use placeholder text (e.g., "Enter Amount Pre-Tax")
- Include a greyed-out `$` symbol to guide input without requiring manual entry

This reduces cognitive load and prevents formatting errors.

---

### 3. Real-Time State-Driven Updates
The app relies on SwiftUI’s state system:
- `@State` properties store user inputs
- Derived values (tip, total, percentages) are computed properties

This ensures:
- Immediate UI updates
- No need for explicit “calculate” actions
- A reactive, modern user experience

---

### 4. Visual Hierarchy
The layout prioritizes information as follows:
1. Final total (largest, boldest element)
2. Supporting values (tip amount, percentage)
3. Inputs (top of screen for accessibility)

The large total display mirrors patterns used in financial apps, reinforcing clarity and confidence in the result.

---

### 5. Interaction Feedback
A light haptic feedback is triggered when the tip slider changes. This:
- Reinforces user interaction
- Makes the app feel more responsive and polished

---

### 6. Adaptive UI
The app uses:
- `ultraThinMaterial` backgrounds
- System colors
- Flexible layouts

This ensures:
- Native appearance across light/dark mode
- Compatibility across different device sizes

---

## Technical Stack

- **Swift**
- **SwiftUI** for UI and state management
- **UIKit** (UIImpactFeedbackGenerator) for haptics

---

## Project Structure

- `ContentView.swift`
  - Contains the main UI
  - Handles tab switching, layout, and calculations

Key components:
- Segmented control for mode selection
- Shared input components
- Computed properties for all calculations
- Reusable row and total display views

---

## Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/tejabokk/TipCalcApp.git
2. Open the project:
   ```bash
   open TipCalcApp.xcodeproj
3. Run on a simulator or physical device

---

## Future Improvements
- Bill splitting across multiple users
- Persistent storage for recent calculations
- Currency localization support
- Input validation and formatting enhancements
