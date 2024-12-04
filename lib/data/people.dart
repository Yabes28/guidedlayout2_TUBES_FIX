class Person{
  final String name ;
  final String age ;
  final String picture;
  const Person(this.name,this.age,this.picture);
}

final List<Person> people =
      _people.map((e) => Person(e['name'] as String, e['phone'] as String,e['picture'] as String)).toList(growable: false);

final List<Map<String,Object>> _people =

[
  {
    "_id": "66fcf877392c93f566feddee",
    "index": 0,
    "guid": "4343b6c8-e5e4-4fd4-ae04-77092ce26c65",
    "isActive": false,
    "balance": "\$2,205.26",
    "picture": "http://placehold.it/32x32",
    "age": 26,
    "eyeColor": "blue",
    "name": "Mccray Norris",
    "gender": "male",
    "company": "NORSUL",
    "email": "mccraynorris@norsul.com",
    "phone": "+1 (869) 470-3088",
    "address": "947 Vermont Court, Allamuchy, Utah, 8146",
    "about": "Eu eu est culpa id aliqua. Nostrud cupidatat minim incididunt sint minim voluptate in sint ad fugiat excepteur. Qui eu sint elit duis. Magna culpa ullamco pariatur aliquip reprehenderit laborum mollit minim sit irure nostrud ex. Laborum proident cupidatat sunt irure aliqua id Lorem duis irure in dolore ipsum labore. In pariatur id adipisicing commodo aliqua voluptate irure amet laboris non incididunt fugiat nostrud. Veniam laborum exercitation ad ad laboris occaecat nisi aute in ullamco exercitation consequat aute ullamco.\r\n",
    "registered": "2021-05-08T06:55:07 -07:00",
    "latitude": -62.068949,
    "longitude": 169.891181,
    "tags": [
      "consequat",
      "velit",
      "consectetur",
      "duis",
      "duis",
      "non",
      "in"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Drake Osborne"
      },
      {
        "id": 1,
        "name": "Lawrence Foreman"
      },
      {
        "id": 2,
        "name": "Mooney Neal"
      }
    ],
    "greeting": "Hello, Mccray Norris! You have 8 unread messages.",
    "favoriteFruit": "banana"
  },
  {
    "_id": "66fcf8777fb9500312af94c4",
    "index": 1,
    "guid": "6b2d6529-b27e-4da4-83ec-a6ec054abd96",
    "isActive": true,
    "balance": "\$2,690.32",
    "picture": "http://placehold.it/32x32",
    "age": 26,
    "eyeColor": "brown",
    "name": "Cherry Wilder",
    "gender": "male",
    "company": "GLASSTEP",
    "email": "cherrywilder@glasstep.com",
    "phone": "+1 (984) 422-2203",
    "address": "672 Essex Street, Iberia, South Dakota, 5494",
    "about": "Ipsum sint magna et sint non aliqua nostrud do qui in pariatur do. Eu culpa ea ipsum elit. Amet laboris cupidatat adipisicing adipisicing ipsum culpa occaecat enim amet adipisicing pariatur. Id labore anim fugiat eiusmod occaecat commodo in occaecat culpa eiusmod exercitation. Fugiat anim elit est elit sit in id veniam qui incididunt occaecat pariatur commodo.\r\n",
    "registered": "2016-06-11T12:17:34 -07:00",
    "latitude": 64.683182,
    "longitude": -6.755923,
    "tags": [
      "proident",
      "qui",
      "laboris",
      "id",
      "dolore",
      "aliqua",
      "cillum"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Therese Mullen"
      },
      {
        "id": 1,
        "name": "Enid Johns"
      },
      {
        "id": 2,
        "name": "Freida Blackburn"
      }
    ],
    "greeting": "Hello, Cherry Wilder! You have 1 unread messages.",
    "favoriteFruit": "apple"
  },
  {
    "_id": "66fcf8775e0e9930e3f66acf",
    "index": 2,
    "guid": "48a9b769-74c4-4973-8f5a-3973bcbb5314",
    "isActive": false,
    "balance": "\$3,023.78",
    "picture": "http://placehold.it/32x32",
    "age": 27,
    "eyeColor": "blue",
    "name": "Mcmillan Tyler",
    "gender": "male",
    "company": "ENTOGROK",
    "email": "mcmillantyler@entogrok.com",
    "phone": "+1 (959) 554-2125",
    "address": "532 Clinton Street, Harborton, North Carolina, 9518",
    "about": "Id dolor eiusmod consequat anim incididunt elit. Dolor aute voluptate exercitation aute ea et tempor eu eiusmod elit non deserunt ut. Minim nisi excepteur in labore reprehenderit dolor ad tempor consectetur. Anim esse officia dolor tempor veniam ipsum magna qui incididunt elit tempor laborum quis reprehenderit. Et incididunt sint anim velit ad. Anim id ipsum elit eiusmod enim enim enim duis. Officia magna nulla pariatur laboris aliquip deserunt mollit culpa mollit nostrud minim esse cillum.\r\n",
    "registered": "2016-03-18T03:18:49 -07:00",
    "latitude": -53.886521,
    "longitude": 67.024869,
    "tags": [
      "duis",
      "consectetur",
      "incididunt",
      "aliquip",
      "ad",
      "sunt",
      "ea"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Lara Moore"
      },
      {
        "id": 1,
        "name": "Parker Sims"
      },
      {
        "id": 2,
        "name": "Diann Hunt"
      }
    ],
    "greeting": "Hello, Mcmillan Tyler! You have 10 unread messages.",
    "favoriteFruit": "apple"
  },
  {
    "_id": "66fcf8779d0768b2e37144f0",
    "index": 3,
    "guid": "874e685c-e69d-4e1c-98ee-82275f297376",
    "isActive": false,
    "balance": "\$3,519.16",
    "picture": "http://placehold.it/32x32",
    "age": 20,
    "eyeColor": "green",
    "name": "Morrow Buckner",
    "gender": "male",
    "company": "MICROLUXE",
    "email": "morrowbuckner@microluxe.com",
    "phone": "+1 (946) 588-2731",
    "address": "885 Woods Place, Lawrence, Maryland, 7225",
    "about": "Consectetur cillum veniam culpa velit mollit excepteur ad elit mollit cupidatat reprehenderit dolor qui culpa. Esse in exercitation aliquip non Lorem eiusmod. Amet laborum elit aliquip velit excepteur amet eu id officia nulla laborum deserunt labore. Irure proident culpa sunt commodo aute non quis aliqua culpa Lorem exercitation.\r\n",
    "registered": "2021-07-11T07:50:40 -07:00",
    "latitude": -21.107556,
    "longitude": -99.27989,
    "tags": [
      "duis",
      "exercitation",
      "eu",
      "et",
      "pariatur",
      "minim",
      "eiusmod"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Padilla Oneil"
      },
      {
        "id": 1,
        "name": "Tanner Townsend"
      },
      {
        "id": 2,
        "name": "Geraldine Vang"
      }
    ],
    "greeting": "Hello, Morrow Buckner! You have 5 unread messages.",
    "favoriteFruit": "strawberry"
  },
  {
    "_id": "66fcf8775041ab70acd21334",
    "index": 4,
    "guid": "a2a0fac7-a509-4bbc-951e-04b731235eb7",
    "isActive": true,
    "balance": "\$2,560.56",
    "picture": "http://placehold.it/32x32",
    "age": 22,
    "eyeColor": "green",
    "name": "Isabel Franks",
    "gender": "female",
    "company": "IMANT",
    "email": "isabelfranks@imant.com",
    "phone": "+1 (989) 496-2215",
    "address": "210 Melba Court, Eden, Delaware, 7837",
    "about": "Aute cillum reprehenderit proident magna anim officia. Sint adipisicing anim duis Lorem elit minim excepteur dolore pariatur voluptate duis do. Dolore minim sit deserunt duis voluptate dolor dolor pariatur voluptate veniam ipsum nostrud do. Consectetur ipsum elit elit ullamco ullamco laborum exercitation enim. Incididunt exercitation exercitation consequat commodo qui ad qui laboris nulla ut reprehenderit duis enim et. Labore velit nostrud do Lorem aliqua dolore excepteur consequat irure do. Aliqua laboris velit laborum amet eiusmod ut commodo labore aute adipisicing.\r\n",
    "registered": "2023-11-22T01:03:04 -07:00",
    "latitude": 31.173947,
    "longitude": -150.0619,
    "tags": [
      "aute",
      "magna",
      "cupidatat",
      "cillum",
      "minim",
      "Lorem",
      "pariatur"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Jewel Kennedy"
      },
      {
        "id": 1,
        "name": "Marsha Fulton"
      },
      {
        "id": 2,
        "name": "Deana Michael"
      }
    ],
    "greeting": "Hello, Isabel Franks! You have 10 unread messages.",
    "favoriteFruit": "apple"
  },
  {
    "_id": "66fcf877543b0af5efed4055",
    "index": 5,
    "guid": "249b1e68-4495-4689-894f-d2f7aa0bdb0e",
    "isActive": true,
    "balance": "\$3,070.68",
    "picture": "http://placehold.it/32x32",
    "age": 26,
    "eyeColor": "green",
    "name": "Wall Cervantes",
    "gender": "male",
    "company": "SILODYNE",
    "email": "wallcervantes@silodyne.com",
    "phone": "+1 (959) 490-3792",
    "address": "961 Aviation Road, Fairhaven, New Hampshire, 4656",
    "about": "Magna deserunt magna aliqua commodo nulla do elit ea do labore mollit. Adipisicing in ex cillum duis tempor voluptate incididunt officia consectetur minim est aliquip elit. Ullamco enim aliquip nostrud in laboris magna labore laborum Lorem magna.\r\n",
    "registered": "2023-08-24T04:51:05 -07:00",
    "latitude": 59.477869,
    "longitude": -96.180882,
    "tags": [
      "dolor",
      "esse",
      "eiusmod",
      "est",
      "id",
      "proident",
      "mollit"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Thompson Banks"
      },
      {
        "id": 1,
        "name": "Alyce Keller"
      },
      {
        "id": 2,
        "name": "Ballard Herman"
      }
    ],
    "greeting": "Hello, Wall Cervantes! You have 1 unread messages.",
    "favoriteFruit": "banana"
  }
];