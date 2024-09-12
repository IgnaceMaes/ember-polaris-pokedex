import { pageTitle } from 'ember-page-title';
import type PokemonRoute from 'ember-polaris-pokedex/routes/pokemon/pokemon';
import {
  RouteTemplate,
  type RouteTemplateSignature,
} from 'ember-polaris-pokedex/utils/ember-route-template';
import Component from '@glimmer/component';
import { Request } from '@warp-drive/ember';
import LoadingBar from 'ember-polaris-pokedex/components/loading-bar';
import HomeButton from 'ember-polaris-pokedex/components/home-button';
import PokemonDetails from 'ember-polaris-pokedex/components/pokemon-details';

type PokemonTemplateSignature = RouteTemplateSignature<PokemonRoute>;

@RouteTemplate
export default class PokemonTemplate extends Component<PokemonTemplateSignature> {
  <template>
    <HomeButton />

    <Request @request={{@model.pokemonRequest}}>
      <:content as |pokemon|>
        {{pageTitle pokemon.data.name.english}}

        <PokemonDetails @pokemon={{pokemon.data}} />
      </:content>
      <:error>
        <p>Couldn't find that Pokémon!</p>
      </:error>
      <:loading>
        <LoadingBar />
      </:loading>
    </Request>

    {{outlet}}
  </template>
}
