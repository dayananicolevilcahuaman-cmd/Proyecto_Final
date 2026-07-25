# ==============================================================================
# Proyecto final Analisis del INEI
# ==============================================================================

# 1. Cargar librerías necesarias
library(dplyr)
library(readr)
library(ggplot2)
library(patchwork)

# ==============================================================================
# PASO 3: LIMPIEZA Y PREPARACIÓN DE DATOS
# ==============================================================================

# 1. Cargar base de datos
df_raw <- read.csv("EPEN 2025 BD_Publicacion Dpto_0.csv", encoding = "UTF-8")

# 2. Filtrar, seleccionar y renombrar variables clave
df_clean <- df_raw %>%
  filter(!is.na(ingtrabw), OCUP300 == 1, whoraT > 0) %>% # Filtrar personas ocupadas con ingreso y horas válidas
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
    ),
    # Ingreso por hora efectiva trabajada (S/./hora)
    ingreso_hora = ingreso / (horas_semana * 4.2)
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

print(resumen_informalidad)

# 3. Resumen del ingreso agrupado por Sexo
resumen_sexo <- df_clean %>%
  group_by(sexo) %>%
  summarise(
    n = n(),
    promedio_ingreso = mean(ingreso, na.rm = TRUE),
    mediana_ingreso  = median(ingreso, na.rm = TRUE)
  )

print(resumen_sexo)


# ==============================================================================
# PASO 5: VISUALIZACIÓN EXPANDIDA (realice 6 GRÁFICOS)
# ==============================================================================

# Tema base
mi_tema <- theme_minimal(base_family = "sans") +
  theme(
    plot.title = element_text(face = "bold", size = 10, color = "black"),
    plot.subtitle = element_text(size = 8, color = "gray30"),
    axis.title = element_text(face = "bold", size = 8.5, color = "black"),
    axis.text = element_text(size = 8),
    legend.title = element_text(face = "bold", size = 8),
    legend.position = "top",
    panel.grid.minor = element_blank()
  )

# Gráfico 1: Boxplot de Ingreso según Formalidad
g1 <- ggplot(df_clean, aes(x = informalidad, y = ingreso, fill = informalidad)) +
  geom_boxplot(alpha = 0.8, outlier.color = "firebrick", outlier.shape = 16) +
  stat_summary(fun = mean, geom = "point", shape = 18, size = 3, color = "black") +
  scale_fill_manual(values = c("Formal" = "royalblue", "Informal" = "firebrick")) +
  labs(
    title = "1. Distribución del Ingreso por Formalidad",
    subtitle = "Rombo negro = promedio general",
    x = "Condición Laboral",
    y = "Ingreso Mensual (S/.)"
  ) +
  mi_tema +
  theme(legend.position = "none")

# Gráfico 2: Scatterplot Horas vs Ingreso por Sexo
g2 <- ggplot(df_clean, aes(x = horas_semana, y = ingreso, color = sexo)) +
  geom_point(size = 2.2, alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE, linetype = "dashed", linewidth = 0.8) +
  scale_color_manual(values = c("Hombre" = "dodgerblue", "Mujer" = "darkorange")) +
  labs(
    title = "2. Horas Trabajadas vs. Ingreso por Sexo",
    subtitle = "Línea punteada representa el ajuste lineal",
    x = "Horas Trabajadas / Semana",
    y = "Ingreso Mensual (S/.)",
    color = "Sexo:"
  ) +
  mi_tema

# Gráfico 3: Barras agrupadas por Cantidad de Ocupados (DODGE)
g3 <- ggplot(df_clean, aes(x = sexo, fill = informalidad)) +
  geom_bar(position = "dodge", alpha = 0.85) +
  scale_fill_manual(values = c("Formal" = "royalblue", "Informal" = "firebrick")) +
  labs(
    title = "3. Composición de Empleo por Sexo",
    subtitle = "Número absoluto de personas ocupadas",
    x = "Sexo",
    y = "Cantidad de Ocupados",
    fill = "Condición:"
  ) +
  mi_tema

# Gráfico 4: Densidad de Edad por Formalidad
g4 <- ggplot(df_clean, aes(x = edad, fill = informalidad)) +
  geom_density(alpha = 0.4) +
  scale_fill_manual(values = c("Formal" = "forestgreen", "Informal" = "darkorange")) +
  labs(
    title = "4. Distribución de Edad por Formalidad",
    subtitle = "Estimación de densidad de frecuencia",
    x = "Edad (Años)",
    y = "Densidad",
    fill = "Condición:"
  ) +
  mi_tema

# Gráfico 5: Violín del Ingreso por Hora Trabajada
g5 <- ggplot(df_clean, aes(x = informalidad, y = ingreso_hora, fill = informalidad)) +
  geom_violin(alpha = 0.5, trim = FALSE) +
  geom_jitter(width = 0.1, size = 1.5, alpha = 0.6, aes(color = informalidad)) +
  scale_fill_manual(values = c("Formal" = "royalblue", "Informal" = "firebrick")) +
  scale_color_manual(values = c("Formal" = "royalblue", "Informal" = "firebrick")) +
  labs(
    title = "5. Ingreso por Hora Efectiva Trabajada",
    subtitle = "Tarifa por hora ajustada a la carga laboral (S/./hr)",
    x = "Condición Laboral",
    y = "Ingreso por Hora (S/.)"
  ) +
  mi_tema +
  theme(legend.position = "none")

# Gráfico 6: Distribución del Ingreso por Área Geográfica
g6 <- ggplot(df_clean, aes(x = area, y = ingreso, fill = area)) +
  geom_boxplot(alpha = 0.75, outlier.shape = NA) +
  geom_jitter(width = 0.15, size = 1.5, alpha = 0.5, color = "gray30") +
  scale_fill_manual(values = c("Urbano" = "darkcyan", "Rural" = "darkgoldenrod")) +
  labs(
    title = "6. Ingreso Mensual por Área Geográfica",
    subtitle = "Comparativa entre zona Urbana y Rural",
    x = "Área de Residencia",
    y = "Ingreso Mensual (S/.)"
  ) +
  mi_tema +
  theme(legend.position = "none")

# Unir los 6 gráficos en formato 3x2
collage_6 <- (g1 | g2) / (g3 | g4) / (g5 | g6) +
  plot_annotation(
    title = "Dashboard de Análisis del Mercado Laboral (EPEN 2025 - INEI)",
    theme = theme(plot.title = element_text(face = "bold", size = 13))
  )

# Guardar mi collage
if (!dir.exists("figures")) {
  dir.create("figures")
}

ggsave(
  filename = "figures/collage_graficos.png", 
  plot = collage_6, 
  width = 11, 
  height = 11, 
  dpi = 300
)

print("Nuevo collage con el gráfico 3 corregido guardado en figures/collage_graficos.png")
