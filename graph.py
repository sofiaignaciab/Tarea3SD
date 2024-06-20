import pandas as pd
import matplotlib.pyplot as plt
import glob
import os

# Función para cargar datos desde múltiples archivos en un directorio, ignorando archivos .crc y archivos vacíos
def load_data_from_directory(directory):
    files = glob.glob(os.path.join(directory, 'part-r-*'))
    dataframes = []
    for f in files:
        if not f.endswith('.crc'):
            try:
                df = pd.read_csv(f, header=None)
                if not df.empty:
                    dataframes.append(df)
            except pd.errors.EmptyDataError:
                print(f"Skipping empty file: {f}")
    return pd.concat(dataframes, ignore_index=True) if dataframes else pd.DataFrame()

# Directorio base de los archivos de salida
base_dir = 'output'

# Directorios completos de los archivos
directories = {
    "data_total": os.path.join(base_dir, "data_total"),
    "frequency": os.path.join(base_dir, "frequency"),
    "relation_taken": os.path.join(base_dir, "relation_taken"),
    "taken_proportion": os.path.join(base_dir, "taken_proportion")
}

# Cargar datos
data_total = load_data_from_directory(directories["data_total"])
if not data_total.empty:
    data_total.columns = ['total']

frequency = load_data_from_directory(directories["frequency"])
if not frequency.empty:
    frequency.columns = ['branch_type', 'frequency']

relation_taken = load_data_from_directory(directories["relation_taken"])
if not relation_taken.empty:
    relation_taken.columns = ['branch_type', 'taken', 'count']

taken_proportion = load_data_from_directory(directories["taken_proportion"])
if not taken_proportion.empty:
    taken_proportion.columns = ['branch_type', 'proportion']

# Gráfico de barras del número total de registros
if not data_total.empty:
    plt.figure(figsize=(6, 4))
    plt.bar(['Total Records'], data_total['total'])
    plt.title('Total Number of Records')
    plt.ylabel('Count')
    plt.show()

# Gráfico de barras de la frecuencia de cada tipo de branch
if not frequency.empty:
    plt.figure(figsize=(10, 6))
    frequency.plot(kind='bar', x='branch_type', y='frequency', legend=False, title='Frequency of Branch Types')
    plt.xlabel('Branch Type')
    plt.ylabel('Frequency')
    plt.show()

# Gráfico de barras de la relación entre tipos de branch y el valor de 'taken'
if not relation_taken.empty:
    relation_pivot = relation_taken.pivot(index='branch_type', columns='taken', values='count')
    relation_pivot.plot(kind='bar', stacked=True, figsize=(10, 6), title='Branch Type and Taken Relation')
    plt.xlabel('Branch Type')
    plt.ylabel('Count')
    plt.show()

# Gráfico de barras de la proporción de registros con 'taken' igual a 1 para cada tipo de branch
if not taken_proportion.empty:
    plt.figure(figsize=(10, 6))
    taken_proportion.plot(kind='bar', x='branch_type', y='proportion', legend=False, title='Proportion of Taken=1 by Branch Type')
    plt.xlabel('Branch Type')
    plt.ylabel('Proportion')
    plt.show()

# Histograma de la columna 'taken'
if not relation_taken.empty:
    plt.figure(figsize=(10, 6))
    plt.hist(relation_taken['taken'], bins=2, edgecolor='k', alpha=0.7)
    plt.title('Histogram of Taken')
    plt.xlabel('Taken')
    plt.ylabel('Frequency')
    plt.xticks([0, 1])
    plt.show()

# Gráfico de dispersión (scatter plot) de 'branch_type' vs. 'taken'
if not relation_taken.empty:
    plt.figure(figsize=(10, 6))
    plt.scatter(relation_taken['branch_type'], relation_taken['taken'], alpha=0.6)
    plt.title('Scatter Plot of Branch Type vs. Taken')
    plt.xlabel('Branch Type')
    plt.ylabel('Taken')
    plt.show()