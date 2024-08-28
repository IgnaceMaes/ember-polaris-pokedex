import Application from '@ember/application';
// @ts-expect-error: no types core/entrypoint
import compatModules from '@embroider/core/entrypoint';
import Resolver from 'ember-resolver';
import loadInitializers from 'ember-load-initializers';
import config from 'ember-polaris-pokedex/config/environment';
import './app.css';
import { setBuildURLConfig } from '@ember-data/request-utils';

setBuildURLConfig({
  host: window.location.origin,
  namespace: 'api',
});

// @ts-expect-error: no types for define
let d = window.define;

for (const [name, module] of Object.entries(compatModules)) {
  d(name, function () {
    return module;
  });
}

export default class App extends Application {
  modulePrefix = config.modulePrefix;
  podModulePrefix = config.podModulePrefix;
  Resolver = Resolver;
}

loadInitializers(App, config.modulePrefix);
