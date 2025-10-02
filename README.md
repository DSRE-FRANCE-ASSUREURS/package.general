# package.general

Fonctions d'intérêt collectif pour FA : manipulation de données, création de cartes, etc.

## 📦 Installation

```r
# Installer le package
devtools::install_github("votre-repo/package.general")

# OU si développement local
devtools::install(".")
```

## 🔧 Prérequis

Ce package utilise plusieurs dépendances. Installez-les si nécessaire :

```r
# Installer toutes les dépendances en une fois
install.packages(c(
  "dplyr",      # Manipulation de données
  "leaflet",    # Cartes interactives
  "sf",         # Données géographiques
  "stringr",    # Manipulation de chaînes
  "viridis",    # Palettes de couleurs
  "htmltools",  # Outils HTML
  "rlang"       # Outils de programmation
))
```

## 🗺️ Utilisation - Cartographie

```r
# Charger le package
library(package.general)

# Créer une carte de France
data_exemple <- data.frame(
  departement = c("01", "02", "03", "971", "974"),
  population = c(650000, 540000, 350000, 400000, 800000)
)

carte <- carte_france_simple(
  data_exemple, 
  "departement", 
  "population", 
  "Population",
  fond_carte = "CartoDB"
)

carte
```

## 📚 Fonctions disponibles

- `carte_france_simple()` : Créer des cartes interactives de France
- `france_departements` : Données géographiques des départements

## 🆘 Dépannage

Si vous rencontrez des erreurs comme "package 'X' not found" :

1. Installez le package manquant : `install.packages("X")`
2. Ou installez toutes les dépendances : `install.packages(c("dplyr", "leaflet", "sf", "stringr", "viridis", "htmltools", "rlang"))`
