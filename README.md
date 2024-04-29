# Pizza Provider

Aquest projecte amb Flutter consisteix en una senzilla aplicació sobre encàrrecs d'una pizzeria, per tal d'exemplificar els següents conceptes:

* El patró Provider, per a la gestió de l'estat
* Crides asíncrones a APIs
* L'ús de la llibrerís Floor per a la persistència

## Creació de l'aplicació i llibreries necessàries

Creem el projecte amb:

```
flutter create pizzaprovider
```

Entrem dins la carpeta creada i instal·lem les llibreríes necessàries:

```
flutter pub add http                    # Per realitzar peticions a l'API
flutter pub add provider                # Per al patró Provider
flutter pub add floor                   # Per a la persistència amb SQLite
# Aquestes llibreries de desenvolupament s'usen per generar codi d'accés a la BD
# per part de Floor (no seran part del projecte, però les necessitem per al generador)
flutter pub add dev:floor-generator     
flutter pub add dev:build_runner
```

## Carpetes de l'aplicació

La carpeta `lib` amb el codi font de l'aplicació s'estructura en les següents carpetes:


```
lib
├── database
│   ├── dao
│   └── entities
├── models
├── providers
├── repository
├── screens
│   └── widgets
└── services
```

On tenim:

* `models`: Conté les classes que representen les dades que utilitzarem a l'aplicació (Pizza, Entrant o Beguda).
* `database`: Conté totes les operacions relacionades amb la base de dades.
* `database/entities`: Conté les classes entitat que utilitzarem amb Floor, i que representaran les taules de la base de dades. Són similars als models, però amb la informació específica a emmagatzemar a la base de dades. Ací és on generarem tot allò relacionat amb la cistella de la compra.
* `database/dao`: Conté les classes DAO (Data Access Object) que utilitzarem amb Floor per interactuar amb la base de dades.
* `services`: Conté la lògica per accedir a les dades a través de serveis web. Ací guardarem les classes per realitzar les peticions de dades al servidor.
* `repository`: Conté les classes de repositori, per tal de proporcionar una capa d'abstracció entre les fontes de dades (com la base de dades Floor o els serveis web) i la resta de l'aplicació.
* `screens`: Representa la capa de la vista, on estan totes les pantalles de l'aplicació.
* `screens/widgets`: Conté els widgets personalitzats que utilitzarem a les pantalles o a altres widgets.





