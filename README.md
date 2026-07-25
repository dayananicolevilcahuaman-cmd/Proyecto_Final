# Análisis del Mercado Laboral e Informalidad (EPEN 2025 - INEI)

# Descripción del Proyecto
Este proyecto realiza un Análisis Exploratorio de Datos (EDA) 
enfocado en las dinámicas del mercado laboral peruano utilizando microdatos de la 
Encuesta Permanente de Empleo Nacional (EPEN 2025) publicada por el Instituto Nacional de 
Estadística e Informática (INEI). 

# El objetivo 
principal es evaluar la brecha de ingresos, la prevalencia de la informalidad 
laboral y las disparidades socioeconómicas según sexo, edad y área geográfica.

# Hallazgos y Estadísticas Clave
Resumen Macro del Mercado Laboral
Muestra analizada:74 ocupados con ingresos y horas reportadas.
Ingreso mensual promedio:S/. 1,648.77 (Mediana: S/. 1,328.50).
Carga horaria media:45.8 horas a la semana (Mediana: 48 horas).

# Estructura de Informalidad Laboral
Tasa de Informalidad: 68.9% de los trabajadores pertenecen al sector informal.
Sector Formal:31.1%
Brecha Salarial por Formalidad:
Trabajadores Formales: S/. 2,568.20/ mes en promedio.
Trabajadores Informales: S/. 1,234.00/ mes en promedio.
Los trabajadores formales perciben en promedio un 108% más de ingresos que los informales.

# Brecha de Género
Hombres: Ingreso promedio de S/. 1,671.00 (Mediana: S/. 1,450.00).
Mujeres: Ingreso promedio de S/. 1,608.00 (Mediana: S/. 1,296.00).

# Resumen Visual de los Paneles:
1. Distribución de Ingresos: Comparativa boxplot entre empleo formal e informal.
2. Horas vs. Ingreso: Dispersión con ajuste lineal según sexo.
3. Composición de Empleo: Conteo absoluto de ocupación por género y tipo de empleo.
4. Densidad de Edad: Distribución etaria de trabajadores formales e informales.
5. Ingreso por Hora Efectiva: Tarifa horaria ajustada (S/./hora).
6. Brecha Territorial: Ingresos del ámbito Urbano vs. Rural.
Estructura del Repositorio

```text
├── data/
│   └── EPEN 2025 BD_Publicacion Dpto_0.csv   # Microdatos INEI
├── figures/
│   └── collage_graficos.png                  # Dashboard final generado
├── scripts/
│   └── EDA_INEI.R                            # Script principal en R
└── README.md                                 # Documentación del proyecto
