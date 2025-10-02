#' Données géographiques des départements français
#'
#' Shapefile des départements français avec les DOM-TOM.
#'
#' @format Un objet sf avec 101 lignes et les colonnes suivantes :
#' \describe{
#'   \item{code_insee}{Code INSEE du département (format 3 caractères)}
#'   \item{nom}{Nom du département}
#'   \item{REGION_AGR}{Région d'appartenance (FRANCEMETRO, 971, 972, 973, 974, 976)}
#'   \item{geometry}{Géométrie des polygones (MULTIPOLYGON)}
#' }
#'
#' @source IGN - Institut national de l'information géographique et forestière
#'
#' @examples
#' \dontrun{
#' # Utiliser les données
#' data(france_departements)
#' plot(sf::st_geometry(france_departements))
#' 
#' # Filtrer la France métropolitaine
#' france_metro <- france_departements[france_departements$REGION_AGR == "FRANCEMETRO", ]
#' plot(sf::st_geometry(france_metro))
#' }
"france_departements"
