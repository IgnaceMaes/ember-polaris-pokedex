import Pokemon from 'ember-embroider-pokedex/components/pokemon';
import type IndexRoute from 'ember-embroider-pokedex/routes';
import { Request } from '@warp-drive/ember';
import {
  RouteTemplate,
  type RouteTemplateSignature,
} from 'ember-embroider-pokedex/utils/ember-route-template';
import Component from '@glimmer/component';
import LoadingBar from 'ember-embroider-pokedex/components/loading-bar';

type IndexTemplateSignature = RouteTemplateSignature<IndexRoute>;

@RouteTemplate
// eslint-disable-next-line ember/no-empty-glimmer-component-classes
export default class IndexTemplate extends Component<IndexTemplateSignature> {
  <template>
    <Request @request={{@model.pokemonRequest}}>
      <:content as |PokemonContent|>
        <div class='grid grid-cols-2 md:grid-cols-4 lg:grid-cols-6 xl:grid-cols-8 gap-4'>
          {{#each PokemonContent.data as |pokemon|}}
            <Pokemon @pokemon={{pokemon}} />
          {{/each}}
        </div>
      </:content>
      <:loading>
        <LoadingBar />
      </:loading>
    </Request>

    {{outlet}}
  </template>
}
