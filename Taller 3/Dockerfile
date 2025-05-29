#Imagen base:
FROM jupyter/scipy-notebook:latest

#Instalar dependencias del proyecto
RUN pip install pandas numpy scikit-learn matplotlib seaborn

#Directorio de trabajo dentro del contenedor,
WORKDIR /home/jovyan/"Tarea 3"

#Copiar los archivos del proyecto al contenedor,
COPY . .