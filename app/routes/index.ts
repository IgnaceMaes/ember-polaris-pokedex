import Route from '@ember/routing/route';
import type { ModelFrom } from 'ember-embroider-pokedex/utils/ember-route-template';
import type ApplicationRoute from 'ember-embroider-pokedex/routes/application';

export default class IndexRoute extends Route {
  model() {
    return this.modelFor('application') as ModelFrom<ApplicationRoute>;
  }
}
