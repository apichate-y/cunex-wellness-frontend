'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "51c3b5f7506d9a8a0d8530df6ce650e9",
"version.json": "83374b5170a26580392b35f62ecdf891",
"index.html": "7135df02206cc64a10ee5856570cc840",
"/": "7135df02206cc64a10ee5856570cc840",
"main.dart.js": "e7fc121a5ad301ce9bfc49413d053acf",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "6ad6f8af3cfc49910cd0f90cfd5f39da",
"assets/AssetManifest.json": "74f0de4a2292e97044cee57f1505f932",
"assets/NOTICES": "3424e1d41df0f6d87d91168d32ac2f8f",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "0fa9b7918861d38bf3a6c369fef56f60",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/lib/assets/images/element/IMG_5785.HEIC": "77414e9b2321ff8f0503243b08bd88f1",
"assets/lib/assets/images/element/j.png": "577014ac1bf6af4de094d64c9d3b4336",
"assets/lib/assets/images/element/h.png": "a97a881399c92aafd4f57c5dce7c4690",
"assets/lib/assets/images/element/i.png": "4c296875aba8c0239a7faad68810cfea",
"assets/lib/assets/images/element/F6FB5810-6161-4828-8B22-91DBFC88AFBD.PNG": "45d19561fd3322b43eeec3ff40ba1339",
"assets/lib/assets/images/element/F00A1BF9-5F0A-4192-BA23-2BAD2D0C41F1.PNG": "d5359be634383eb6436f37c340b68ec6",
"assets/lib/assets/images/element/PHOTOSS.png": "55652041c3e8e6282092b866761a27fb",
"assets/lib/assets/images/element/addfriend.png": "7762063f703418eb910ed779db317a93",
"assets/lib/assets/images/element/friends.png": "218e3dc3649710d54fc73102c739daed",
"assets/lib/assets/images/element/3941EF3B-05B8-4374-8EAD-D1D8A9A784D3.PNG": "4c69ae706148fe051492cbb91e036e92",
"assets/lib/assets/images/element/qr.png": "ef33bf1d99f04fc29235368ab46327ad",
"assets/lib/assets/images/element/b.png": "1ec4a32a283c7d20f7d265c76e3f66ec",
"assets/lib/assets/images/element/c.png": "22532648adb9b87dc45edde5ad617482",
"assets/lib/assets/images/element/0AF68D0A-2876-4488-B6CD-ECB137183982.PNG": "04c5e8c6b796e9214011e5480b820724",
"assets/lib/assets/images/element/a.png": "2fc06ac35b44be8ecf203efbb28c7861",
"assets/lib/assets/images/element/d.png": "2f516c593d5c57497a11402da8905166",
"assets/lib/assets/images/element/e.png": "02a521c8eba7dd750952d8bceceb7edc",
"assets/lib/assets/images/element/C0BC0DB8-BB81-4966-AB07-39A3D59B8D73.PNG": "1ac425af815b266e2e58e043eef0225a",
"assets/lib/assets/images/element/g.png": "6aad0f717c8083db34112f336b26add1",
"assets/lib/assets/images/element/AC2BC3DB-BCDE-4EC3-99C5-3B128D5B4FAD.PNG": "554885b73e61444950f50c5c73ed7d38",
"assets/lib/assets/images/element/f.png": "daa0c2433a22b4bac81af86e78e1ae23",
"assets/lib/assets/images/element/everyone.png": "0b5e1dcb835873ed7baf73d72dc0454f",
"assets/lib/assets/images/mascot/nexky%2520character-03.png": "da56cfee43cc85a1ba9cb3dd5b7d59db",
"assets/lib/assets/images/mascot/nexky%2520character-17.png": "8a5099667485f1a1d3e044c474017a7e",
"assets/lib/assets/images/mascot/nexky%2520character-16.png": "471304ed49b78fa0153d4afbb7a7da8d",
"assets/lib/assets/images/mascot/nexky%2520character-14.png": "09e9bd4406d98c33b5120f9f53cd3771",
"assets/lib/assets/images/mascot/nexky%2520character-15.png": "670602719cb3d345ea9e073b65975b28",
"assets/lib/assets/images/mascot/nexky%2520character-11.png": "cb420bbe4254a7214f7a8490aac7facb",
"assets/lib/assets/images/mascot/nexky%2520character-10.png": "4edc3bf16ae7022ad5bbd5877b8b8cca",
"assets/lib/assets/images/mascot/nexky%2520character-06.png": "46323a558ca374c188e52d9ce3711c77",
"assets/lib/assets/images/mascot/nexky%2520character-12.png": "f41035bba569083177189214d15a102c",
"assets/lib/assets/images/mascot/nexky%2520character-13.png": "c26a02799b158ff756f802ebf3a57a2c",
"assets/lib/assets/images/mascot/nexky%2520character-07.png": "5dfafe0c0ddd122c27a2f85bff5bdf30",
"assets/lib/assets/images/mascot/nexky%2520character-09.png": "9e8d6573b22e907925910af9e80f6699",
"assets/lib/assets/images/mascot/nexky%2520character-08.png": "556698bee5a88e198eeb02105f885e24",
"assets/lib/assets/images/mascot/nexky%2520character-20.png": "f1e29ea562bb35a7802bffa5fbc1ae95",
"assets/lib/assets/images/mascot/nexky%2520character-18.png": "6daf7952a8b0707047f7dbab4907d379",
"assets/lib/assets/images/mascot/nexky%2520character-19.png": "9ef38e250c6f7b4261ef2fba773f5793",
"assets/lib/assets/images/mascot/iconnie.png": "0188a9c380835562dfca1d6f5914c817",
"assets/lib/assets/images/%25E0%25B9%2581%25E0%25B8%2595%25E0%25B9%2588%25E0%25B8%2587%25E0%25B8%2595%25E0%25B8%25B1%25E0%25B8%25A7nexky/cunex%2520icon-09.png": "1d11b1b170c9c7ed9f194c0a6112aab6",
"assets/lib/assets/images/%25E0%25B9%2581%25E0%25B8%2595%25E0%25B9%2588%25E0%25B8%2587%25E0%25B8%2595%25E0%25B8%25B1%25E0%25B8%25A7nexky/cunex%2520icon-08.png": "959317563575ede613ed3334f46d72f0",
"assets/lib/assets/images/%25E0%25B9%2581%25E0%25B8%2595%25E0%25B9%2588%25E0%25B8%2587%25E0%25B8%2595%25E0%25B8%25B1%25E0%25B8%25A7nexky/nexky%2520character-05.png": "984e3c66e21edd2bf0828d9b487dbcab",
"assets/lib/assets/images/%25E0%25B9%2581%25E0%25B8%2595%25E0%25B9%2588%25E0%25B8%2587%25E0%25B8%2595%25E0%25B8%25B1%25E0%25B8%25A7nexky/nexky%2520character-04.png": "59d033d3212f7bc61b422449a2cb99b4",
"assets/lib/assets/images/%25E0%25B9%2581%25E0%25B8%2595%25E0%25B9%2588%25E0%25B8%2587%25E0%25B8%2595%25E0%25B8%25B1%25E0%25B8%25A7nexky/cunex%2520icon-03.png": "928df70f0ca850d580dabf8bb9081856",
"assets/lib/assets/images/%25E0%25B9%2581%25E0%25B8%2595%25E0%25B9%2588%25E0%25B8%2587%25E0%25B8%2595%25E0%25B8%25B1%25E0%25B8%25A7nexky/cunex%2520icon-02.png": "7130d991b57fb31322bf79aa8d8b5b54",
"assets/lib/assets/images/%25E0%25B9%2581%25E0%25B8%2595%25E0%25B9%2588%25E0%25B8%2587%25E0%25B8%2595%25E0%25B8%25B1%25E0%25B8%25A7nexky/cunex%2520icon-11.png": "cc210f1c5b5223b2147ae4e8ca009d7b",
"assets/lib/assets/images/%25E0%25B9%2581%25E0%25B8%2595%25E0%25B9%2588%25E0%25B8%2587%25E0%25B8%2595%25E0%25B8%25B1%25E0%25B8%25A7nexky/cunex%2520icon-05.png": "6aee3e821fe0733b98174897fbf2d6e7",
"assets/lib/assets/images/%25E0%25B9%2581%25E0%25B8%2595%25E0%25B9%2588%25E0%25B8%2587%25E0%25B8%2595%25E0%25B8%25B1%25E0%25B8%25A7nexky/cunex%2520icon-04.png": "7172ca9ce1575f9157166837a6b8c20e",
"assets/lib/assets/images/%25E0%25B9%2581%25E0%25B8%2595%25E0%25B9%2588%25E0%25B8%2587%25E0%25B8%2595%25E0%25B8%25B1%25E0%25B8%25A7nexky/cunex%2520icon-10.png": "2c0523721bca843e7efe7752cd6d4254",
"assets/lib/assets/images/%25E0%25B9%2581%25E0%25B8%2595%25E0%25B9%2588%25E0%25B8%2587%25E0%25B8%2595%25E0%25B8%25B1%25E0%25B8%25A7nexky/cunex%2520icon-06.png": "d9fb7439f72c83a8b3d1b4e1c9c11a52",
"assets/lib/assets/images/%25E0%25B9%2581%25E0%25B8%2595%25E0%25B9%2588%25E0%25B8%2587%25E0%25B8%2595%25E0%25B8%25B1%25E0%25B8%25A7nexky/cunex%2520icon-07.png": "1aaa299561fbc2e4009e7e95f2993f0f",
"assets/lib/assets/images/icons/cunex%2520icon%2520(1).png": "768ea3c93582c371959d3beac0f3d225",
"assets/lib/assets/images/icons/ui/%25E0%25B8%25AB%25E0%25B8%2599%25E0%25B9%2589%25E0%25B8%25B2%2520ui%2520%25E0%25B8%25A3%25E0%25B8%25A7%25E0%25B8%25A1-06.png": "18db2b5e9485712ca0d0453da5ffe421",
"assets/lib/assets/images/icons/ui/%25E0%25B8%25AB%25E0%25B8%2599%25E0%25B9%2589%25E0%25B8%25B2%2520ui%2520%25E0%25B8%25A3%25E0%25B8%25A7%25E0%25B8%25A1-07.png": "51c248f8f0613a39a8da0f9dd4bdaa59",
"assets/lib/assets/images/icons/ui/%25E0%25B8%25AB%25E0%25B8%2599%25E0%25B9%2589%25E0%25B8%25B2%2520ui%2520%25E0%25B8%25A3%25E0%25B8%25A7%25E0%25B8%25A1-10.png": "468494a8d49f1678b3f4f3923aa82df4",
"assets/lib/assets/images/icons/ui/%25E0%25B8%25AB%25E0%25B8%2599%25E0%25B9%2589%25E0%25B8%25B2%2520ui%2520%25E0%25B8%25A3%25E0%25B8%25A7%25E0%25B8%25A1-09.png": "31504f29fdc68358c668cb75c07112d6",
"assets/lib/assets/images/icons/ui/%25E0%25B8%25AB%25E0%25B8%2599%25E0%25B9%2589%25E0%25B8%25B2%2520ui%2520%25E0%25B8%25A3%25E0%25B8%25A7%25E0%25B8%25A1-08.png": "778d91f3685cfa6b1ce86899b4b155e0",
"assets/lib/assets/images/icons/%25E0%25B9%2580%25E0%25B8%25A1%25E0%25B8%2586%2520emotion/Untitled-24-11.png": "538e962d3cf7a6a17e86104d352547d4",
"assets/lib/assets/images/icons/%25E0%25B9%2580%25E0%25B8%25A1%25E0%25B8%2586%2520emotion/Untitled-24-10.png": "cf7c60ac7237025887291530f1914a68",
"assets/lib/assets/images/icons/%25E0%25B9%2580%25E0%25B8%25A1%25E0%25B8%2586%2520emotion/Untitled-24-12.png": "ba26065eb93dfadbf7fdd1767b2b1028",
"assets/lib/assets/images/icons/%25E0%25B9%2580%25E0%25B8%25A1%25E0%25B8%2586%2520emotion/Untitled-24-07.png": "c53e21c6c80460793fea94733c3b7399",
"assets/lib/assets/images/icons/%25E0%25B9%2580%25E0%25B8%25A1%25E0%25B8%2586%2520emotion/Untitled-24-09.png": "60bffed58beeb865c2f1819ae9608bd9",
"assets/lib/assets/images/icons/%25E0%25B9%2580%25E0%25B8%25A1%25E0%25B8%2586%2520emotion/Untitled-24-08.png": "a258caa6b205fc55d6db2da56b4fa45f",
"assets/lib/assets/images/icons/Untitled-24-13.png": "f21c8694cb8cf7628ab614c86f12046f",
"assets/lib/assets/images/icons/Untitled-24-03.png": "6cedd8b9af914a405e36294385a75945",
"assets/lib/assets/images/icons/Untitled-24-14.png": "abd508b8fac61b7bbb201cb9760b59a9",
"assets/lib/assets/images/icons/Untitled-24-01.png": "3fc5693a5012003a7fc566de53d95a8e",
"assets/lib/assets/images/icons/streak/icon-01.png": "d98c79d1b52574a1aa33dc1311ef8665",
"assets/lib/assets/images/icons/streak/icon-03.png": "bec3c7f41edccaa6badb157cdfbbb9e1",
"assets/lib/assets/images/icons/streak/icon-02.png": "0a8a7b71a20898a5dc0c84bf23a9f50f",
"assets/lib/assets/images/icons/streak/icon-11.png": "4ee9a32d7a8826565d6a8e79f1160e46",
"assets/lib/assets/images/icons/streak/icon-04.png": "49c16ad67e2a17cba039f9a6368427ab",
"assets/lib/assets/images/icons/streak/icon-10.png": "6212b10e70c5aa59b7cc1b72c4fd4de1",
"assets/lib/assets/images/icons/5%2520main%2520buttons/chat2.png": "eec166621c2ad3d4c94e34e6d7e97bc0",
"assets/lib/assets/images/icons/5%2520main%2520buttons/music2.png": "1fbccb85d61e0a7d3ab85c968aca5ed2",
"assets/lib/assets/images/icons/5%2520main%2520buttons/music.png": "1fab5f4f149642a052257fcff9a8f711",
"assets/lib/assets/images/icons/5%2520main%2520buttons/home.png": "549b2ed85cd73153983d25fe34cee7e7",
"assets/lib/assets/images/icons/5%2520main%2520buttons/calendar.png": "ce8f266d595e1c77933a06a9e6f5f077",
"assets/lib/assets/images/icons/5%2520main%2520buttons/profile.png": "5a8720fbaa237a7de233c81c3386c0f2",
"assets/lib/assets/images/icons/5%2520main%2520buttons/calendar2.png": "68f10707a2fb7c2e15c04a94bf4006cc",
"assets/lib/assets/images/icons/5%2520main%2520buttons/home2.png": "bc149b3c7adab2311496f26bc90882b8",
"assets/lib/assets/images/icons/5%2520main%2520buttons/profile2.png": "88e6c608299313259aa9887ec88e3346",
"assets/lib/assets/images/icons/5%2520main%2520buttons/chat.png": "933593084ea41022b51f56111244b727",
"assets/lib/assets/images/icons/Untitled-8-03.png": "e7819504c5a56e3a9e3feddd96eddcbf",
"assets/lib/assets/images/icons/Untitled-8-02.png": "a6adc53f77e912fb310637b7996289da",
"assets/lib/assets/images/icons/Untitled-24-22.png": "3f958cb17b2b6ab33ce612048bfb1251",
"assets/lib/assets/images/icons/cunex%2520icon.png": "87e89fdf4bd6b6e37f941e63620d49ec",
"assets/lib/assets/images/icons/Untitled-24-20.png": "07cb006ffde7418b47b5f2ee02c071e8",
"assets/lib/assets/images/bg/bg_night.png": "bdb7b598097091f6de31ed90bd8b5f90",
"assets/lib/assets/images/bg/bg_evening.png": "ce1b9c437a478eb0d4ae41a0aa648ae2",
"assets/lib/assets/images/bg/bg_noon.png": "64a1c9cb1f40022731418eb408111634",
"assets/lib/assets/images/bg/bg_early_morning.png": "05f0fef33b40c9b5a44131ad52ddfbb7",
"assets/lib/assets/images/word/info.png": "6a6c5544a1f1ffad0bc722d0d3cdd573",
"assets/lib/assets/images/word/8.png": "b6e561be6cb22cc7c1bce46020957923",
"assets/lib/assets/images/word/9.png": "264544a4089293acb895cb3e62a4ae58",
"assets/lib/assets/images/word/11.png": "8df85074be4f41ef63ba23181c60c073",
"assets/lib/assets/images/word/10.png": "11a3dfcc795f127e0688ae4f6bb0e5a6",
"assets/lib/assets/images/word/4.png": "bac18e2b95570348cb186db495155c8e",
"assets/lib/assets/images/word/7.png": "9c690f12ed40bc88c540c208017c4b02",
"assets/lib/assets/images/word/6.png": "6c38bf4f9af4943ec66801f741c927b8",
"assets/lib/assets/images/word/2.png": "1be06a67cf93dfe9dc6ecb8cae60a304",
"assets/lib/assets/images/word/3.png": "e592bd21a2196649a50874391725e1d6",
"assets/lib/assets/images/word/1.png": "a0059ba177d1718a02ccd0c4239d0c44",
"assets/lib/assets/sounds/wellness/Serenity%2520Sparks.mp3": "bcccddbe96d04ab970c9f060d45e2290",
"assets/lib/assets/sounds/wellness/Healing%2520Earth.mp3": "773fcc62386dfc2005ec537da39de7e7",
"assets/lib/assets/sounds/wellness/Wellness%2520Groove.mp3": "8c3e3e91def089e240d2babc2e6dc5cf",
"assets/lib/assets/sounds/wellness/Golden%2520Glow.mp3": "0e4fff1423fb3a9f975531e52ecd2010",
"assets/lib/assets/sounds/wellness/Tranquil%2520Springs.mp3": "93402315e7cb8b6ed264f15e0c243a21",
"assets/lib/assets/sounds/sleep/Deep%2520Sleep%2520Waves.mp3": "9d56c6d38e695e5f7ae89d7ff2059d8b",
"assets/lib/assets/sounds/sleep/Moonlit%2520Waves.mp3": "b409883b098b55de092d2639a4b3121e",
"assets/lib/assets/sounds/sleep/Dream%2520Cascade.mp3": "d46e43d7bcbaae903031ec4bc9ef777c",
"assets/lib/assets/sounds/sleep/Starlit%2520Dreams.mp3": "a85aeddf4db792ac4e4cb9c0a49fee99",
"assets/lib/assets/sounds/sleep/Dreamwaves.mp3": "36bb4c1cb25fe2e82713de23fedeebfb",
"assets/lib/assets/sounds/focus/Echoes%2520of%2520the%2520Forest.mp3": "397a9da3bfe7396ed9a692b3e03a5441",
"assets/lib/assets/sounds/focus/Stay%2520Steady.mp3": "552ea9151149ca64d58bac5d443c4143",
"assets/lib/assets/sounds/focus/Flowing%2520Mindstream.mp3": "1535e9468395bc216eb4709e1a5f43f5",
"assets/lib/assets/sounds/focus/Flow%2520State.mp3": "d04bea615ba5f047e6eeb019a37b3382",
"assets/lib/assets/sounds/focus/Forest%2520Pulse.mp3": "729e21f74ef49b0210fc849a96cf7fae",
"assets/lib/assets/sounds/chill/Twilight%2520Harmony.mp3": "76448d3891a7c8b9d4c612debc68aa46",
"assets/lib/assets/sounds/chill/Waves%2520in%2520My%2520Soul.mp3": "42f5aab7408a26cff6b00b5e029c99fe",
"assets/lib/assets/sounds/chill/Sunset%2520Drift.mp3": "27d7afc2914dfc18cbeb075e4d909b89",
"assets/lib/assets/sounds/chill/Slow%2520Down.mp3": "90a88d6a847bfdb513711268edb5f0fc",
"assets/lib/assets/sounds/chill/Gentle%2520Waves.mp3": "ab5e4cb0cfd846b1d8b8c2f20869e084",
"assets/lib/assets/sounds/chill/Breathe%2520Easy.mp3": "0dd5e87ea962a2a31dea3724056cdd92",
"assets/AssetManifest.bin": "3328cde28f867a44ea87aca6bd0bf565",
"assets/fonts/MaterialIcons-Regular.otf": "80bf8e25d046f356ca500f2f4ba673fb",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.js": "ba4a8ae1a65ff3ad81c6818fd47e348b",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/canvaskit.js": "6cfe36b4647fbfa15683e09e7dd366bc",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
