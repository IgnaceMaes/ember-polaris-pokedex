import RouteTemplate from 'ember-route-template';
import { pageTitle } from 'ember-page-title';
import Pokemon from 'ember-embroider-pokedex/components/pokemon';

export default RouteTemplate(
  <template>
    {{pageTitle 'Overview'}}

    <h3>Overview</h3>

    <div class="grid">
      {{#each @model as |pokemon|}}
        <Pokemon @pokemon={{pokemon}} />
      {{/each}}
    </div>

    {{outlet}}

    <style>
      .grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
        gap: 1rem;
      }
    </style>
  </template>,
);
