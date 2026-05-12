import streamlit as st
import pandas as pd
import altair as alt

st.set_page_config(layout="wide")
st.title("Dashboard Gudang Andi")

# Tab navigasi utama
tab1, tab2, tab3 = st.tabs([
    "Dashboard Utama",
    "Statistik Barang",
    "Pelaporan Harian"
])

# ==============================
# Dashboard Utama
# ==============================
with tab1:
    st.header("Sisa Barang di Gudang")

    dashboard_csv = st.file_uploader("Upload CSV - Dashboard Utama", type=["csv"], key="dashboard")

    if dashboard_csv:
        df_dash = pd.read_csv(dashboard_csv)

        stok = df_dash.groupby(['product_name', 'unit'])['total_quantity'].sum().reset_index()
        stok = stok.rename(columns={
            "product_name": "Nama Barang",
            "unit": "Unit",
            "total_quantity": "Sisa Barang"
        })

        stok = stok[['Nama Barang', 'Sisa Barang', 'Unit']]  # Susun ulang kolom

        st.dataframe(stok)

        st.subheader("Statistik Barang di Gudang")
        st.bar_chart(data=stok, x="Nama Barang", y="Sisa Barang")
    else:
        st.info("Silakan upload file CSV untuk Dashboard Utama.")

# ==============================
# Statistik Barang
# ==============================
with tab2:
    st.header("Statistik Barang Masuk dan Keluar")

    statistik_csv = st.file_uploader("Upload CSV - Statistik Barang", type=["csv"], key="statistik")

    if statistik_csv:
        df_stat = pd.read_csv(statistik_csv)

        required_cols = {"product_id", "product_name", "total_in", "total_out"}
        if required_cols.issubset(df_stat.columns):
            df_stat['total_in'] = pd.to_numeric(df_stat['total_in'], errors='coerce').fillna(0)
            df_stat['total_out'] = pd.to_numeric(df_stat['total_out'], errors='coerce').fillna(0)

            st.subheader("Tabel Statistik Barang")
            st.dataframe(df_stat)

            df_long = df_stat.melt(
                id_vars=["product_id", "product_name"],
                value_vars=["total_in", "total_out"],
                var_name="Tipe",
                value_name="Jumlah"
            )

            st.subheader("Visualisasi Barang Masuk vs Keluar")
            chart = alt.Chart(df_long).mark_bar().encode(
                x=alt.X('product_name:N', title="Nama Barang", sort='-y'),
                y=alt.Y('Jumlah:Q'),
                color=alt.Color('Tipe:N', title="Jenis"),
                tooltip=['product_name', 'Tipe', 'Jumlah']
            ).properties(width=700)

            st.altair_chart(chart, use_container_width=True)
        else:
            st.error("Kolom CSV tidak sesuai. Pastikan mengandung: product_id, product_name, total_in, total_out")
    else:
        st.info("Silakan upload file CSV untuk Statistik Barang.")

# ==============================
# Pelaporan Harian
# ==============================
with tab3:
    st.header("Statistik Pelaporan Barang Harian")

    pelaporan_csv = st.file_uploader("Upload CSV - Pelaporan Harian", type=["csv"], key="pelaporan")

    if pelaporan_csv:
        df_harian = pd.read_csv(pelaporan_csv, parse_dates=["date"])
        df_harian.columns = df_harian.columns.str.strip().str.lower()  # Normalisasi nama kolom

        st.subheader("Tabel Pelaporan Harian")
        st.dataframe(df_harian)

        df_long = df_harian.melt(
            id_vars=["date"],
            value_vars=["incoming", "processed", "outgoing"],
            var_name="jenis",
            value_name="jumlah"
        )

        st.subheader("Visualisasi Barang Masuk, Diproses, dan Dikirim per Hari")
        chart = alt.Chart(df_long).mark_bar().encode(
            x=alt.X('date:T', title='Tanggal'),
            y=alt.Y('jumlah:Q', title='Jumlah Barang'),
            color=alt.Color('jenis:N', title='Jenis Kegiatan'),
            tooltip=['date:T', 'jenis:N', 'jumlah:Q']
        ).properties(width=700)

        st.altair_chart(chart, use_container_width=True)
    else:
        st.info("Silakan upload file CSV untuk Statistik Pelaporan Harian.")
