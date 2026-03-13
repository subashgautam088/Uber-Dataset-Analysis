## Uber Booking Status Prediction

This is a **Machine Learning project** to predict the booking status of Uber rides based on various features like vehicle type, pickup/drop locations, ride distance, ratings, time, and payment method.  

The project is built using **Python**, **Streamlit**, and **scikit-learn**. It also includes a Jupyter notebook for EDA and model building.

---

## 🗂 Project Structure

```

Uber-Booking-ML-Project/
│
├── app.py                     # Streamlit app
├── uber_dataset.csv           # Raw dataset
├── Uber_analysis.png          # EDA / visualization
├── Uber analysis.png          # Additional visualization
├── model/
│   ├── uber_model.pkl         # Trained ML model
│   └── label_encoder.pkl      # Label encoder for categorical variables
├── notebook/
│   └── Uber datset Booking status.ipynb  # Jupyter notebook for analysis & model
├── .gitignore                 # To ignore unnecessary files
└── README.md                  # Project documentation

````

---

## ⚡ Features

- Predict **Uber booking status**: Confirmed, Cancelled, or No-Show.  
- Input features include:
  - Vehicle Type, Pickup Location, Drop Location
  - Avg VTAT, Avg CTAT
  - Booking Value, Ride Distance
  - Driver & Customer Ratings
  - Payment Method
  - Hour, Day, Month, Time Period
- **Interactive Streamlit app** to enter ride details and get prediction instantly.

---

## 🛠 Technologies Used

- Python 3.x  
- pandas, scikit-learn, pickle  
- Streamlit for interactive web app  
- Jupyter Notebook for data analysis and model building  

---

## 📊 Usage

1. Clone the repository:

```bash
git clone https://github.com/subashgautam088/Uber-Dataset-Analysis.git
cd Uber-Dataset-Analysis
````

2. Create and activate virtual environment (recommended):

```bash
python -m venv venv
# Windows
venv\Scripts\activate
# Linux/Mac
source venv/bin/activate
```

3. Install dependencies:

```bash
pip install -r requirements.txt
```

4. Run the Streamlit app:

```bash
streamlit run app.py
```

5. Enter Uber ride details in the app and get **Booking Status prediction**.

---

## 📝 Notes

* Make sure `model/uber_model.pkl` and `model/label_encoder.pkl` are in place.
* The dataset and notebook are for analysis and training reference.
* Visualizations (`Uber_analysis.png`, `Uber analysis.png`) show insights from the dataset.

---

## 📂 Author

**Arun Gautam**

* Mechanical Engineer & Data Analyst
* Location: Jaunpur
* Email: [subashgautam088@gmail.com](mailto:subashgautam088@gmail.com)

---

```
