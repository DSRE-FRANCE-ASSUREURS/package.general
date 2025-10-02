# Guide d'utilisation - Cartographie de France

## Résumé

Votre shapefile `data-raw/departements-20140306-50m.shp` est maintenant **exporté comme objet du package** et disponible via la fonction `carte_france_simple()`.

## Structure finale

```
package.general/
├── data-raw/
│   └── departements-20140306-50m.shp  # Votre shapefile original
├── data/
│   └── france_departements.rda        # Shapefile exporté du package
├── R/
│   ├── prepare_data.R                 # Script de préparation des données
│   ├── data.R                         # Documentation des données
│   └── carte_france_simple.R          # Fonction de cartographie
└── test_carte_finale.R                # Script de test
```

## Comment utiliser

### 1. Préparer vos données

Votre tableau doit avoir au moins 2 colonnes :
- **Colonne département** : codes comme "01", "2A", "971", etc.
- **Colonne valeur** : nombres à afficher sur la carte

```r
# Exemple de données
mes_donnees <- data.frame(
  departement = c("01", "02", "03", "971", "974"),
  population = c(650000, 540000, 350000, 400000, 800000)
)
```

### 2. Créer la carte

```r
# Charger le package
library(devtools)
load_all()

# Créer la carte
carte <- carte_france_simple(
  data = mes_donnees,
  col_departement = "departement",
  col_valeur = "population",
  titre_legende = "Population",
  include_dom = TRUE  # TRUE pour inclure DOM-TOM, FALSE pour métropole seulement
)

# Afficher la carte
carte
```

### 3. Fonctionnalités

- ✅ **Carte interactive** avec Leaflet
- ✅ **Popups informatifs** au clic
- ✅ **Légende automatique**
- ✅ **Option DOM-TOM** (inclure/exclure)
- ✅ **Codes département flexibles** ("1", "01", "2A", "971", etc.)
- ✅ **Départements sans données** affichés en gris

## Réexécuter la préparation des données

Si vous modifiez le shapefile dans `data-raw/`, relancez :

```r
source("R/prepare_data.R")
```

## Test rapide

```r
source("test_carte_finale.R")
```

## Intégration Shiny

Cette fonction est parfaitement compatible avec Shiny :

```r
# Dans votre app Shiny
output$carte <- renderLeaflet({
  carte_france_simple(data_reactive(), "departement", "valeur")
})
```

## Avantages de cette approche

1. **Données intégrées** : Plus besoin de charger manuellement le shapefile
2. **Performance** : Les données sont pré-chargées dans le package
3. **Simplicité** : Une seule fonction pour créer la carte
4. **Flexibilité** : Support des codes département variés
5. **Robustesse** : Gestion des erreurs et cas particuliers

Votre shapefile est maintenant **parfaitement intégré** dans votre package ! 🗺️
