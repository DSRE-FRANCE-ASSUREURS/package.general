#' Vérifier et installer les dépendances du package
#'
#' Cette fonction vérifie si toutes les dépendances du package sont installées
#' et propose de les installer si nécessaire.
#'
#' @param install_missing Logique. Installer automatiquement les packages manquants (défaut: FALSE)
#'
#' @return Un data.frame avec le statut de chaque dépendance
#' @export
#'
#' @examples
#' \dontrun{
#' # Vérifier les dépendances
#' check_dependencies()
#' 
#' # Vérifier et installer automatiquement
#' check_dependencies(install_missing = TRUE)
#' }
check_dependencies <- function(install_missing = FALSE) {
  
  # Liste des dépendances
  dependencies <- c(
    "dplyr",      # Manipulation de données
    "leaflet",    # Cartes interactives
    "sf",         # Données géographiques
    "stringr",    # Manipulation de chaînes
    "viridis",    # Palettes de couleurs
    "htmltools",  # Outils HTML
    "rlang"       # Outils de programmation
  )
  
  # Vérifier chaque dépendance
  status <- data.frame(
    Package = dependencies,
    Installed = sapply(dependencies, function(pkg) {
      requireNamespace(pkg, quietly = TRUE)
    }),
    stringsAsFactors = FALSE
  )
  
  # Afficher le statut
  cat("=== Statut des dépendances du package package.general ===\n")
  for (i in seq_len(nrow(status))) {
    pkg <- status$Package[i]
    installed <- status$Installed[i]
    
    if (installed) {
      cat("✓", pkg, "- Installé\n")
    } else {
      cat("✗", pkg, "- MANQUANT\n")
    }
  }
  
  # Proposer d'installer les manquants
  missing_packages <- status$Package[!status$Installed]
  
  if (length(missing_packages) > 0) {
    cat("\n⚠️  Packages manquants :", paste(missing_packages, collapse = ", "), "\n")
    
    if (install_missing) {
      cat("📦 Installation automatique en cours...\n")
      install.packages(missing_packages)
      cat("✅ Installation terminée !\n")
    } else {
      cat("💡 Pour installer automatiquement :\n")
      cat("   check_dependencies(install_missing = TRUE)\n")
      cat("\n💡 Ou installez manuellement :\n")
      cat("   install.packages(c(", paste0('"', missing_packages, '"', collapse = ", "), "))\n")
    }
  } else {
    cat("\n🎉 Toutes les dépendances sont installées !\n")
  }
  
  return(status)
}
