'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "styles.css": "ade0cc11e740b690be2843dfb4d052f0",
"main.dart.js": "bd06114b20219a269f6a69759dfb1637",
"canvaskit/canvaskit.wasm": "bf50631470eb967688cca13ee181af62",
"canvaskit/profiling/canvaskit.wasm": "95a45378b69e77af5ed2bc72b2209b94",
"canvaskit/profiling/canvaskit.js": "38164e5a72bdad0faa4ce740c9b8e564",
"canvaskit/canvaskit.js": "2bc454a691c631b07a9307ac4ca47797",
"manifest.json": "7faa5fc3e06006333da08ae9fcd2ca0d",
"icons/Icon-maskable-512.png": "8a3caaac132f87dc0705f6a7faa4adb3",
"icons/Icon-maskable-192.png": "b4a7956d574476dddaac3c44b92282e9",
"icons/Icon-512.png": "20694699a43eb787d54c9fd493b8ff58",
"icons/Icon-192.png": "d023ad3f11d54f48bb7ce139c4ae9980",
"flutter.js": "f85e6fb278b0fd20c349186fb46ae36d",
"assets/AssetManifest.json": "633c7edb0e9b536b344e70bcb303d35c",
"assets/shaders/ink_sparkle.frag": "ab4751ef630837e294889ca64470bb70",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/FontManifest.json": "0bb47d763c71530154f754da9c4e786e",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/assets/appsMac/apple.png": "931d050a5850a3a8d2ae2d295db6b571",
"assets/assets/appsMac/xcode.png": "f9900f1956e3235a14c2bd4b5429ec9f",
"assets/assets/appsMac/terminal.png": "3ecf3267d488d8fa8f0c1858c2ef81b4",
"assets/assets/appsMac/spotify.png": "e3d4fbe9ccf1f88d2a2ffa9399a54a33",
"assets/assets/appsMac/appstore-Mac.png": "b4666b944e35a15d0886096b35df912e",
"assets/assets/appsMac/safari-Mac.png": "ae55c207d77601098ff706683af24bae",
"assets/assets/appsMac/photos.png": "e1f51470d74a1e537cbbfd00bf292311",
"assets/assets/appsMac/maps.png": "44f050da2b897af9cf108e4be40eca64",
"assets/assets/appsMac/notes.png": "a1dad83686dfd933061441bc31c9e1ea",
"assets/assets/appsMac/system%2520preferences.png": "2d690978a6b2a3a2ff126ff66e0219f5",
"assets/assets/appsMac/mail-Mac.png": "404c2f68025c1365abad4a9b9568e133",
"assets/assets/appsMac/calendar-Mac.png": "bef222029a1e58c65bb0c846f9d3ef45",
"assets/assets/appsMac/launchpad.png": "c3515e8d7e759f1700e03dc14aa3d94e",
"assets/assets/appsMac/feedback.png": "e71021a82d839d0759dddbf2702497a1",
"assets/assets/appsMac/finder.png": "9b9d5aa962e7450003d5788796fd2aa6",
"assets/assets/appsMac/contacts.png": "6de9bb0d2d070aec25d121a79be46588",
"assets/assets/appsMac/visual%2520studio%2520code.png": "90cf72caa96d9b79270c731464b0f630",
"assets/assets/appsMac/photobooth.png": "a46cfb5ff0c6ce1b8de5c9d70ada990d",
"assets/assets/appsMac/messages-Mac.png": "cd19525928e098148d68a2ba9c5bc877",
"assets/assets/appsMac/itunes.png": "8ec1cf9ccde56d855465df44f2639fe6",
"assets/assets/wallpapers/iridescence_light.jpg": "2a81b6f3c130a5ecbffa16a46147f5e0",
"assets/assets/wallpapers/bigSurValley_dark.jpg": "6402cf7b6c9683f6ff9d87edc6f2017b",
"assets/assets/wallpapers/iPadOS_dark.jpg": "e854fbb9d3eeb3f6fd17283e5d984bb7",
"assets/assets/wallpapers/realbigsur_light.jpg": "6d55843b58eee01015ea470f51a3a964",
"assets/assets/wallpapers/bigSurValley_light.jpg": "268f8c6acd25f0e846b748c2f99c786f",
"assets/assets/wallpapers/bigSurMountains.jpg": "51d8691df4ab1cdd19840b21da5c65b3",
"assets/assets/wallpapers/bigsur_light.jpg": "804c8b8903dd1c23e651fdf57d2de5ad",
"assets/assets/wallpapers/bigsur_dark.jpg": "eb11ad6fa4496371dafcf2bda6684125",
"assets/assets/wallpapers/bigSurHorizon.jpg": "a2a0564e270e093e80715d3a6fa66af8",
"assets/assets/wallpapers/realbigsur_dark.jpg": "f32f8578ab6147eeb7ab1b67b171e997",
"assets/assets/wallpapers/bigSurRoad.jpg": "af48337d0c5523c36f39e0db2e612863",
"assets/assets/wallpapers/iridescence_dark.jpg": "cc7c10464fd40625c5e4b0a770293066",
"assets/assets/wallpapers/flutterForward.jpg": "48b39e1539c92e0e8c85b02421857dd8",
"assets/assets/wallpapers/iPadOS_light.jpg": "7d3bd0a9b835adae4eff9c2bbf85d8d8",
"assets/assets/sysPref/settingTopLight.jpg": "8d4bb9020d4aeb71fcbe291caa0f17d1",
"assets/assets/sysPref/dock.png": "23a72a3fae7d23a1da2303b947254ea7",
"assets/assets/sysPref/settingMidLight.jpg": "f367071d72a5801ee5ab7662363e3a99",
"assets/assets/sysPref/settingBottomDark.jpg": "ae4a53ade5f3a0d10bf40bef703d2ed9",
"assets/assets/sysPref/desktop.png": "f431d38ec46e1af77b9b352911f6cdc7",
"assets/assets/sysPref/settingMidDark.jpg": "83f26fd5f329a7d988ff41fd645f2db8",
"assets/assets/sysPref/chrisbin.jpg": "fb849adcf1933015410feae56f113aa8",
"assets/assets/sysPref/appleID.png": "b62a7b075e0632495137a9f56cc276b8",
"assets/assets/sysPref/settingBottomLight.jpg": "75904d7b62f8b981ed14c5ed5751ccc7",
"assets/assets/sysPref/general.png": "228ee71402d5a771ffa69f86b75e1e41",
"assets/assets/sysPref/familySharing.png": "a2138779caab437b6031a833dca1fda7",
"assets/assets/sysPref/settingTopDark.jpg": "8a57d0981e1ba0ffc3fdf05919fd25e9",
"assets/assets/icons/applications.png": "def2229dc7dbb44c0898e26b7530dd39",
"assets/assets/icons/pdfMac.png": "f84b49baeeb6c070c1c7f12171e9ef13",
"assets/assets/icons/cc.png": "0005c30ab3c7135066f40c4f7f2e379c",
"assets/assets/icons/wifi.png": "38552e2ac203a50cc520adf721817fe0",
"assets/assets/icons/forwB.png": "f9c0646726a3252a69c5af3ff7ee6aaf",
"assets/assets/icons/apple_file.png": "d05eac70c1e08707d982d8b5c2936803",
"assets/assets/icons/spotlight.png": "1b7f615b2e5e44398a9a1bcda899f63b",
"assets/assets/icons/pictures.png": "0d2abd1d40e81845042a85fe25dd3752",
"assets/assets/icons/darkBlack.png": "e94465d31ddcdcab5f26d2b2ab0d8f64",
"assets/assets/icons/searchB.png": "5e43cb76d98d7d6ebf9119238c3413d6",
"assets/assets/icons/network.png": "df8c9ef556178b45f1636503157308f9",
"assets/assets/icons/tagB.png": "3f0e4443f2240e6a9fbd61cd79442ea7",
"assets/assets/icons/shareB.png": "4ddf62dbd4e9ec75d3b41efa38e91a98",
"assets/assets/icons/desktop.png": "c8e79b8cf602adc50f52304e1c4ff298",
"assets/assets/icons/downloads.png": "622d58b235c43ef783d0ef27dd293175",
"assets/assets/icons/sortB.png": "c63921d13e1274b83b4995f8cd7ebd3c",
"assets/assets/icons/sound.png": "6313266809f0851e0cbe8d76c347179c",
"assets/assets/icons/iconB.png": "74ff45fbdbd12c67c5f390dcc750c54e",
"assets/assets/icons/documents.png": "70b799d5e6bc3a71b89b81ca3d3187ef",
"assets/assets/icons/siri.png": "154ba596972859b51a69e4ac89084f7e",
"assets/assets/icons/movies.png": "32dca5c8552fa6c890d85647a60c740c",
"assets/assets/icons/mbp.png": "2e34652e07f0f0df289d684b2bc810b3",
"assets/assets/icons/brightness.png": "5651079343150b703c244f91350c5e31",
"assets/assets/icons/apple_file%2520org.png": "1e3c4773b5c56480f5dab0d9639f9fcd",
"assets/assets/icons/battery.png": "180f5d6715fa20a0177cf0a1b527c01b",
"assets/assets/icons/folder.png": "3f8e8a1a556a3b6c9ae1eb3cf9d38c10",
"assets/assets/icons/moreB.png": "0a6a00e95ffa5454d01c22e91e6be620",
"assets/assets/icons/music.png": "633deaef22f43e30a0973e41addb63f8",
"assets/assets/icons/icloud.png": "f3f4dd84eee49405a955408cf9a08d84",
"assets/assets/icons/backB.png": "b4adcbb1bc75a6017e6f67aa04347d08",
"assets/assets/caches/github.png": "1ee8d32ebd076fe0da94353ce9fc7c89",
"assets/assets/caches/twitter.png": "e973b40f2b3503470430fdcf9fdb5c37",
"assets/assets/caches/apple.png": "931d050a5850a3a8d2ae2d295db6b571",
"assets/assets/caches/flutterTalks.jpg": "34ed7e38702466b8082145dc555e20e9",
"assets/assets/caches/chrishub.jpg": "304d89d8402c9e66eb0259d1b3546427",
"assets/assets/caches/insta.png": "243aeebf1b4451c7d2cc0e3f818b7223",
"assets/assets/caches/youtube.jpg": "ec402072520c5177e889bff5f7b10816",
"assets/assets/caches/dream.jpg": "6e9ae147e3b172f407cbc4cef20124df",
"assets/assets/caches/google.png": "a841161bee43aa3b70c0fcc52b86b675",
"assets/assets/fonts/Menlo-Regular.ttf": "9f94dc20bb2a09c15241d3a880b7ad01",
"assets/assets/fonts/Helvetica-Bold.ttf": "d13db1fed3945c3b8c3293bfcfadb32f",
"assets/assets/fonts/SFRounded.ttf": "96495ebf6cec8b2b5bdf4edd51175f67",
"assets/assets/fonts/HN/HNLight.ttf": "ab9ea900012b01121513a32dd663c802",
"assets/assets/fonts/HN/HNThin.ttf": "c2d553c834e0c18d5c4927a8f6e6390f",
"assets/assets/fonts/HN/HNHeavy.ttf": "53806f4b601430afefa93919b6c2014c",
"assets/assets/fonts/HN/HNUltraLight.ttf": "777b7a12126b1792e5de8a09385ecae0",
"assets/assets/fonts/HN/HNBold.ttf": "f5f54ae625e40052346781ab3fa0c3bb",
"assets/assets/fonts/HN/HNMedium.ttf": "f115ff722f46925f57c99c67ac60ebc2",
"assets/assets/fonts/HN/HNRegular.ttf": "72f2b2857532058cf9d99aef4f5e55f7",
"assets/assets/fonts/HN/HNBlack.ttf": "fa46a185b1b27f853e8c1cbd7f7f47e5",
"assets/assets/fonts/HN/HNExtraBlack.ttf": "80640559f230ababc98316ef85f126bc",
"assets/assets/fonts/Helvetica.ttf": "1b580d980532792578c54897ca387e2c",
"assets/assets/fonts/SF/SFThin.otf": "f35e961114e962e90cf926bf979a8abc",
"assets/assets/fonts/SF/SFLight.otf": "ac5237052941a94686167d278e1c1c9d",
"assets/assets/fonts/SF/SFBlack.otf": "11e421ee3f03e231763aeb70962badd8",
"assets/assets/fonts/SF/SFHeavy.otf": "a545fc03ce079844a5ff898a25fe589b",
"assets/assets/fonts/SF/SFUltralight.otf": "bc55c63e7841855767b283b78bbd8d3a",
"assets/assets/fonts/SF/SFSemibold.otf": "e6ef4ea3cf5b1b533a85a5591534e3e4",
"assets/assets/fonts/SF/SFMedium.otf": "51fd7406327f2b1dbc8e708e6a9da9a5",
"assets/assets/fonts/SF/SFBold.otf": "644563f48ab5fe8e9082b64b2729b068",
"assets/assets/fonts/SF/SFRegular.otf": "aaeac71d99a345145a126a8c9dd2615f",
"assets/assets/messages/emoji.png": "57369253348c27118ccd5d076e8d4bd3",
"assets/assets/messages/voice.png": "8f1325d257e8270c16396557e0cd1767",
"assets/assets/messages/store.png": "ea47546f0a1206c65b2d9b58a0e0913d",
"assets/assets/messages/messageLog.json": "e35be46d786edf373721c345f81190b5",
"assets/assets/apps/mail.png": "8f0c0af7c210917f15f49d851d1c2860",
"assets/assets/apps/apple.png": "931d050a5850a3a8d2ae2d295db6b571",
"assets/assets/apps/podcasts.png": "f1dbaa22c534ea6d6c079fa1429109ef",
"assets/assets/apps/settings.png": "5bd7855b8003b6d9fd04efc15b5d0646",
"assets/assets/apps/stocks.png": "5a04d9f6ee169234fe98d621ad40c427",
"assets/assets/apps/tv.png": "45f1914034d060593c634f488eb78df3",
"assets/assets/apps/terminal.png": "3ecf3267d488d8fa8f0c1858c2ef81b4",
"assets/assets/apps/spotify.png": "e3d4fbe9ccf1f88d2a2ffa9399a54a33",
"assets/assets/apps/messages.png": "cd19525928e098148d68a2ba9c5bc877",
"assets/assets/apps/photos.png": "e1f51470d74a1e537cbbfd00bf292311",
"assets/assets/apps/maps.png": "44f050da2b897af9cf108e4be40eca64",
"assets/assets/apps/notes.png": "a1dad83686dfd933061441bc31c9e1ea",
"assets/assets/apps/system%2520preferences.png": "2d690978a6b2a3a2ff126ff66e0219f5",
"assets/assets/apps/safari.png": "ae55c207d77601098ff706683af24bae",
"assets/assets/apps/mail-Mac.png": "404c2f68025c1365abad4a9b9568e133",
"assets/assets/apps/launchpad.png": "c3515e8d7e759f1700e03dc14aa3d94e",
"assets/assets/apps/feedback.png": "e71021a82d839d0759dddbf2702497a1",
"assets/assets/apps/finder.png": "9b9d5aa962e7450003d5788796fd2aa6",
"assets/assets/apps/contacts.png": "6de9bb0d2d070aec25d121a79be46588",
"assets/assets/apps/visual%2520studio%2520code.png": "90cf72caa96d9b79270c731464b0f630",
"assets/assets/apps/about%2520me.png": "e083d801ff651c49263ec741bba91d4a",
"assets/assets/apps/itunes.png": "8ec1cf9ccde56d855465df44f2639fe6",
"assets/assets/apps/calendar.png": "bef222029a1e58c65bb0c846f9d3ef45",
"assets/NOTICES": "1939a8c02ff2a8f608fe80aba354c6f1",
"index.html": "573a9c5c3edae53e28d636d08efe46bc",
"/": "573a9c5c3edae53e28d636d08efe46bc",
"favicon.png": "e8d8daa5dd50803a769d3b5573654c1f",
"version.json": "00ec58db421c57d6160e0458129f79f5"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/AssetManifest.json",
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
