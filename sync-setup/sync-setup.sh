#!/bin/bash

# Variables
BREWFILE="$HOME/dotfiles/sync-setup/Brewfile"
REQFILE="$HOME/dotfiles/sync-setup/requirements.txt"

# Fonction : Synchroniser Homebrew
sync_brew() {
	echo "Synchronisation Homebrew..."

	# Sauvegarder l'état actuel des packages installés
	brew bundle dump --file="$BREWFILE.tmp" --force

	# Comparer avec le fichier existant
	if ! diff -q "$BREWFILE" "$BREWFILE.tmp" >/dev/null; then
		echo "Mise à jour détectée dans les packages Homebrew."

		# Choisir la version à garder
		echo "Fusion des changements..."
		mv "$BREWFILE.tmp" "$BREWFILE"

		# Installer les nouveaux packages
		echo "Installation des packages manquants..."
		brew bundle --file="$BREWFILE"
	else
		echo "Aucune mise à jour pour Homebrew."
		rm "$BREWFILE.tmp"
	fi
}

# Fonction : Synchroniser les packages Python
sync_python() {
	echo "Synchronisation des packages Python..."

	# Sauvegarder l'état actuel des packages installés
	pip freeze >"$REQFILE.tmp"

	# Comparer avec le fichier existant
	if ! diff -q "$REQFILE" "$REQFILE.tmp" >/dev/null; then
		echo "Mise à jour détectée dans les packages Python."

		# Choisir la version à garder
		echo "Fusion des changements..."
		mv "$REQFILE.tmp" "$REQFILE"

		# Installer les nouveaux packages
		echo "Installation des packages manquants..."
		pip install -r "$REQFILE"
	else
		echo "Aucune mise à jour pour Python."
		rm "$REQFILE.tmp"
	fi
}

# Exécution
sync_brew
sync_python

echo "Synchronisation terminée."
