# test_zoom_fond.R

# Charger le package
library(devtools)
load_all()

# Données d'exemple
data_test <- data.frame(
  departement = c("01", "02", "03", "04", "05", "971", "974"),
  population = c(650000, 540000, 350000, 170000, 150000, 400000, 800000)
)

cat("=== Test des nouveaux fonds de carte et zoom ===\n")

# Test 1: Carte métropole avec fond CartoDB
cat("\nTest 1: France métropolitaine avec fond CartoDB\n")
tryCatch({
  carte_metro_cartodb <- carte_france_simple(
    data_test, 
    "departement", 
    "population", 
    "Population (métropole)", 
    include_dom = FALSE, 
    fond_carte = "CartoDB"
  )
  print(carte_metro_cartodb)
  cat("✓ Carte métropole CartoDB : OK\n")
}, error = function(e) {
  cat("✗ Erreur carte métropole CartoDB :", e$message, "\n")
})

# Test 2: Carte complète avec fond Esri
cat("\nTest 2: France complète avec fond Esri\n")
tryCatch({
  carte_complete_esri <- carte_france_simple(
    data_test, 
    "departement", 
    "population", 
    "Population (complète)", 
    include_dom = TRUE, 
    fond_carte = "Esri"
  )
  print(carte_complete_esri)
  cat("✓ Carte complète Esri : OK\n")
}, error = function(e) {
  cat("✗ Erreur carte complète Esri :", e$message, "\n")
})

# Test 3: Carte avec fond Stamen
cat("\nTest 3: Carte avec fond Stamen\n")
tryCatch({
  carte_stamen <- carte_france_simple(
    data_test, 
    "departement", 
    "population", 
    "Population (Stamen)", 
    include_dom = FALSE, 
    fond_carte = "Stamen"
  )
  print(carte_stamen)
  cat("✓ Carte Stamen : OK\n")
}, error = function(e) {
  cat("✗ Erreur carte Stamen :", e$message, "\n")
})

# Test 4: Fond par défaut (OpenStreetMap)
cat("\nTest 4: Fond par défaut (OpenStreetMap)\n")
tryCatch({
  carte_default <- carte_france_simple(
    data_test, 
    "departement", 
    "population", 
    "Population (défaut)"
  )
  print(carte_default)
  cat("✓ Carte fond par défaut : OK\n")
}, error = function(e) {
  cat("✗ Erreur carte fond par défaut :", e$message, "\n")
})

cat("\n=== Fin des tests ===\n")
cat("Les cartes devraient maintenant avoir un zoom adapté :\n")
cat("- France métropolitaine : zoom niveau 7 (plus proche)\n")
cat("- France complète : zoom niveau 6 (plus large pour voir DOM-TOM)\n")
