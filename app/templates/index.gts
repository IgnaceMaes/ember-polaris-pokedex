import RouteTemplate from 'ember-route-template';
import { pageTitle } from 'ember-page-title';
import Pokemon from 'ember-embroider-pokedex/components/pokemon';

export default RouteTemplate(
  <template>
    {{pageTitle 'Overview'}}

    <h3 class="text-2xl font-medium mb-2">Overview</h3>

    <div class="grid grid-cols-8 gap-4">
      {{#each @model as |pokemon|}}
        <Pokemon @pokemon={{pokemon}} />
      {{/each}}
    </div>

    {{outlet}}
  </template>,
);
