import { pageTitle } from 'ember-page-title';
import type PokemonRoute from 'ember-embroider-pokedex/routes/pokemon';
import {
  RouteTemplate,
  type RouteTemplateSignature,
} from 'ember-embroider-pokedex/utils/ember-route-template';
import Component from '@glimmer/component';
import Pokemon from 'ember-embroider-pokedex/components/pokemon';
import { Request } from '@warp-drive/ember';

type PokemonTemplateSignature = RouteTemplateSignature<PokemonRoute>;

@RouteTemplate
// eslint-disable-next-line ember/no-empty-glimmer-component-classes
export default class PokemonTemplate extends Component<PokemonTemplateSignature> {
  currentPokemon = (
    pokemons: Awaited<
      PokemonTemplateSignature['Args']['model']['pokemonRequest']
    >,
  ) => {
    return pokemons.find(
      (pokemon) => pokemon.id.toString() === this.args.model.pokemonId,
    );
  };

  <template>
    {{pageTitle 'Dynamic'}}

    <h3 class='text-xl font-medium mb-2'>Pokemon</h3>

    <Request @request={{@model.pokemonRequest}}>
      <:content as |PokemonContent|>
        <Pokemon @pokemon={{this.currentPokemon PokemonContent.data}} />
      </:content>
      <:loading>
        <div>Loading...</div>
      </:loading>
    </Request>

    {{outlet}}
  </template>
}
