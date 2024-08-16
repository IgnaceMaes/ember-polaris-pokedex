import { PokemonType } from 'ember-embroider-pokedex/models/pokemon';
import { pageTitle } from 'ember-page-title';
import { LinkTo } from '@ember/routing';
import type PokemonRoute from 'ember-embroider-pokedex/routes/pokemon';
import {
  RouteTemplate,
  type RouteTemplateSignature,
} from 'ember-embroider-pokedex/utils/ember-route-template';
import Component from '@glimmer/component';
import { Request } from '@warp-drive/ember';
import { get } from '@ember/helper';
import type { TOC } from '@ember/component/template-only';

type PokemonTemplateSignature = RouteTemplateSignature<PokemonRoute>;

const emojiForType = {
  Normal: '🟦',
  Fighting: '🔴',
  Flying: '🪽',
  Poison: '🟣',
  Ground: '🟤',
  Rock: '🪨',
  Bug: '🐛',
  Ghost: '👻',
  Steel: '⚙️',
  Fire: '🔥',
  Water: '💧',
  Grass: '🍃',
  Electric: '⚡️',
  Psychic: '🔮',
  Ice: '❄️',
  Dragon: '🐉',
  Dark: '🖤',
  Fairy: '🧚',
};

export const tailwindColorForPokemonType = {
  Normal: 'bg-blue-500',
  Fighting: 'bg-red-500',
  Flying: 'bg-blue-300',
  Poison: 'bg-purple-500',
  Ground: 'bg-yellow-500',
  Rock: 'bg-gray-500',
  Bug: 'bg-green-500',
  Ghost: 'bg-purple-800',
  Steel: 'bg-gray-300',
  Fire: 'bg-red-500',
  Water: 'bg-blue-500',
  Grass: 'bg-green-500',
  Electric: 'bg-yellow-300',
  Psychic: 'bg-purple-500',
  Ice: 'bg-blue-200',
  Dragon: 'bg-purple-800',
  Dark: 'bg-gray-800',
  Fairy: 'bg-pink-500',
} as const;

const PokemonTypeBadge: TOC<{ Args: { type: PokemonType } }> =
  <template>
    <span
      class='w-16 h-16 flex items-center justify-center text-2xl rounded-lg {{get tailwindColorForPokemonType @type}} shadow border'
      title={{@type}}
    >
      {{get emojiForType @type}}
    </span>
  </template>;

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
    <LinkTo
      @route='index'
      class='relative inline-flex items-center justify-center p-0.5 mb-8 me-2 overflow-hidden text-sm font-medium text-gray-900 rounded-lg group bg-gradient-to-br from-pink-500 to-orange-400 group-hover:from-pink-500 group-hover:to-orange-400 hover:text-white focus:ring-4 focus:outline-none focus:ring-pink-200'
    >
      <span
        class='relative px-5 py-2.5 transition-all ease-in duration-75 bg-white rounded-md group-hover:bg-opacity-0'
      >⬅️ back
      </span>
    </LinkTo>
    <Request @request={{@model.pokemonRequest}}>
      <:content as |PokemonContent|>
        {{#let (this.currentPokemon PokemonContent.data) as |pokemon|}}
          {{pageTitle pokemon.name.english}}

          <div class="flex gap-16">
            <img class="animate-wiggle drop-shadow-2xl size-96" src={{pokemon.image.hires}} alt={{pokemon.name.english}} />
            <div class="max-w-96">
              <h2 class="font-medium text-4xl">{{pokemon.name.english}}</h2>
              <p class='my-2 text-slate-700 text-lg italic'>
                {{pokemon.description}}
              </p>

              <div class="grid grid-cols-2 my-8 text-lg">
                <p>❤️ HP: {{pokemon.base.HP}}</p>
                <p>⚔️ Attack: {{pokemon.base.Attack}}</p>
                <p>🛡️ Defense: {{pokemon.base.Defense}}</p>
                <p>💨 Speed: {{pokemon.base.Speed}}</p>
              </div>

              <div class="flex gap-2">
                {{#each pokemon.type as |type|}}
                  <PokemonTypeBadge @type={{type}} />
                {{/each}}
              </div>
            </div>
          </div>
        {{/let}}
      </:content>
      <:loading>
        <div>Loading...</div>
      </:loading>
    </Request>

    {{outlet}}
  </template>
}
