# PrevenDiab

## Préparation des données

Cas du sous-groupe (N=144)

Grâce aux scripts 00 (chargement des différentes bases) et 01 (création de variables) --> bases de données à utiliser (fusion tables pheno et biologique)


## Calcul des Scores 

Pour les deux scores, la méthode est présente dans le script 02_PrevenDiab_SCORES_update.rmd

### Score Métabolique

Le calcul du **score Métabolique** se base sur la définition mondiale du syndrome Métabolique de la Fédération internationale du diabète (***the International Diabetes Federation (IDF)***).   


### Score Framingham 

Utilisation du package R suivant : r-framingham (source : [https://github.com/PHP2560-Statistical-Programming-R/r-framingham/blob/mas](https://github.com/PHP2560-Statistical-Programming-R/r-framingham/tree/master))
celui-ci a été téléchargé afin d'en modifier les bornes nécessaires aux calculs du score (voir **échanges et discussions** dans le rapport .html généré à partir du script 02).



