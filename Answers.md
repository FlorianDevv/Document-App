# Environnement de développement

## 1. Pour chaque élément de la liste ci-dessus, vous rédigez un paragraphe expliquant à quoi il sert.
   
- Les targets : Il s'agit d'un emsemble d'insruction de compilation pour génerer une application 

- Les fichiers de bases (fourni par défaut à la création du projet) : Ils servent à amorcer et controller l'application de base (écran vide). Ils fournissent des points d'entrées pour personnaliser l'application

- Le dossier Assets.xcassets : Il s'agit d'un conteneur pour stocker les images de l'application.

- Expliquer ce qu’est le storyboard : C'est un fichier qui permet de personnaliser l'interface de l'application. Il permet aussi de gerer la naviguation entre les différentes pages.

- Expliquer ce qu’est un simulateur : Il permet de visualiser l'application lancée à l'aide d'un emulateur IOS.

## 2. A quoi sert le raccourci Cmd + R ?
Il sert à compilier/lancer l'application

## 3. A quoi sert le raccourci Cmd + Shift + O ?
Il permet d'ouvrir une fenetre avec différentes aides.

## 4. Trouver le raccourci pour indenter le code automatiquement
CMD + i 

## 5. Et celui pour commenter la selection
CMD + /

# Délégation

## 1.Expliquer l’intérêt d’une propriété statique en programmation.
Les propriétés statiques peuvent être utlisées n'importe où dans le code.

## 2. Expliquer pourquoi dequeueReusableCell est important pour les performances de l’application.
dequeueReusableCell sert à réutliser une cellule déja créer pour éviter d'en créer une nouvelle à chaque fois. Cela améliore la performance de l'application car elle évite de créer de nouvelle instance à chaque cellule.

# Ajout de la navigation

## 1. Quel est le rôle du NavigationController ?
Il permet de naviguer entre les différentes pages de l'application.

## 2. Est-ce que la NavigationBar est la même chose que le NavigationController ?
Nan, la naviguation bar est intégré dans l'application et peut être personnaliser.

# Créer l’écran de détail

## 1. Expliquer ce qu’est un Segue et à quoi il sert
Les segues sont des connecteurs visuels entre les contrôleurs de vue dans vos storyboards, représentés par des lignes entre les deux contrôleurs. Il sert à gérer les transitions entre les différentes partie de l'interface utlisateur.

## 2. Qu’est-ce qu’une constraint ? A quoi sert-elle ? Quel est le lien avec AutoLayout ?
Les contraintes servent à gérer le positionnement des images pour pas qu'il ne deppasse de l'ecran par exemple. Il s'accorde avec autoLayout.

#  Exercice 2 - Importer un fichier au runtime

## 1. Expliquez ce qu’est un #selector en Swift
Un #selector est une chaîne de caractères qui représente la signature d'une méthode générique dans une classe.

## 2. Que représente .add dans notre appel ?
Il permet d'ajouter le bouton à la bar de naviguation.

## 3. Expliquez également pourquoi XCode vous demande de mettre le mot clé @objc devant la fonction ciblée par le #selector.
@objc permet de faciliter l'interaction entre Swift et Objective-C

## 4. Peut-on ajouter plusieurs boutons dans la barre de navigation ? Si oui, comment en code ?
Oui on peut comme ceci :
```
let buton1 =  UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addDocument))
let buton2 =  UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(otherthings))
navigationItem.rightBarButtonItem = [buton1,buton2]

```



 




   
