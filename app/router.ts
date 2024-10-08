import EmberRouter from '@ember/routing/router';
import config from 'ember-polaris-pokedex/config/environment';

export default class Router extends EmberRouter {
  location = config.locationType;
  rootURL = config.rootURL;
}

Router.map(function () {
  this.route('pokemon', function () {
    this.route('pokemon', { path: ':pokemon_id' });
  });
  this.route('about');
});
