# Guide des dépendances - package.general

## 🤔 Pourquoi les dépendances ne se chargent pas automatiquement ?

### **C'est normal et souhaitable !** ✅

En R, les packages utilisent `Imports` (recommandé) plutôt que `Depends` :

- **`Imports`** : Les packages sont **disponibles** mais pas **chargés** automatiquement
- **`Depends`** : Les packages seraient **chargés automatiquement** (non recommandé)

### **Avantages de `Imports`** :
- ✅ Pas de conflits de noms
- ✅ Performance optimale (mémoire)
- ✅ Évite les dépendances en cascade
- ✅ Standard de l'écosystème R

## 🔧 Comment gérer les dépendances

### **Option 1 : Vérification automatique** (Recommandé)

```r
# Charger le package
library(package.general)

# Vérifier les dépendances
check_dependencies()

# Si des packages manquent, les installer automatiquement
check_dependencies(install_missing = TRUE)
```

### **Option 2 : Installation manuelle**

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

### **Option 3 : Installation à la demande**

Les packages se chargeront automatiquement quand vous utiliserez les fonctions :

```r
library(package.general)

# Cette fonction chargera automatiquement leaflet, sf, dplyr, etc.
carte <- carte_france_simple(mes_donnees, "departement", "population")
```

## 📋 Liste des dépendances

| Package | Usage | Installation |
|---------|-------|--------------|
| `dplyr` | Manipulation de données | `install.packages("dplyr")` |
| `leaflet` | Cartes interactives | `install.packages("leaflet")` |
| `sf` | Données géographiques | `install.packages("sf")` |
| `stringr` | Manipulation de chaînes | `install.packages("stringr")` |
| `viridis` | Palettes de couleurs | `install.packages("viridis")` |
| `htmltools` | Outils HTML | `install.packages("htmltools")` |
| `rlang` | Outils de programmation | `install.packages("rlang")` |

## 🚀 Pour les utilisateurs de votre package

### **Installation complète**
```r
# 1. Installer le package
devtools::install_github("votre-repo/package.general")

# 2. Vérifier les dépendances
library(package.general)
check_dependencies()

# 3. Installer les manquants si nécessaire
check_dependencies(install_missing = TRUE)
```

### **Utilisation normale**
```r
library(package.general)

# Les dépendances se chargent automatiquement quand nécessaire
carte <- carte_france_simple(mes_donnees, "departement", "population")
```

## 🆘 Dépannage

### **Erreur : "package 'X' not found"**
```r
# Solution 1 : Installer le package manquant
install.packages("X")

# Solution 2 : Vérifier toutes les dépendances
library(package.general)
check_dependencies(install_missing = TRUE)
```

### **Erreur : "there is no package called 'package.general'"**
```r
# Le package n'est pas installé
devtools::install_github("votre-repo/package.general")
```

## 💡 Bonnes pratiques

1. **Utilisez `check_dependencies()`** avant de partager votre code
2. **Documentez les prérequis** dans votre README
3. **Testez sur un environnement propre** avant distribution
4. **Gardez `Imports`** dans DESCRIPTION (ne passez pas à `Depends`)

## 🎯 Résumé

- ✅ **Comportement normal** : Les dépendances ne se chargent pas automatiquement
- ✅ **Solution simple** : `check_dependencies(install_missing = TRUE)`
- ✅ **Performance optimale** : Chargement à la demande
- ✅ **Standard R** : Utilisation d'`Imports` recommandée

Votre package suit les **meilleures pratiques R** ! 🎉
