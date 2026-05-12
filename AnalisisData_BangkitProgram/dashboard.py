# Import Library
import streamlit as st
import pandas as pd
import plotly.express as px

def load_data():
  data = pd.read_csv("hour.csv")
  return data
data = load_data()

# ==============================
# TITLE DASHBOARD
# ==============================
# Set page title
st.title("Bike Sharing Dashboard")

# ==============================
# SIDEBAR
# ==============================
st.sidebar.title("Data Information")
st.sidebar.markdown("**• Nama: Zahra Nadhifah**")
st.sidebar.markdown(
    "**• ID Bangkit: M335D4KX2127**")
st.sidebar.markdown(
    "**• Email: zahraanadhfh@gmail.com**")

option = st.sidebar.selectbox(
    'Pilih Menu:',
    ('Dataframe','Visualization')
)
if option == 'Dataframe' or option == '':
    st.write("""# Dataframe Information:sparkles:""") #menampilkan halaman utama
    st.write("[Download Dataset](https://www.kaggle.com/datasets/lakshmi25npathi/bike-sharing-dataset)")
    st.write('**Season:**') 
    st.write('1 = Springer')
    st.write('2 = Summer')
    st.write('3 = Fall')
    st.write('4 = Winter')
    st.write('**Weather:**')
    st.write('1: Clear, Few clouds, Partly cloudy, Partly cloudy')
    st.write('2: Mist + Cloudy, Mist + Broken clouds, Mist + Few clouds, Mist')
    st.write('3: Light Snow, Light Rain + Thunderstorm + Scattered clouds, Light Rain + Scattered clouds')
    st.write('4: Heavy Rain + Ice Pallets + Thunderstorm + Mist, Snow + Fog')
    st.subheader("Summary Statistics - Bike Sharing")
    st.write(data.describe())

elif option == 'Visualization':
    st.write("""# Chart Information:sparkles:""") #menampilkan judul halaman dataframe

    # Hourly bike share count
st.subheader("Hourly Bike Share Count")

hourly_count = data.groupby("hr")["cnt"].sum().reset_index()

# Visualisasi dengan st.line_chart
st.line_chart(hourly_count.set_index("hr"))

        # Fungsi untuk membuat visualisasi
def create_seasonal_plot(data):
    # Mengelompokkan data berdasarkan musim dan menghitung rata-rata jumlah sewa
    seasonal_data = data.groupby('season')['cnt'].mean().reset_index()

    # Menampilkan judul
    st.title('Correlation between Season and Rental Bike')

    # Membuat plot menggunakan Plotly Express
    fig = px.bar(seasonal_data, x='season', y='cnt', color='cnt',
                 labels={'season': 'Musim', 'cnt': 'Jumlah Sewa'},
                 title='Rata-Rata Jumlah Sewa Sepeda per Musim (Tahun 2012)')

    # Menampilkan plot menggunakan st.plotly_chart
    st.plotly_chart(fig, use_container_width=True)

# Memuat data
data = load_data()

# Membuat visualisasi
create_seasonal_plot(data)

# Fungsi untuk membuat visualisasi
def create_bar_chart(data):
    # Mengelompokkan data berdasarkan holiday dan workingday, dan menghitung rata-rata jumlah sewa
    rental_data = data.groupby(['holiday', 'workingday'])['cnt'].mean().reset_index()

    # Menampilkan judul
    st.title('Correlation between Holiday and Workingday to Total of Rental Bike')

    # Membuat plot batang menggunakan Plotly Express
    fig = px.bar(rental_data, x='holiday', y='cnt', color='workingday',
                 labels={'holiday': 'Holiday', 'cnt': 'Jumlah Sewa', 'workingday': 'Working Day'},
                 title='Rata-Rata Jumlah Sewa Sepeda berdasarkan Holiday dan Working Day (Tahun 2012)')

    # Menampilkan plot batang menggunakan st.plotly_chart
    st.plotly_chart(fig, use_container_width=True)

# Memuat data
data = load_data()

# Membuat visualisasi
create_bar_chart(data)