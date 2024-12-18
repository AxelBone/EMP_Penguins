#####################################################################################

# Affichage des distances évolutives totales calculées, et de différentes statistiques
# sur les arbres de gènes.

#####################################################################################

import sys
import numpy as np
import matplotlib.pyplot as plt

# Lire les valeurs moyennes depuis le fichier
with open(sys.argv[1], 'r') as f:
    mean_lengths = [float(line.strip()) for line in f.readlines() if float(line.strip()) >= 0]

# Calculer un résumé statistique
n = len(mean_lengths)
mean = sum(mean_lengths) / n
print("Nombre de valeurs : ", n)
print("Moyenne globale : ", mean)

# Calcul des percentiles pour les valeurs extrêmes (1%, 5%, 10%)
percentiles = [1, 5, 10]
extreme_values_left = {p: np.percentile(mean_lengths, p) for p in percentiles}
extreme_values_right = {p: np.percentile(mean_lengths, 100 - p) for p in percentiles}

print("\nValeurs extrêmes à gauche (bas) :")
for p, value in extreme_values_left.items():
    print(f"{p}% : {value}")

print("\nValeurs extrêmes à droite (haut) :")
for p, value in extreme_values_right.items():
    print(f"{p}% : {value}")

# Déterminer le nombre de bins avec la méthode Square Root
sqrt_bins = int(np.sqrt(n))
print(f"\nNombre de bins (méthode Square Root) : {sqrt_bins}")

# Créer l'histogramme
plt.hist(mean_lengths, bins=sqrt_bins, color='blue', edgecolor='black', range=(0, max(mean_lengths)))
plt.xlabel('Longueurs moyennes')
plt.ylabel('Fréquence')
plt.title('Distribution des valeurs moyennes')
plt.grid(True)

# Ajouter les lignes des percentiles sur le graphique
for p in percentiles:
    plt.axvline(x=extreme_values_left[p], color='red', linestyle='--', label=f"{p}% bas")
    plt.axvline(x=extreme_values_right[p], color='green', linestyle='--', label=f"{p}% haut")

plt.legend()

# Sauvegarder l'image dans un fichier
output_image = "distribution_fullDist.png"
plt.savefig(output_image)
print(f"Graphique sauvegardé dans : {output_image}")

