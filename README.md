# tl;dr : *Inférence du transfert des voix entre candidats.*


Afin d'analyser les résultats des élections, par exemple les dernières élections présidentielles de 2022 en France, et de mieux comprendre la dynamique des choix de vote entre les différents groupes de population, il peut être utile d'utiliser des outils d'[apprentissage automatique](https://fr.wikipedia.org/wiki/Apprentissage_automatique) pour inférer des structures à première vue cachées dans la masse des données. En particulier, inspiré par cet [article du Monde](https://www.lemonde.fr/les-decodeurs/article/2022/05/04/election-presidentielle-2022-quels-reports-de-voix-entre-les-deux-tours_6124672_4355770.html), on peut se poser la question de savoir *si on peut extraire depuis les données brutes des élections une estimation du report de voix entre les choix de vote au premier tour et ceux qui sont effectués au deuxième tour*.

Pour cela, parmi les outils mathématiques de l'apprentissage automatique, nous allons utiliser des probabilités. Cette théorie va nous permettre d'exprimer le fait que les résultats tels qu'ils sont obtenus peuvent présenter une variabilité mais que celle-ci réelle résulte de préférences de chaque individu dans la population votante. En particulier, on peut considérer que chaque individu va avoir une préférence, graduée entre $0=0\%$ et $1=100\%$ pour chacun des choix (candidats, nul, blanc, abstention) au premier et second tour. Ainsi, les votes effectués vont correspondre à la réalisation de ces préférences. 

Bien sûr, le vote reste secret et on n'a pas accès au vote de chaque individu et encore moins à ses préférences. Mais comme chaque bureau de vote présente des variabilités liées au contexte local et qui fait que cette population locale a une préférence pour certains choix plutôt que d'autres, on peut considérer chaque bureau de vote comme une population individuelle pour lequel nous allons essayer de prédire les résultats du vote au deuxième tour. **En exploitant les irrégularités locales, bureau de vote par bureau de vote, nous allons pouvoir prédire (le mieux possible) le report des votes individuel (de chaque individu tel qu'il passe d'un vote à un autre, par exemple de "Hidalgo" à "Macron").** Nous allons en particulier montrer une prédiction très correcte des données du second tour à partir de ceux du premier, montrant la plausibilité d'une telle hypothèse :

![Prédiction du transfert des voix](https://raw.githubusercontent.com/laurentperrinet/2022-05-04_transfert-des-voix/main/2022-06-06_prediction_transfert-des-voix.png "Prédiction du transfert des voix")


C'est à ma connaissance une contribution originale (jusqu'à ce qu'une bonne âme veuille bien me donner un lien vers une méthode existante similaire qui me permette de correctement la citer...) que nous allons exploiter ici. Cette prédiction, si elle est efficace, peut donner une idée du transfert de vote entre les deux tours qui a lieu en fonction des préférences des votes de chaque individu.

Nous allons dans la suite montrer comment on peut estimer le pourcentage de chances d'exprimer une voix pour un candidat ou pour l'autre en fonction du choix qu'on a exprimé au premier tour:


![Transfert des voix](https://raw.githubusercontent.com/laurentperrinet/2022-05-04_transfert-des-voix/main/2022-06-06_transfert-des-voix.png "Transfert des voix")


Comme on le verra plus bas, ce tableau montre des tendances claires, par exemple que si on a voté "Macron", "Jadot", "Hidalgo" ou "Pécresse" au premier tour, alors on va certainement voter "Macron" au deuxième tour. Ces électeurs se montrent particulièrement consensuel et suivent le « pacte républicain » mise en place pour faire un "barrage" au Front National (en suivant le terme consacré). Il montre aussi que si on a voté "Le Pen" ou "Dupont-Aignan" au premier tour alors on va voter Le Pen au deuxième, un clair vote de suivi.

Connaissant les couleurs politiques d'autres candidats du premier tour, on peut être surpris que les électeurs de "Arthaud", "Roussel", "Lassalle" ou "Poutou" ont majoritairement choisi "Le Pen" au deuxième tour, signifiant alors un rejet du candidat Macron. Les électeurs de Zemmour sont aussi partagés, signifiant un rejet des deux alternatives. **Ce résultat est à prendre avec des pincettes car ces derniers candidats ont obtenu moins de votes et donc que le processus d'inférence est forcément moins précis car il y a moins de données disponibles.** 

## historique:

Par transparence, je donne ici le cheminement pour obtenir le doc final. Les étapes intermédiaires sont disponibles via `git` et visibles par [nbdime](https://nbdime.readthedocs.io/en/latest/) (par exemple avec la commande `nbdiff-web 2022-06-03_transfert-des-voix.ipynb 2022-06-08_transfert-des-voix.ipynb`). N'hésitez pas à poster des questions dans [l'onglet adéquat](https://github.com/laurentperrinet/2022-05-04_transfert-des-voix/issues) pour proposer des améliorations.

* [2022-06-08_transfert-des-voix.ipynb](https://github.com/laurentperrinet/2022-05-04_transfert-des-voix/blob/main/2022-06-08_transfert-des-voix.ipynb) : version quasi finale :-)
* [2022-06-06_transfert-des-voix.ipynb](https://github.com/laurentperrinet/2022-05-04_transfert-des-voix/blob/main/2022-06-06_transfert-des-voix.ipynb) : reprise du texte - test nouveaux meta-paramètres sans grande influence sur les résultats
* [2022-06-03_transfert-des-voix.ipynb](https://github.com/laurentperrinet/2022-05-04_transfert-des-voix/blob/main/2022-06-03_transfert-des-voix.ipynb) : premiers résultats probants avec la bonne normalisation
* [2022-06-02_transfert-des-voix.ipynb](https://github.com/laurentperrinet/2022-05-04_transfert-des-voix/blob/main/2022-06-02_transfert-des-voix.ipynb) : essai un peu "farfelu" de tester la prediction deu second tour à partir du premier...
* [2022-06-01_transfert-des-voix.ipynb](https://github.com/laurentperrinet/2022-05-04_transfert-des-voix/blob/main/2022-06-01_transfert-des-voix.ipynb) : deuxieme chaine de traitement complète sur un subset des colonnes qui a permis d'identifier l'erreur dans l'algorithme (normalisation)
* [2022-05-23_transfert-des-voix.ipynb](https://github.com/laurentperrinet/2022-05-04_transfert-des-voix/blob/main/2022-05-23_transfert-des-voix.ipynb) : première chaine de traitement complète avec des erreurs dans l'algorithme (apprentissage) - premiers diagnostiics complets (scan paramètres)
* [2022-05-04_transfert-des-voix.ipynb](https://github.com/laurentperrinet/2022-05-04_transfert-des-voix/blob/main/2022-05-04_transfert-des-voix.ipynb) : première chaine de traitement complète avec algorithme complet mains pas correct
