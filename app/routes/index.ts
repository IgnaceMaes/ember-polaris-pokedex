import Route from '@ember/routing/route';
import type { ModelFrom } from 'ember-polaris-pokedex/utils/ember-route-template';
import type ApplicationRoute from 'ember-polaris-pokedex/routes/application';

export default class IndexRoute extends Route {
  model() {
    return this.modelFor('application') as ModelFrom<ApplicationRoute>;
  }
}
