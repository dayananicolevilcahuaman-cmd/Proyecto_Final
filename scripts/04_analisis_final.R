# ==============================================================================
# PROYECTO FINAL - PARTE 2: ANÁLISIS PROFUNDO DE BRECHAS Y PENALIZACIÓN
# Script: 04_analisis_final.R
# ==============================================================================

# 1. Cargar librerías
library(dplyr)
library(readr)
library(ggplot2)

# 2. Cargar y preparar los datos
df_raw <- read.csv("EPEN 2025 BD_Publicacion Dpto_0.csv", encoding = "UTF-8")

df_analisis <- df_raw %>%
  filter(!is.na(ingtrabw), OCUP300 == 1, whoraT > 0) %>%
  select(
    sexo_cod = C207,
    informal_cod = Informal_P,
    ingreso = ingtrabw,
    horas_semana = whoraT
  ) %>%
  mutate(
    sexo = ifelse(sexo_cod == 1, "Hombre", "Mujer"),
    informalidad = ifelse(informal_cod == 1, "Informal", "Formal"),
    ingreso_hora = ingreso / (horas_semana * 4.2),
    grupo_analisis = paste(informalidad, sexo, sep = " - ")
  )

# 3. Tema personalizado para la gráfica
tema_publicacion <- theme_minimal(base_family = "sans") +
  theme(
    plot.title = element_text(face = "bold", size = 12, color = "black"),
    plot.subtitle = element_text(size = 9, color = "gray30", margin = margin(b = 10)),
    plot.caption = element_text(size = 8, color = "gray50", face = "italic"),
    axis.title = element_text(face = "bold", size = 9),
    axis.text = element_text(size = 8.5),
    legend.position = "none",
    panel.grid.minor = element_blank()
  )

# 4. Crear gráfico final
grafico_final <- ggplot(df_analisis, aes(x = grupo_analisis, y = ingreso_hora, fill = informalidad)) +
  geom_boxplot(alpha = 0.75, outlier.color = "firebrick", outlier.alpha = 0.5) +
  stat_summary(fun = median, geom = "point", shape = 18, size = 3.5, color = "black") +
  scale_fill_manual(values = c("Formal" = "red", "Informal" = "pink")) +
  labs(
    title = "¿La informalidad penaliza más a las mujeres?",
    subtitle = "Tarifa por hora trabajada (S/./hr) según condición de empleo y género (EPEN 2025)",
    x = "Condición Laboral y Género",
    y = "Ingreso por Hora (S/.)",
    caption = "Fuente: INEI - Encuesta Permanente de Empleo Nacional (EPEN 2025) | Elaboración propia"
  ) +
  coord_cartesian(ylim = c(0, 35)) +
  tema_publicacion

# 5. Guardar la imagen
if (!dir.exists("figures")) dir.create("figures")

ggsave(
  filename = "figures/grafico_analisis_final.png",
  plot = grafico_final,
  width = 8,
  height = 5,
  dpi = 300)




