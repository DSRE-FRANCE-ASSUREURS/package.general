#' @importFrom dplyr left_join filter select mutate
#' @importFrom stringr str_pad
#' @importFrom rlang sym
#' @importFrom leaflet colorNumeric leaflet addProviderTiles setView addPolygons labelOptions addLegend highlightOptions
#' @importFrom htmltools HTML
NULL

#' Créer une carte de France des départements
#'
#' Cette fonction crée une carte interactive des départements français
#' en coloriant les départements selon une valeur fournie.
#'
#' @param data Un data.frame avec au moins deux colonnes :
#'   - Une colonne avec les codes département (ex: "01", "2A", "971").
#'   - Une colonne avec les valeurs numériques à afficher.
#' @param col_departement Le nom de la colonne contenant les codes département dans `data`.
#' @param col_valeur Le nom de la colonne contenant les valeurs à cartographier dans `data`.
#' @param titre_legende Le titre de la légende de la carte (par défaut: "Valeur").
#' @param include_dom Logique. Inclure les départements d'outre-mer (par défaut: TRUE).
#' @param fond_carte Type de fond de carte. Options : "OpenStreetMap" (défaut), "CartoDB", "Esri", "CartoDB.Dark"
#'
#' @return Une carte Leaflet interactive.
#' @export
#'
#' @examples
#' \dontrun{
#' # Exemple avec des données fictives
#' data_exemple <- data.frame(
#'   code_insee = c("01", "002", "3", "971", "974"),
#'   valeur_a_afficher = c(100, 250, 150, 500, 300)
#' )
#' carte_france_simple(data_exemple, "code_insee", "valeur_a_afficher", "Ma Valeur")
#' }
carte_france_simple <- function(data, col_departement, col_valeur, titre_legende = "Valeur", include_dom = TRUE, fond_carte = "OpenStreetMap") {
  # Charger les données géographiques du package
  data(france_departements)
  donnees_geo <- france_departements

  # Filtrer les DOM-TOM si include_dom est FALSE
  if (!include_dom) {
    donnees_geo <- donnees_geo %>%
      filter(!(code_insee %in% c("971", "972", "973", "974", "976")))
  }

  # Préparer les données utilisateur
  data_clean <- data %>%
    mutate(!!col_departement := str_pad(!!rlang::sym(col_departement), width = 3, side = "left", pad = "0")) %>%
    select(code_departement = !!sym(col_departement), valeur = !!sym(col_valeur))

  # Joindre les données avec le fond de carte
  carte_avec_donnees <- donnees_geo %>%
    left_join(data_clean, by = c("code_insee" = "code_departement"))

  # Créer la palette de couleurs
  pal <- colorNumeric("viridis", domain = carte_avec_donnees$valeur, na.color = "grey")

  # Créer les labels pour les popups
  labels <- paste0(
    "<strong>Département ", carte_avec_donnees$code_insee, "</strong><br/>",
    titre_legende, ": ",
    ifelse(is.na(carte_avec_donnees$valeur),
           "Données non disponibles",
           format(carte_avec_donnees$valeur, big.mark = " "))
  ) %>%
    lapply(htmltools::HTML)

  # Sélectionner le fond de carte
  fond_tiles <- switch(fond_carte,
    "OpenStreetMap" = "OpenStreetMap",
    "CartoDB" = "CartoDB.Positron",
    "Esri" = "Esri.WorldStreetMap", 
    "CartoDB.Dark" = "CartoDB.DarkMatter",
    "OpenStreetMap"  # défaut
  )

  # Calculer les limites pour le zoom automatique
  if (include_dom) {
    # Zoom pour la France entière (métropole + DOM-TOM)
    center_lat <- 46.5
    center_lng <- 2.0
    zoom_level <- 6
  } else {
    # Zoom pour la France métropolitaine seulement
    center_lat <- 46.5
    center_lng <- 2.0
    zoom_level <- 7
  }

  # Créer la carte Leaflet
  carte <- leaflet(carte_avec_donnees) %>%
    addProviderTiles(fond_tiles) %>%
    setView(lng = center_lng, lat = center_lat, zoom = zoom_level) %>%
    addPolygons(
      fillColor = ~pal(valeur),
      weight = 1,
      opacity = 1,
      color = "white",
      fillOpacity = 0.7,
      highlightOptions = highlightOptions(
        weight = 2,
        color = "#666",
        fillOpacity = 0.7,
        bringToFront = TRUE
      ),
      label = labels,
      labelOptions = labelOptions(
        style = list("font-weight" = "normal", padding = "3px 8px"),
        textsize = "15px",
        direction = "auto"
      )
    ) %>%
    addLegend(pal = pal, values = ~valeur, opacity = 0.7, title = titre_legende)

  return(carte)
}
