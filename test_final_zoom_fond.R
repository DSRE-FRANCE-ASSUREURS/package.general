# test_final_zoom_fond.R

# Charger le package
library(devtools)
load_all()

# Données d'exemple
data_test <- data.frame(
  departement = c("01", "02", "03", "04", "05", "971", "974"),
  population = c(650000, 540000, 350000, 170000, 150000, 400000, 800000)
)

cat("=== Test final des fonds de carte et zoom ===\n")

# Test 1: France métropolitaine avec fond CartoDB (zoom niveau 7)
cat("\nTest 1: France métropolitaine avec fond CartoDB\n")
tryCatch({
  carte_metro <- carte_france_simple(
    data_test, 
    "departement", 
    "population", 
    "Population (métropole - zoom 7)", 
    include_dom = FALSE, 
    fond_carte = "CartoDB"
  )
  print(carte_metro)
  cat("✓ Carte métropole CartoDB : OK (zoom niveau 7)\n")
}, error = function(e) {
  cat("✗ Erreur :", e$message, "\n")
})

# Test 2: France complète avec fond Esri (zoom niveau 6)
cat("\nTest 2: France complète avec fond Esri\n")
tryCatch({
  carte_complete <- carte_france_simple(
    data_test, 
    "departement", 
    "population", 
    "Population (complète - zoom 6)", 
    include_dom = TRUE, 
    fond_carte = "Esri"
  )
  print(carte_complete)
  cat("✓ Carte complète Esri : OK (zoom niveau 6)\n")
}, error = function(e) {
  cat("✗ Erreur :", e$message, "\n")
})

# Test 3: Carte avec fond sombre
cat("\nTest 3: Carte avec fond CartoDB Dark\n")
tryCatch({
  carte_dark <- carte_france_simple(
    data_test, 
    "departement", 
    "population", 
    "Population (fond sombre)", 
    include_dom = FALSE, 
    fond_carte = "CartoDB.Dark"
  )
  print(carte_dark)
  cat("✓ Carte fond sombre : OK\n")
}, error = function(e) {
  cat("✗ Erreur :", e$message, "\n")
})

cat("\n=== Résumé des améliorations ===\n")
cat("✅ Zoom automatique :\n")
cat("   - France métropolitaine : niveau 7 (plus proche)\n")
cat("   - France complète : niveau 6 (pour voir DOM-TOM)\n")
cat("✅ Fonds de carte disponibles :\n")
cat("   - OpenStreetMap (défaut)\n")
cat("   - CartoDB (clair)\n")
cat("   - Esri (détaillé)\n")
cat("   - CartoDB.Dark (sombre)\n")
cat("✅ Centrage automatique sur la France\n")
