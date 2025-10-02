#' @keywords internal
"_PACKAGE"

## usethis namespace: start
#' @importFrom magrittr %>%
## usethis namespace: end
NULL

# Message informatif au chargement du package
.onAttach <- function(libname, pkgname) {
  packageStartupMessage(
    "📦 package.general chargé !\n",
    "💡 Pour vérifier les dépendances : check_dependencies()\n",
    "🗺️  Fonction principale : carte_france_simple()\n",
    "📚 Documentation : help(package = 'package.general')"
  )
}
