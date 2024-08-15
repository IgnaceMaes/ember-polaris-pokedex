import RouteTemplate from 'ember-route-template';
import { pageTitle } from 'ember-page-title';
import Pokemon from 'ember-embroider-pokedex/components/pokemon';

export default RouteTemplate(
  <template>
    {{pageTitle "Overview"}}

    <h3>Overview</h3>

    {{#each @model as |pokemon|}}
      <Pokemon @pokemon={{pokemon}} />
    {{/each}}

    {{outlet}}
  </template>
);
