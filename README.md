# tl;dr : *Inférence du transfert des voix entre candidats.*

Afin d'analyser les résultats des élections, par exemple les dernières élections présidentielles de 2022 en France, et de mieux comprendre la dynamique des choix de vote entre les différents groupes de population, il peut être utile d'utiliser des outils d'apprentissage automatique pour inférer des données *a priori* cachées dans les données. En particulier, inspiré par cet [article du Monde](https://www.lemonde.fr/les-decodeurs/article/2022/05/04/election-presidentielle-2022-quels-reports-de-voix-entre-les-deux-tours_6124672_4355770.html), on peut se poser la question de savoir si on peut extraire depuis les données brutes des élections une estimation des report de voix entre les choix de vote au premier tour et ceux qui sont effectués au deuxième tour.

Pour cela nous allons utiliser les outils mathématiques de l'apprentissage automatique et en particulier l'utilisation des probabilités. Cette théorie va nous permettre d'exprimer le fait que les résultats telles qu'ils sont obtenus peuvent présenter une variabilité mais que celle-ci réelle résulte de préférence de chaque individu dans la population votante. En particulier, on peut considérer que chaque individu va avoir une préférence pour chacun des candidats au premier et second tour et que les votes effectués vont correspondre à la réalisation de ces préférences (en effet, on ne peut voter que pour un candidat par scrutin). 

Bien sûr on a accès ni au vote de chaque individu et encore moins à ses préférences. Mais comme mais comme chaque bureau de vote présente des variabilité liée au contexte local et qui fait que la population a une préférence pour certains choix plutôt que d'autres, on peut considérer chaque bureau de vote comme une population individuelle pour lequel nous allons essayer de prédire les résultats du vote au deuxième tour. Cette prediction, si elle est efficace, peut donner une idée du transfert de vote entre les deux tours qui a lieu en fonction des préférences des votes de chaque individu.

Ce tableau donne le pourcentage de chances d'exprimer une voix pour un candidat ou pour l'autre en fonction du choix qu'on a exprimé au premier tour:

![](2022-05-04_transfert-des-voix.png)

Il montre des tendances claires, par exemple que si on a voté Macron, Jadot ou Pécresse au premier tour, alors on va certainement voter Macron au deuxième tour. Ses électeurs se montre particulièrement consensuel et suivent le « pacte républicain » mise en place pour faire un barrage au Front National. Il montre aussi que si on a voté Le Pen ou Dupont-Aignan au premier tour alors on va voter Le Pen au deuxième, un clair vote de suivi. (On pourra aussi remarquer les ~ 3 % des voix pour Macron au premier tour qui ont voté Le Pen au deuxième tour, soit tout de même environ 320k individus…)

Ce tableau donne le pourcentage de chances d'exprimer une voix pour un candidat ou pour l'autre en fonction du choix qu'on a exprimé au premier tour. 

Il montre des tendances claires, par exemple que si on a voté Macron, Jadot ou Pécresse au premier tour, alors on va certainement voter Macron au deuxième tour. Ses électeurs se montre particulièrement consensuel et suivent le « pacte républicain » mise en place pour faire un barrage au Front National. Il montre aussi que si on a voté Le Pen ou Dupont-Aignan au premier tour alors on va voter Le Pen au deuxième, un clair vote de suivi. (On pourra aussi remarquer les ~ 3 % des voix pour Macron au premier tour qui ont voté Le Pen au deuxième tour, soit tout de même environ 320k individus…)

Connaissant les couleurs politiques d'autres candidats du premier tour, on peut être surpris que les électeurs de Arthaud, Roussel ou Hidalgo ont majoritairement choisi Le Pen au deuxième tour, signifiant alors un rejet du candidat Macron. Les électeurs de Zemmour sont aussi partagés, signifiant un rejet des deux alternatives. **Ce résultat est à prendre avec des pincettes car ces derniers candidats ont obtenu moins de votes et donc que le processus d'inférence est forcément moins précis car il y a moins de données disponibles.** Pour se rendre compte de la variabilité des résultats qu'on obtient là, je conseille au (é-)lecteur de relancer ces notebook en utilisant différents graines pour le générateur de nombre aléatoire qui permet de séparer les données (le paramètre `seed`).

## historique:

Par transparence, je donne ici le cheminement pour obtenir le doc final. Les étapes intermédiaires sont disponibles via `git` et visibles par [nbdime](https://nbdime.readthedocs.io/en/latest/). N'hésitez pas à poster des questions dans [l'onglet adéquat](https://github.com/laurentperrinet/2022-05-04_transfert-des-voix/issues).

* [2022-06-03_transfert-des-voix.ipynb](https://github.com/laurentperrinet/2022-05-04_transfert-des-voix/blob/main/2022-06-03_transfert-des-voix.ipynb)
* [2022-06-02_transfert-des-voix.ipynb](https://github.com/laurentperrinet/2022-05-04_transfert-des-voix/blob/main/2022-06-02_transfert-des-voix.ipynb) : essai un peu "farfelu" de tester la prediction deu second tour à partir du premier...
* [2022-06-01_transfert-des-voix.ipynb](https://github.com/laurentperrinet/2022-05-04_transfert-des-voix/blob/main/2022-06-01_transfert-des-voix.ipynb) : deuxieme chaine de traitement complète avec des erreurs dans l'algorithme (normalisation) 
* [2022-05-23_transfert-des-voix.ipynb](https://github.com/laurentperrinet/2022-05-04_transfert-des-voix/blob/main/2022-05-23_transfert-des-voix.ipynb) : première chaine de traitement complète avec des erreurs dans l'algorithme (apprentissage) 
* [2022-05-04_transfert-des-voix.ipynb](https://github.com/laurentperrinet/2022-05-04_transfert-des-voix/blob/main/2022-05-04_transfert-des-voix.ipynb) : première chaine de traitement complète avec algorithme inomplet
