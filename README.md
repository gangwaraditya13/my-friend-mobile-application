# My Friend - Mobile Application

My Friend is a versatile Flutter-based mobile application designed as a personal space to capture memories, express thoughts, and connect with others. It functions as a digital diary where users can create, manage, and customize their posts, complete with images and colorful titles.

## Features

*   **User Authentication:** Secure registration and login functionality for a personalized experience.
*   **Post Management:** Full CRUD (Create, Read, Update, Delete) capabilities for personal diary entries.
*   **Rich Content:** Attach images from the gallery to enrich your posts.
*   **Profile Customization:** Users can update their profile information, including their username, gmail, and profile picture.
*   **Account Management:** Securely change passwords and the option to permanently delete the account.
*   **Expressive Titles:** Use a built-in color picker to customize the color of post titles.
*   **Intuitive UI:** Employs slidable actions for easy post deletion directly from the home screen.
*   **About Page:** Learn more about the application and connect with the developer via social media links.

## Backend Dependency

This is the frontend mobile application which requires a corresponding backend server to be running. The application is configured to connect to the backend at `http://10.0.2.2:8080`, which is the standard alias for the host machine's localhost when running from an Android emulator.

## Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

*   Flutter SDK installed on your machine. You can find instructions [here](https://flutter.dev/docs/get-started/install).
*   An IDE like VS Code or Android Studio with the Flutter plugin.
*   A running instance of the backend server for this application.

### Installation

1.  **Clone the repository:**
    ```sh
    git clone https://github.com/gangwaraditya13/my-friend-mobile-application.git
    ```
2.  **Navigate to the project directory:**
    ```sh
    cd my-friend-mobile-application
    ```
3.  **Install dependencies:**
    ```sh
    flutter pub get
    ```
4.  **Run the application:**
    Ensure you have an emulator running or a device connected.
    ```sh
    flutter run
    ```

## Project Structure

The core logic of the application is located in the `lib/` directory, organized as follows:

*   **`main.dart`**: The entry point of the application.
*   **`lib/` (root)**: Contains the main page widgets like `LoginPage.dart`, `Register_Page.dart`, `Home_Page.dart`, `Add_New_Post.dart`, and `Edit_Post.dart`.
*   **`lib/entities/`**: Defines the data models (POCOs) such as `User`, `UserPost`, and `TitleColor` used for structuring data from the API.
*   **`lib/repos/`**: Contains repository classes (`user_repo.dart`, `user_post_repo.dart`) responsible for handling all communication with the backend API.
*   **`lib/module/`**: Includes feature-specific screens and their primary logic, such as `About_User.dart` and `User_Post_page.dart`.
*   **`lib/component/`**: Holds reusable UI widgets like `User_Detail_Input.dart` and `Post_Component.dart` that are used across multiple screens.

## Key Dependencies

*   **`http`**: For making network requests to the backend API.
*   **`provider`**: For simple and efficient state management.
*   **`image_picker`** & **`flutter_image_compress`**: For selecting and compressing images.
*   **`flutter_slidable`**: For creating list items with swipeable actions.
*   **`flutter_colorpicker`**: To provide a color selection UI for post titles.
*   **`url_launcher`**: To open external links, such as social media profiles.