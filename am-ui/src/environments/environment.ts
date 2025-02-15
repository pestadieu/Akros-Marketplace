// This file can be replaced during build by using the `fileReplacements` array.
// `ng build --prod` replaces `environment.ts` with `environment.prod.ts`.
// The list of file replacements can be found in `angular.json`.

// The file contents for the current environment will overwrite these during build.
// The build system defaults to the dev environment which uses `environment.ts`, but if you do
// `ng build --env=prod` then `environment.prod.ts` will be used instead.
// The list of which env maps to which file can be found in `.angular-cli.json`.

export const environment = {
  production: false,
  ownUrl: 'https://localhost:4200',
  apiUrl: 'https://localhost:8443',
  authUrl: 'https://localhost:9443',
  signOn: {
    authority:
      'https://login.microsoftonline.com/45a8141c-94c3-4fde-9cf3-0cfcc10ad529',
    clientId: '9f9965aa-840d-4c88-8121-eac081ee2dd8',
  },
  keycloakConfig: {
    issuer: 'http://127.0.0.1:9090/realms/akros-marketplace',
    redirectUri: window.location.origin,
    silentRefreshRedirectUri:
      'https://localhost:4200/assets/silent-refresh.html',
    useSilentRefresh: true,
    clientId: 'marketplace',
    scope: 'openid profile email offline_access',
    requireHttps: false,
    responseType: 'code',
    dummyClientSecret: 'XP0knCLKLhJK8uaEZQg8RRqsENzlywe1',
  },
};

/*
 * For easier debugging in development mode, you can import the following file
 * to ignore zone related error stack frames such as `zone.run`, `zoneDelegate.invokeTask`.
 *
 * This import should be commented out in production mode because it will have a negative impact
 * on performance if an error is thrown.
 */
// import 'zone.js/plugins/zone-error';  // Included with Angular CLI.
