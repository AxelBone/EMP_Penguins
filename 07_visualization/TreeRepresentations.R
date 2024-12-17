library(ape)
library(Biostrings)
library(ggtree)
library(tidytree)
library(tidyverse)




nwk <- "Results/06_superApproach/superMatrix_cleaned.fa.contree"

tree <- read.tree(nwk)

tree <- root(tree, outgroup = c("phoca_vitulina", "eublepharis_macularius"), resolve.root = TRUE)


tip_names <- c("phoca_vitulina" = "Phoca vitulina (Carnivora)",
               "eublepharis_macularius" = "Eublepharis macularius (Squamata)",
               "balearica_regulorum" = "Balearica regulorum (Gruiformes)",   # Remplacez "leaf1" par vos noms réels
               "charadrius_vociferus" = "Charadrius vociferus (Charadriiformes)",
               "chauna_torquata" = "Chauna torquata (Anseriformes)",
               "opisthocomus_hoazin" = "Opisthocomus hoazin (Opisthocomiformes)",
               "eurypyga_helias" = "Eurypyga helias (Eurypygiformes)",
               "phaethon_lepturus" = "Phaethon lepturus (Phaethontiformes)",
               "gavia_stellata" = "Gavia stellata (Gaviiformes)",
               "pelecanus_crispus" = "Pelecanus crispus (Pelecaniformes)",
               "pygoscelis_adeliae" = "Pygoscelis adeliae (Sphenisciformes)",
               "thalassarche_chlororhynchos" = "Thalassarche chlororhynchos (Procellariiformes)")

old_names = c("phoca_vitulina",
               "eublepharis_macularius",
               "balearica_regulorum",   # Remplacez "leaf1" par vos noms réels
               "charadrius_vociferus",
               "chauna_torquata",
               "opisthocomus_hoazin",
               "eurypyga_helias",
               "phaethon_lepturus",
               "gavia_stellata",
               "pelecanus_crispus",
               "pygoscelis_adeliae",
               "thalassarche_chlororhynchos")

new_names = c("Phoca vitulina (Carnivora)",
             "Eublepharis macularius (Squamata)",
              "Balearica regulorum (Gruiformes)",   # Remplacez "leaf1" par vos noms réels
              "Charadrius vociferus (Charadriiformes)",
              "Chauna torquata (Anseriformes)",
             "Opisthocomus hoazin (Opisthocomiformes)",
              "Eurypyga helias (Eurypygiformes)",
              "Phaethon lepturus (Phaethontiformes)",
              "Gavia stellata (Gaviiformes)",
              "Pelecanus crispus (Pelecaniformes)",
              "Pygoscelis adeliae (Sphenisciformes)",
              "Thalassarche chlororhynchos (Procellariiformes)")

#FOnction pour renommer
rename_tips <- function(phy, old_names, new_names) {
  mpos <- match(old_names, phy$tip.label)  # Utilisez 'tip.label' au lieu de 'tip.labels'
  phy$tip.label[mpos] <- new_names           # Remplace les noms des tips
  return(phy)
}


tree_renamed <- rename_tips(tree, old_names, new_names)



p <- ggtree(tree, ladderize = TRUE) + 
  geom_tiplab(size = 3) +              # Ajouter les noms des tips
  theme_tree2() +                      # Style épuré pour le rendu
  xlim(NA, 2) +                        # Ajuster les limites de l'axe des x
  coord_cartesian(xlim = c(0, 0.4)) +  # Ajuster les coordonnées pour zoomer sur une région
  geom_rootedge(color = "red", linetype = "dashed", size = 1.5)  # Ajouter une ligne vers la racine

# Ajouter les valeurs bootstrap si elles existent
if (!is.null(tree$node.label)) {
  p <- p + geom_text2(aes(label = label), hjust = -0.5, size = 3, subset = !isTip)  # Ajouter les valeurs bootstrap
}


sessionInfo()
