import { pageTitle } from 'ember-page-title';
import Pokemon from 'ember-embroider-pokedex/components/pokemon';
import type IndexRoute from 'ember-embroider-pokedex/routes';
import { Request } from '@warp-drive/ember';
import { RouteComponent, RouteTemplate } from 'ember-embroider-pokedex/utils/ember-route-template';

@RouteTemplate
export default class IndexTemplate extends RouteComponent<IndexRoute> {
  <template>
    {{pageTitle 'Overview'}}

    <h3 class='text-2xl font-medium mb-2'>Overview</h3>

    <Request @request={{@model.pokemonRequest}}>
      <:content as |PokemonContent|>
        <div class='grid grid-cols-8 gap-4'>
          {{#each PokemonContent.data as |pokemon|}}
            <Pokemon @pokemon={{pokemon}} />
          {{/each}}
        </div>
      </:content>
      <:loading>
        <div>Loading...</div>
      </:loading>
    </Request>

    {{outlet}}
  </template>
}
