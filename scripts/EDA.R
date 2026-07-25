
# ==============================================================================
# Proyecto final Analisis del INEI
# ==============================================================================
library(dplyr)
library(readr)

df <-read.csv("")

install.packages(c("patchwork", "tidyverse"))

# ==============================================================================
# PASO 3: LIMPIEZA Y PREPARACIÓN DE DATOS
# ==============================================================================

# 1. Cargar librerías necesarias
library(dplyr)
library(readr)

# 2. Cargar base de datos
df_raw <- read.csv("EPEN 2025 BD_Publicacion Dpto_0.csv", encoding = "UTF-8")

# 3. Filtrar, seleccionar y renombrar variables clave
df_clean <- df_raw %>%
  filter(!is.na(ingtrabw), OCUP300 == 1) %>% # Filtrar solo personas ocupadas con ingreso
  select(
    anio = ANIO,
    mes = MES,
    sexo_cod = C207,
    edad = C208,
    area_cod = AREA,
    informal_cod = Informal_P,
    ingreso = ingtrabw,
    horas_semana = whoraT,
    factor_exp = FAC300_ANUAL
  ) %>%
  mutate(
    sexo = case_when(
      sexo_cod == 1 ~ "Hombre",
      sexo_cod == 2 ~ "Mujer"
    ),
    informalidad = case_when(
      informal_cod == 1 ~ "Informal",
      informal_cod == 2 ~ "Formal"
    ),
    area = case_when(
      area_cod == 1 ~ "Urbano",
      area_cod == 2 ~ "Rural"
    )
  )
# ==============================================================================
# PASO 4: ESTADÍSTICAS DESCRIPTIVAS
# ==============================================================================

# 1. Resumen estadístico general del ingreso y horas
resumen_general <- df_clean %>%
  summarise(
    n = n(),
    promedio_ingreso = mean(ingreso, na.rm = TRUE),
    mediana_ingreso  = median(ingreso, na.rm = TRUE),
    sd_ingreso       = sd(ingreso, na.rm = TRUE),
    promedio_horas   = mean(horas_semana, na.rm = TRUE),
    mediana_horas    = median(horas_semana, na.rm = TRUE)
  )

print("--- RESUMEN GENERAL ---")
print(resumen_general)

# 2. Resumen del ingreso agrupado por Condición de Informalidad
resumen_informalidad <- df_clean %>%
  group_by(informalidad) %>%
  summarise(
    n = n(),
    porcentaje = (n() / nrow(df_clean)) * 100,
    promedio_ingreso = mean(ingreso, na.rm = TRUE),
    mediana_ingreso  = median(ingreso, na.rm = TRUE),
    sd_ingreso       = sd(ingreso, na.rm = TRUE)
  )

print("--- RESUMEN POR INFORMALIDAD ---")
print(resumen_informalidad)

# 3. Resumen del ingreso agrupado por Sexo
resumen_sexo <- df_clean %>%
  group_by(sexo) %>%
  summarise(
    n = n(),
    promedio_ingreso = mean(ingreso, na.rm = TRUE),
    mediana_ingreso  = median(ingreso, na.rm = TRUE)
  )

print("--- RESUMEN POR SEXO ---")
print(resumen_sexo)


# ==============================================================================
# PASO 5: VISUALIZACIÓN DE DATOS Y GENERACIÓN DEL COLLAGE
# ==============================================================================

# ==============================================================================
# PASO 5: VISUALIZACIÓN EXPANDIDA (4 GRÁFICOS)
# ==============================================================================

library(ggplot2)
library(patchwork)

# Tema base
mi_tema <- theme_minimal(base_family = "sans") +
  theme(
    plot.title = element_text(face = "bold", size = 10, color = "black"),
    axis.title = element_text(face = "bold", size = 8.5),
    axis.text = element_text(size = 8),
    legend.title = element_text(face = "bold", size = 8),
    legend.position = "top"
  )

# Gráfico 1: Boxplot de Ingreso según Formalidad
g1 <- ggplot(df_clean, aes(x = informalidad, y = ingreso, fill = informalidad)) +
  geom_boxplot(alpha = 0.8, outlier.color = "red") +
  scale_fill_manual(values = c("Formal" = "blue", "Informal" = "pink")) +
  labs(
    title = "1. Distribución del Ingreso por Formalidad",
    x = "Condición Laboral",
    y = "Ingreso Mensual (S/.)"
  ) +
  mi_tema +
  theme(legend.position = "none")

# Gráfico 2: Scatterplot Horas vs Ingreso por Sexo
g2 <- ggplot(df_clean, aes(x = horas_semana, y = ingreso, color = sexo)) +
  geom_point(size = 2, alpha = 0.8) +
  scale_color_manual(values = c("Hombre" = "blue", "Mujer" = "orange")) +
  labs(
    title = "2. Horas Trabajadas vs. Ingreso por Sexo",
    x = "Horas Trabajadas / Semana",
    y = "Ingreso Mensual (S/.)",
    color = "Sexo:"
  ) +
  mi_tema

# Gráfico 3: Barras de Formalidad agrupadas por Sexo
g3 <- ggplot(df_clean, aes(x = sexo, fill = informalidad)) +
  geom_bar(position = "dodge", alpha = 0.85) +
  scale_fill_manual(values = c("Formal" = "blue", "Informal" = "red")) +
  labs(
    title = "3. Composición de Empleo por Sexo",
    x = "Sexo",
    y = "Cantidad de Ocupados",
    fill = "Condición:"
  ) +
  mi_tema

# Gráfico 4: Densidad de Edad por Formalidad
g4 <- ggplot(df_clean, aes(x = edad, fill = informalidad)) +
  geom_density(alpha = 0.4) +
  scale_fill_manual(values = c("Formal" = "green", "Informal" = "orange")) +
  labs(
    title = "4. Distribución de Edad por Formalidad",
    x = "Edad (Años)",
    y = "Densidad",
    fill = "Condición:"
  ) +
  mi_tema

# Unir los 4 gráficos en formato 2x2
collage_4 <- (g1 | g2) / (g3 | g4)

# Guardar collage actualizado
ggsave(
  filename = "figures/collage_graficos.png", 
  plot = collage_4, 
  width = 11, 
  height = 8, 
  dpi = 300
)

print("¡Nuevo collage de 4 gráficos guardado en figures/collage_graficos.png!")




