#' Préparer les données géographiques pour le package
#'
#' Ce script charge le shapefile depuis data-raw et le sauvegarde dans data/
#' pour qu'il soit disponible comme objet du package.

library(sf)
library(usethis)

# Charger le shapefile depuis data-raw
france_departements <- st_read("data-raw/departements-20140306-50m.shp")

# Normaliser les codes département pour qu'ils soient cohérents
# Gérer tous les cas possibles
normaliser_code <- function(code) {
  if (is.na(code)) return(NA_character_)
  code <- as.character(code)
  
  # Cas spéciaux
  if (code %in% c("2A", "2B")) return(code)
  
  # Convertir en numérique puis formater
  code_num <- suppressWarnings(as.numeric(code))
  if (!is.na(code_num)) {
    return(sprintf("%03d", code_num))
  }
  
  # Si ce n'est pas numérique, garder tel quel
  return(code)
}

france_departements$code_insee <- sapply(france_departements$code_insee, normaliser_code)

# Ajouter quelques colonnes utiles
france_departements$REGION_AGR <- "FRANCEMETRO"
france_departements$REGION_AGR[france_departements$code_insee == "971"] <- "971"  # Guadeloupe
france_departements$REGION_AGR[france_departements$code_insee == "972"] <- "972"  # Martinique
france_departements$REGION_AGR[france_departements$code_insee == "973"] <- "973"  # Guyane
france_departements$REGION_AGR[france_departements$code_insee == "974"] <- "974"  # La Réunion
france_departements$REGION_AGR[france_departements$code_insee == "976"] <- "976"  # Mayotte

# Sauvegarder dans le répertoire data/
usethis::use_data(france_departements, overwrite = TRUE)

cat("✓ Données géographiques sauvegardées dans data/france_departements.rda\n")
cat("  - Nombre de départements :", nrow(france_departements), "\n")
cat("  - Colonnes disponibles :", paste(names(france_departements), collapse = ", "), "\n")
