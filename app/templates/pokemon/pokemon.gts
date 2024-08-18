import type { PokemonType } from 'ember-embroider-pokedex/models/pokemon';
import { pageTitle } from 'ember-page-title';
import { LinkTo } from '@ember/routing';
import type PokemonRoute from 'ember-embroider-pokedex/routes/pokemon/pokemon';
import {
  RouteTemplate,
  type RouteTemplateSignature,
} from 'ember-embroider-pokedex/utils/ember-route-template';
import Component from '@glimmer/component';
import { Request } from '@warp-drive/ember';
import { get } from '@ember/helper';
import type { TOC } from '@ember/component/template-only';
import LoadingBar from 'ember-embroider-pokedex/components/loading-bar';
import HomeButton from 'ember-embroider-pokedex/components/home-button';
import type PokemonModel from 'ember-embroider-pokedex/models/pokemon';
import {
  emojiForType,
  tailwindColorForPokemonType,
} from 'ember-embroider-pokedex/utils/pokemon-type-mappings';
import type RouterService from '@ember/routing/router-service';
import { service } from '@ember/service';
import { fn } from '@ember/helper';
import { on } from '@ember/modifier';

type PokemonTemplateSignature = RouteTemplateSignature<PokemonRoute>;

const PokemonTypeBadge: TOC<{ Args: { type: PokemonType } }> = <template>
  <div class='group relative'>
    <span
      class='w-16 h-16 flex items-center justify-center text-2xl rounded-lg
        {{get tailwindColorForPokemonType @type}}
        shadow border'
    >
      {{get emojiForType @type}}
    </span>
    <span
      class='pointer-events-none absolute -top-8 left-0 w-max rounded bg-gray-900 px-2 py-1 text-sm font-medium text-gray-50 opacity-0 shadow transition-opacity group-hover:opacity-100'
    >{{@type}}</span>
  </div>
</template>;

class PokemonCard extends Component<{ Args: { pokemon: PokemonModel } }> {
  @service declare router: RouterService;

  transitionToPokemonDetails = (pokemonId: string) => {
    // Fallback for browsers that don't support this API:
    if (!document.startViewTransition) {
      this.router.transitionTo('pokemon.pokemon', pokemonId);
      return;
    }

    // With a transition:
    document.startViewTransition(() => {
      this.router.transitionTo('pokemon.pokemon', pokemonId);
    });
  };

  <template>
    {{pageTitle @pokemon.name.english}}

    <div
      class='flex gap-16 justify-center flex-col md:flex-row pokemon-details'
    >
      <img
        class='animate-wiggle [animation-delay:_0.2s] drop-shadow-2xl size-96 max-size-96 aspect-square full-embed'
        src={{@pokemon.image.hires}}
        alt={{@pokemon.name.english}}
      />
      <div class='max-w-96'>
        <h2 class='font-medium text-4xl'>{{@pokemon.name.english}}</h2>
        <p class='my-2 text-slate-700 text-lg italic'>
          {{@pokemon.description}}
        </p>

        <div class='grid md:grid-cols-2 my-8 text-lg'>
          <p>❤️ HP: {{@pokemon.base.HP}}</p>
          <p>⚔️ Attack: {{@pokemon.base.Attack}}</p>
          <p>🛡️ Defense: {{@pokemon.base.Defense}}</p>
          <p>💨 Speed: {{@pokemon.base.Speed}}</p>
        </div>

        <div class='flex gap-2'>
          {{#each @pokemon.type as |type|}}
            <PokemonTypeBadge @type={{type}} />
          {{/each}}
        </div>
      </div>
    </div>

    {{#if @pokemon.evolution}}
      <section class='max-w-3xl m-auto'>
        <h3 class='text-2xl mt-12'>Evolutions</h3>

        <div class='grid grid-cols-2 gap-8'>
          <div>
            {{#if @pokemon.evolution.prev}}
              <button
                class='w-full bg-gradient-to-br from-pink-100 to-yellow-100 rounded-xl p-4 shadow hover:shadow-md transition-shadow flex flex-col items-center cursor-pointer'
                {{on
                  'click'
                  (fn
                    this.transitionToPokemonDetails
                    (get @pokemon.evolution.prev 0)
                  )
                }}
              >
                ⏪ Previous
              </button>
            {{else}}
              <button
                class='w-full bg-gradient-to-br from-gray-100 to-slate-100 rounded-xl p-4 shadow flex flex-col items-center cursor-not-allowed opacity-50'
              >
                ⏪ Previous
              </button>
            {{/if}}
          </div>
          <div class='flex flex-col gap-2'>
            {{#each @pokemon.evolution.next as |next|}}
              <button
                class='w-full bg-gradient-to-br from-pink-100 to-yellow-100 rounded-xl p-4 shadow hover:shadow-md transition-shadow flex flex-col items-center cursor-pointer'
                {{on 'click' (fn this.transitionToPokemonDetails (get next 0))}}
              >
                Next ⏩
              </button>
            {{else}}
              <button
                class='w-full bg-gradient-to-br from-gray-100 to-slate-100 rounded-xl p-4 shadow flex flex-col items-center cursor-not-allowed opacity-50'
              >
                Next ⏩
              </button>
            {{/each}}
          </div>
        </div>
      </section>
    {{/if}}

    {{! prettier-ignore }}
    <style>
      .full-embed { view-transition-name: full-embed; }
      .pokemon-details { view-transition-name: pokemon-details; }

      @keyframes fade-in {
        from { opacity: 0; }
      }

      @keyframes fade-out {
        to { opacity: 0; }
      }

      @keyframes slide-from-right {
        from { transform: translateX(30px); }
      }

      @keyframes slide-to-left {
        to { transform: translateX(-30px); }
      }

      :global(::view-transition-old(pokemon-details)) {
        animation: 90ms cubic-bezier(0.4, 0, 1, 1) both fade-out,
          300ms cubic-bezier(0.4, 0, 0.2, 1) both slide-to-left;
      }

      :global(::view-transition-new(pokemon-details)) {
        animation: 210ms cubic-bezier(0, 0, 0.2, 1) 90ms both fade-in,
          300ms cubic-bezier(0.4, 0, 0.2, 1) both slide-from-right;
      }
    </style>
  </template>
}

@RouteTemplate
export default class PokemonTemplate extends Component<PokemonTemplateSignature> {
  currentPokemon = (
    pokemons: Awaited<
      PokemonTemplateSignature['Args']['model']['pokemonRequest']
    >['content']['data'],
  ) => {
    return pokemons.find(
      (pokemon) => pokemon.id!.toString() === this.args.model.pokemonId,
    );
  };

  <template>
    <HomeButton />

    {{#if @model.pokemonRequest}}
      <Request @request={{@model.pokemonRequest}}>
        <:content as |PokemonContent|>
          {{#let (this.currentPokemon PokemonContent.data) as |pokemon|}}
            {{#if pokemon}}
              <PokemonCard @pokemon={{pokemon}} />
            {{else}}
              <p>Couldn't find that Pokémon!</p>
            {{/if}}
          {{/let}}
        </:content>
        <:loading>
          <LoadingBar />
        </:loading>
      </Request>
    {{else}}
      {{! @glint-expect-error: model is of type PokemonModel if it's passed in the transition }}
      <PokemonCard @pokemon={{@model}} />
    {{/if}}

    {{outlet}}
  </template>
}
