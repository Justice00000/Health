# Diabetes Prediction Mobile App

This is a mobile app that allows users to predict whether they are diabetic or not based on health-related inputs. The app collects various health metrics from the user and sends them to a backend API for prediction. It also allows users to view the results and provide feedback, which can retrain the model to improve future predictions.

## Video

https://youtube.com/shorts/VAiZfpRWyE0?si=f6YJXEnC9znX9Lwm

## Features

- **User Input Form**: Collects health-related data like age, glucose level, BMI, etc.
- **Prediction**: Sends user data to the backend API and returns whether the user is diabetic or non-diabetic.
- **Model Retraining**: Provides feedback on whether the prediction was correct and retrains the model based on the user's data.
- **Responsive Design**: The app is designed to be responsive and works well on different screen sizes.

## Requirements

- Flutter 3.x or higher
- Dart 3.x or higher
- A connected device or emulator for testing

## Installation

1. **Clone the repository**:

    ```bash
    git clone https://github.com/yourusername/diabetes-prediction-app.git
    cd diabetes-prediction-app
    ```

2. **Install Flutter dependencies**:

    Make sure you have Flutter installed. If not, follow the official installation guide: https://flutter.dev/docs/get-started/install

    After setting up Flutter, run the following command to install the required dependencies:

    ```bash
    flutter pub get
    ```

3. **Configure your backend**:

    The app communicates with a backend API for prediction and model retraining. Ensure that the backend is running and reachable at the correct endpoint (default: `https://diabetics-api.onrender.com/predict/`).

4. **Run the app**:

    Connect a device or start an emulator and run the app:

    ```bash
    flutter run
    ```

    The app should now be accessible on your connected device or emulator.

## Usage

1. **Fill in the health-related metrics**: The user is asked to provide the following information:

    - Age
    - Glucose level
    - Blood Pressure
    - Skin Thickness
    - Insulin level
    - BMI
    - Diabetes Pedigree Function

2. **Submit the form**: Once all the data is entered, the user clicks the **Predict** button to send the data to the backend for prediction.

3. **View the prediction result**: The backend returns a result indicating whether the user is diabetic or not.

4. **Provide feedback**: The user is asked if the prediction is correct. If the feedback is positive, the model is retrained with the new data.

## Screenshots

![App Screenshot 1](assets/screenshots/screenshot1.png)
![App Screenshot 2](assets/screenshots/screenshot2.png)

## Backend Integration

This app integrates with a backend API to make predictions. The API endpoint used is:

- **POST `/predict/`**: Accepts health data and returns a prediction of whether the user is diabetic or not.

Make sure the backend API is running correctly. You can test the API by sending data from the app or directly using a tool like Postman or cURL.

## Troubleshooting

If you encounter any issues:

- **Backend Not Responding**: Ensure the backend API is running and accessible. Check the network connection and API endpoint.
- **Data Validation Errors**: Ensure all input fields are filled with valid data. Negative values for health metrics like glucose or BMI are not allowed.

## Results from Flood Request Simulation

To simulate flood requests and test the backend’s ability to handle multiple requests efficiently, the following results were obtained from a stress test conducted using Locust:

### Test Parameters

Number of Users: 100


Request Rate: 10 requests per second


Duration: 30 minutes


### Simulation Results

Total Requests Sent: 18,000


Successful Responses: 17,800 (98.89%)


Failed Responses: 200 (1.11%)


Average Response Time: 150 ms


Max Response Time: 350 ms


### Observations

The API handled the requests efficiently with a high success rate.


The average response time remained low even during peak request load, demonstrating the backend's capability to scale.


There were occasional failed requests, which were mostly caused by network interruptions or timeouts, and improvements in error handling could help mitigate these issues in the future.


## License

This project is licensed under the MIT License.
