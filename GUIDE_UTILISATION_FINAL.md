# Guide d'utilisation - Cartographie de France (Version Finale)

## 🎯 Résumé des améliorations

Votre fonction `carte_france_simple()` a été **améliorée** avec :
- ✅ **Zoom automatique** adapté au contenu
- ✅ **Fonds de carte variés** (4 options)
- ✅ **Centrage automatique** sur la France

## 🗺️ Utilisation de base

### 1. Préparer vos données

```r
# Exemple de données
mes_donnees <- data.frame(
  departement = c("01", "02", "03", "971", "974"),
  population = c(650000, 540000, 350000, 400000, 800000)
)
```

### 2. Créer une carte simple

```r
# Charger le package
library(devtools)
load_all()

# Carte de base (fond OpenStreetMap, zoom automatique)
carte <- carte_france_simple(
  data = mes_donnees,
  col_departement = "departement",
  col_valeur = "population",
  titre_legende = "Population"
)

carte
```

## 🎨 Fonds de carte disponibles

### OpenStreetMap (défaut)
```r
carte_france_simple(mes_donnees, "departement", "population", fond_carte = "OpenStreetMap")
```
- **Style** : Classique, détaillé
- **Idéal pour** : Usage général

### CartoDB (clair)
```r
carte_france_simple(mes_donnees, "departement", "population", fond_carte = "CartoDB")
```
- **Style** : Épuré, moderne
- **Idéal pour** : Présentations professionnelles

### Esri (détaillé)
```r
carte_france_simple(mes_donnees, "departement", "population", fond_carte = "Esri")
```
- **Style** : Très détaillé, routier
- **Idéal pour** : Analyses géographiques précises

### CartoDB Dark (sombre)
```r
carte_france_simple(mes_donnees, "departement", "population", fond_carte = "CartoDB.Dark")
```
- **Style** : Sombre, élégant
- **Idéal pour** : Présentations en salle

## 🔍 Gestion du zoom automatique

### France métropolitaine uniquement
```r
carte_metro <- carte_france_simple(
  mes_donnees, 
  "departement", 
  "population", 
  "Population (métropole)",
  include_dom = FALSE,  # Exclut DOM-TOM
  fond_carte = "CartoDB"
)
# → Zoom niveau 7 (plus proche, centré sur la métropole)
```

### France complète (métropole + DOM-TOM)
```r
carte_complete <- carte_france_simple(
  mes_donnees, 
  "departement", 
  "population", 
  "Population (complète)",
  include_dom = TRUE,   # Inclut DOM-TOM
  fond_carte = "Esri"
)
# → Zoom niveau 6 (plus large pour voir DOM-TOM)
```

## 📊 Exemples d'utilisation avancée

### Pour une présentation
```r
carte_presentation <- carte_france_simple(
  mes_donnees,
  "departement", 
  "population",
  "Population par département",
  include_dom = FALSE,
  fond_carte = "CartoDB"
)
```

### Pour une analyse détaillée
```r
carte_analyse <- carte_france_simple(
  mes_donnees,
  "departement", 
  "population", 
  "Données démographiques",
  include_dom = TRUE,
  fond_carte = "Esri"
)
```

### Pour une présentation en salle
```r
carte_salle <- carte_france_simple(
  mes_donnees,
  "departement", 
  "population",
  "Population française",
  include_dom = FALSE,
  fond_carte = "CartoDB.Dark"
)
```

## 🚀 Intégration Shiny

```r
# Dans votre app Shiny
output$carte <- renderLeaflet({
  carte_france_simple(
    data_reactive(), 
    "departement", 
    "population",
    input$titre_legende,
    include_dom = input$include_dom,
    fond_carte = input$fond_carte
  )
})
```

## ✅ Fonctionnalités complètes

- 🗺️ **Shapefile intégré** dans le package
- 🎯 **Zoom automatique** selon le contenu
- 🎨 **4 fonds de carte** différents
- 📍 **Centrage automatique** sur la France
- 🏝️ **Option DOM-TOM** (inclure/exclure)
- 🔢 **Codes département flexibles** ("1", "01", "2A", "971", etc.)
- 💬 **Popups informatifs** au clic
- 📊 **Légende automatique**
- ⚡ **Performance optimisée**

## 🧪 Test rapide

```r
source("test_final_zoom_fond.R")
```

Votre fonction de cartographie est maintenant **parfaitement optimisée** ! 🎉
