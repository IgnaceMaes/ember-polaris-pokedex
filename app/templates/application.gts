import { pageTitle } from 'ember-page-title';
import RouteTemplate from 'ember-route-template';

export default RouteTemplate(
  <template>
    {{pageTitle 'Ember Pokedex'}}

    <h2 id='title'>Ember Pokedex</h2>

    {{outlet}}
  </template>,
);
