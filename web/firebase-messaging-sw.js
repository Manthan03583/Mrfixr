importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

firebase.initializeApp({
     apiKey: "AIzaSyBHK4cC9ik26fAgHLr_7Vfcj8tD2TEo8Gg",
     authDomain: "mr-fixr-1e909.firebaseapp.com",
      projectId: "mr-fixr-1e909",
      storageBucket: "mr-fixr-1e909.appspot.com",
      messagingSenderId: "789654173637",
      appId: "1:789654173637:web:9dcb92963e64a273177dac",
//   apiKey: "AIzaSyD_Y7SAZoGunqJyloxuCDcm_qfHy-ZXn_k",
//   authDomain: "on-demand-project.firebaseapp.com",
//   projectId: "on-demand-project",
//   storageBucket: "on-demand-project.appspot.com",
//   messagingSenderId: "361171276071",
//   appId: "1:361171276071:web:0e60b9a7ba7f9993b45902",
  databaseURL: "...",
});

const messaging = firebase.messaging();

messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            const title = payload.notification.title;
            const options = {
                body: payload.notification.score
              };
            return registration.showNotification(title, options);
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});