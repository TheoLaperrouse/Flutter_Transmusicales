# MMM Project :

## Accès JSON : 

Via la fonction getDataFromJson() dans TransData.dart
List<TransData> transData = await getDataFromJson();

### Récupérer un Objet :
```dart 
transData[0]
```

### Récupérer le nom de l'artiste : 
```dart 
transData[0].fields.artistes;
```
AutoComplétion pour voir les autres paramètres, quelques-un intéressant: 
- **1ere_salle** : Scène (String) (pareil avec 2ème,3ème...)
- **artistes** : Nom de l'artiste (String)
- **origine_pays1** : Pays d'origine (String)
- **edition** : Edition des transmusicales (String)
- **annee** : Année de l'édition (Integer)
- **spotify/deezer** : Lien pour deezer et spotify avec idAlbum (String)

### La boucle forEach :
```dart 
transData.forEach((groupe) => print(groupe.fields.artistes));
```

Pour les liens spotify
transData.forEach((groupe) => print(groupe.fields.spotify));

### Icones

https://fontawesome.com/icons?d=gallery&q=map

## Architecture Application : 

Données :
- En local, le fichier transData pour accès aux données.
- Sur Firebase, les pages d'artistes avec infos et notes.

Pages : 
- Page Accueil (Inscription/Connexion)
- Page Recherche ?
- Page Artiste avec lien Spotify, moyenne des notes et votes + commentaires
- Page Map avec Google Map et données interactives
- Page 

## Configuration :

### Android Studio :
- Jdk : 11
- Flutter : 52

### Emulateur : 
- Téléphone : Pixel_3a_API_30
- SDK : 30

### Compte Google (Firebase : [lien](https://console.firebase.google.com/project/mmmtrans-3f45f/overview)):

Config Firebase : 

| IdArtiste | Total Notes  | Nombre de Notes |
| --------- | ------------ | --------------- |
| Text      | Text         | Text            |

Une table Commentaire
et une table pour la moyenne des notes


firebase_core: ^0.5.0
cloud_firestore: ^0.14.3+1


Dans le main du main
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();


## JSON : 

Récupération des données des Transmusicales

Utilisation de l'open Data : [OpenData](https://data.rennesmetropole.fr/explore/dataset/datamix-europe-transmusicales/export/)

C'est un Array d'objet JSON. 

Chaque objet est constitué de plusieurs champs

Données dans "fields" : 
- 1ere_salle : Scène (String) (pareil avec 2ème,3ème...)
- artistes : Nom de l'artiste (String)
- origine_pays1 : Pays d'origine (String)
- edition : Edition des transmusicales (String)
- annee : Année de l'édition (Integer)
- spotify/deezer : Lien pour deezer et spotify avec idAlbum (String)

Données dans "geometry" : 
"coordinates" : points avec Coordonnées Longitude/Latitude (Paire de valeur(Tableau))
*Utilisation pour la carte Interactive*

## Carte Interactive : 

Google map simple avec les données géométriques : 

Bien détaillé ici :
https://homework.family/google-map-dans-flutter/

## Deezer/Spotify :

Librairies intéressantes : 

Spotify SDK : (https://pub.dev/packages/spotify_sdk)
1°) Install : Add spotify_sdk as a dependency in your pubspec.yaml file.
2°) Setup : Aller sur le lien.
3°) Fonction play en ajoutant l'idAlbum disponible dans le json en paramètre

Deezer SDK : https://developers.deezer.com/guidelines/getting_started

## Consignes présentation

Les soutenances MMM sont prévues le Vendredi 5 Février à 14h15. 5 groupes à passer, dans l'ordre (A à E), soit 15/20mn par groupe.
Pour chaque groupe :
	
une présentation de 10mn avec des slides. Cela comporte : Choix des Techno, Architecture du projet (quels composants, quels liens entre les composants, local, distant, etc), Librairies spécifiques (si c'est le cas), Fonctionnalité supplémentaire (si c'est le cas). Difficultés rencontrées.
	une démo live de 2 à 4 mn. Soit par émulateur, soit par stream de votre téléphone.
	des questions/réponses par Jean-Baptiste et moi-même.

Pour la présentation : un des étudiants pourra streamer les slides et vous parlez tour à tour. Une autre option est préparer une vidéo en amont. Dans le deux cas, merci de partager ces éléménts 30mn avant le début de la session sur ce channel.
Pour la démo : un des étudiants (avec une bonne connexion réseau) stream son device ou l'émulateur / la console firebase pour illustrer les fonctionnalités. D'autres étudiants peuvent modifier les données entre temps (pour voir les changements, eg ajout de parcours).
Pour les questions: vous pouvez aussi poser des questions à vos camarades.
 
N'hésitez pas à animer le channel pendant la présentation (questions/ remarques /retours).
Bonne préparation à tous.
