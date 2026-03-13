import streamlit as st
import pandas as pd
import joblib
import pickle

# Load model
model = joblib.load('model\model.pkl')

with open('model\label_encoder.pkl', 'rb') as f:
    le_pipeline = pickle.load(f)

st.title("Uber Booking Status Prediction")

st.markdown("Enter the details of the Uber ride to predict Booking Status:")

# Inputs
vehicle_type = st.selectbox("Vehicle Type", ['Car', 'Bike', 'Auto'])
pickup_location = st.text_input("Pickup Location")
drop_location = st.text_input("Drop Location")

avg_vtat = st.number_input("Avg VTAT", min_value=0.0, step=0.01)
avg_ctat = st.number_input("Avg CTAT", min_value=0.0, step=0.01)
booking_value = st.number_input("Booking Value", min_value=0.0, step=0.01)
ride_distance = st.number_input("Ride Distance", min_value=0.0, step=0.01)

driver_ratings = st.number_input("Driver Ratings", min_value=0.0, max_value=5.0, step=0.1)
customer_rating = st.number_input("Customer Rating", min_value=0.0, max_value=5.0, step=0.1)

payment_method = st.selectbox("Payment Method", ['Cash', 'Card', 'UPI', 'Wallet'])

hour = st.number_input("Hour of booking (0-23)", min_value=0, max_value=23, step=1)
day = st.number_input("Day of month (1-31)", min_value=1, max_value=31, step=1)
month = st.number_input("Month (1-12)", min_value=1, max_value=12, step=1)

time_period = st.selectbox("Time Period", ['Morning', 'Afternoon', 'Evening', 'Night'])

# Predict button
if st.button("Predict Booking Status"):

    input_df = pd.DataFrame({
        'Vehicle Type': [vehicle_type],
        'Pickup Location': [pickup_location],
        'Drop Location': [drop_location],
        'Avg VTAT': [avg_vtat],
        'Avg CTAT': [avg_ctat],
        'Booking Value': [booking_value],
        'Ride Distance': [ride_distance],
        'Driver Ratings': [driver_ratings],
        'Customer Rating': [customer_rating],
        'Payment Method': [payment_method],
        'hour': [hour],
        'day': [day],
        'month': [month],
        'time_period': [time_period]
    })

    prediction = model.predict(input_df)

    decoded_prediction = le_pipeline.inverse_transform(prediction.reshape(-1))[0]

    st.success(f"The predicted Booking Status is: {decoded_prediction}")