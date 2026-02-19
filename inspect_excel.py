import pandas as pd

try:
    file_path = r'c:/Users/kyle/MPS/Obsidian/Obsidian_PeaceRiver_2025_v3.xlsx'
    df = pd.read_excel(file_path)
    print("Columns:", df.columns.tolist())
    print("First 3 rows:")
    print(df.head(3).to_string())
except Exception as e:
    print(f"Error reading Excel file: {e}")
