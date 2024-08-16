import { pageTitle } from 'ember-page-title';
import { LinkTo } from '@ember/routing';
import type PokemonRoute from 'ember-embroider-pokedex/routes/pokemon';
import {
  RouteTemplate,
  type RouteTemplateSignature,
} from 'ember-embroider-pokedex/utils/ember-route-template';
import Component from '@glimmer/component';
import Pokemon from 'ember-embroider-pokedex/components/pokemon';
import { Request } from '@warp-drive/ember';
import { get } from '@ember/helper';

type PokemonTemplateSignature = RouteTemplateSignature<PokemonRoute>;

const emojiForType = {
  Normal: '🟦',
  Fighting: '🔴',
  Flying: '🔵',
  Poison: '🟣',
  Ground: '🟤',
  Rock: '🟪',
  Bug: '🟡',
  Ghost: '👻',
  Steel: '⚙️',
  Fire: '🔥',
  Water: '💧',
  Grass: '🍃',
  Electric: '⚡',
  Psychic: '🔮',
  Ice: '❄️',
  Dragon: '🐉',
  Dark: '🖤',
  Fairy: '🧚',
};

@RouteTemplate
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

    <LinkTo @route='index'>⬅️ back</LinkTo>

    <h3 class='text-xl font-medium mb-2'>Pokemon</h3>

    <Request @request={{@model.pokemonRequest}}>
      <:content as |PokemonContent|>
        {{#let (this.currentPokemon PokemonContent.data) as |pokemon|}}
          <Pokemon @pokemon={{pokemon}} />

          <p
            class='my-2 text-slate-700 text-lg italic'
          >{{pokemon.description}}</p>

          {{#each pokemon.type as |type|}}
            <span
              class='text-4xl'
              title={{type}}
            >{{get emojiForType type}}</span>
          {{/each}}
        {{/let}}
      </:content>
      <:loading>
        <div>Loading...</div>
      </:loading>
    </Request>

    {{outlet}}
  </template>
}
