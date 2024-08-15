import { pageTitle } from 'ember-page-title';
import RouteTemplate from 'ember-route-template';

export default RouteTemplate(
  <template>
    {{pageTitle 'Ember Pokedex'}}

    <main class="container m-auto py-8">
      <h2 class="text-4xl font-bold mb-4">Ember Pokedex</h2>

      {{outlet}}
    </main>
  </template>,
);
