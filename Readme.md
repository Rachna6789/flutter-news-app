# 📰 Flutter News Headlines App

A clean and minimalistic mobile application built with Flutter that fetches and displays real-time news articles from the NewsAPI. This project was developed as a technical assignment to demonstrate proficiency in core Flutter concepts, including UI/UX design, API integration, and Provider state management.

---

## ✨ Features Implemented

This application successfully implements all core requirements and several bonus features:

### Core Requirements
* **Minimalistic UI:** Implemented a card-based list view for clear separation of articles.
* **API Integration:** Fetches top US headlines from NewsAPI.
* **State Management:** Utilizes the **Provider** package to manage application state (article list, loading, and errors).
* **Navigation:** Seamless navigation from the Article List Screen to the Article Detail Screen.
* **Error Handling:** Displays friendly messages for API errors (e.g., Status Code 401) and loading states.

### Bonus Features
* **Pull-to-Refresh:** Allows users to refresh the news list by pulling down on the screen.
* **Dark Mode:** Implements a user-toggleable light/dark theme switch.
* **Search Functionality:** Uses a custom `SearchDelegate` to query the NewsAPI for specific topics.

---

## 🛠️ Setup and Run Instructions

Follow these steps to get the project running on your local machine.

### 1. Prerequisites

* **Flutter SDK:** Ensure you have a recent version of Flutter (v3.19+) installed.
* **Git:** Installed and configured globally.
* **NewsAPI Key:** Get a free API key from [https://newsapi.org/](https://newsapi.org/).

### 2. Clone the Repository

```bash
git clone [YOUR REPOSITORY URL HERE]
cd [YOUR PROJECT DIRECTORY NAME]
