# ReceiptIQ

**Scan. Track. Stay Smart.**

ReceiptIQ is a mobile application built with Flutter that allows users to scan receipts and automatically track their spending. The app uses on-device OCR (Optical Character Recognition) to extract key information from receipts and provides simple spending insights.

---

## Features

* Scan receipts using your phone camera
* Extract text using OCR
* Review and edit extracted data
* Store receipts locally (offline-first)
* View spending summaries and insights

---

## Tech Stack

* **Frontend:** Flutter
* **OCR:** Google ML Kit Text Recognition
* **Storage:** Hive / SQLite


---

## App Workflow

1. Capture a receipt using the camera
2. Extract text from the image
3. Parse key information:
   * Store name
   * Date
   * Total amount
4. Allow user to review and edit
5. Save receipt locally
6. View spending insights

---

## Getting Started

### Prerequisites

* Flutter SDK installed
* Android Studio / VS Code
* Physical device or emulator

### Installation

```bash
git clone https://github.com/Tafadzwa18/Receiptiq.git
cd Receiptiq
flutter pub get
flutter run
```

---

##  MVP Goals

* Basic receipt scanning
* OCR text extraction
* Manual data correction
* Local storage
* Simple spending dashboard

---

## Future Improvements

* Smart categorization (auto-detect spending categories)
* Cloud sync (Firebase / Django backend)
* Duplicate receipt detection
* Multi-currency support
* Export reports (PDF/CSV)
* WhatsApp/email receipt import

---

## Notes

* OCR accuracy may vary depending on receipt quality
* Users can manually correct extracted data
* App is designed to work offline-first
