# Análisis del Mercado Laboral e Informalidad (EPEN 2025 - INEI)
# PARTE 1
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
5. Ingreso por Hora Efectiva: Tarifa horaria ajustada (S//hora).
6. Brecha Territorial: Ingresos del ámbito Urbano vs. Rural.
# Estructura del Repositorio

```text
├── data/
│   └── EPEN 2025 BD_Publicacion Dpto_0.csv   # Microdatos INEI
├── figures/
│   └── collage_graficos.png                  # Dashboard final generado
├── scripts/
│   └── EDA_INEI.R                            # Script principal en R
└── README.md                                 # Documentación del proyecto

# Parte 2: Profundización y Conclusiones

# Pregunta de Análisis
¿Existen diferencias en la tarifa por hora efectiva entre hombres y mujeres
cuando se analiza el empleo formal frente al informal?

# Visualización del Análisis Final
[Análisis Final de Brecha por Hora](figures/grafico_analisis_final.png)

# Tablas Estadísticas e Indicadores

# Tabla 1
# Resumen General de Indicadores Laborales por Grupo
| Condición Laboral | Género | Nº Muestra | Carga Horaria (Hrs/Sem) | Ingreso Mensual Mediano (S/.) | Tarifa por Hora Mediana (S/./hr) | Tarifa por Hora Promedio (S/./hr) |
| :--- | :--- | :---: | :---: | :---: | :---: | :---: |
| **Formal** | Hombre | 15 | 42.3 h | S/. 2,070.00 | S/. 11.14 | S/. 14.23 |
| **Formal** | Mujer | 8 | 43.4 h | S/. 2,322.50 | S/. 14.78 | S/. 16.09 |
| **Informal** | Hombre | 33 | 45.4 h | S/. 1,200.00 | S/. 6.18 | S/. 7.53 |
| **Informal** | Mujer | 18 | **50.5 h** | S/. 1,154.00 | **S/. 5.34** | **S/. 5.25** |

# Tabla 2
# Brecha e Impacto de la Informalidad Laboral
| Indicador Clave | Hombres | Mujeres | Penalización / Impacto |
| :--- | :--- | :--- | :--- |
| **Caída del Pago por Hora (Formal vs Informal)** | -47.1% | **-67.4%** | La informalidad castiga con mayor severidad el valor/hora de las mujeres. |
| **Jornada Semanal en Informalidad** | 45.4 hrs | **50.5 hrs** | Las mujeres informales trabajan en promedio **5.1 horas más** por semana. |

# Conclusiones Finales

1. Al pasar del sector formal al informal, la pérdida de valor por hora varía significativamente según el género, por ejemplo los hombres experimentan una disminución del 44.5% en la tarifa mediana (de S/. 11.14 a S/. 6.18/hr), mientras que las mujeres padecen una reducción significativa de su valor/hora mediano, que es del 63.9% (de S/. 14.78 a S/. 5.34/hr) y del 67.4% si se considera el promedio general. Esto evidencia que la informalidad tiene un efecto desvalorizador sobre el trabajo de las mujeres mucho más violento.

2. Las mujeres que trabajan en la informalidad tienen el horario laboral semanal más largo de toda la muestra (50.5 horas a la semana, 5.1 horas más que los hombres del mismo sector), pero su tarifa horaria media es la menor del mercado (S/. 5.25 por hora). Esto muestra que en el sector informal trabajar más horas no logra compensar la desigualdad de ingresos, lo cual crea una situación de extrema vulnerabilidad y precariedad.

4. Los resultados demuestran que, si las estrategias de formalización convencionales no incluyen un enfoque de género, son insuficientes. Es necesario crear políticas enfocadas en: Promover la corresponsabilidad en las labores de cuidado no remuneradas que llevan a las mujeres a aceptar jornadas informales agotadoras. Parámetros de valor por hora efectiva: En los sectores donde la informalidad tiene una alta prevalencia, como el comercio y los servicios, es necesario regular y supervisar la equivalencia salarial por cada hora de trabajo.
