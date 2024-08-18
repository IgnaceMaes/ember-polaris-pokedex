import type { PokemonType } from 'ember-embroider-pokedex/models/pokemon';
import { pageTitle } from 'ember-page-title';
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

class PokemonCard extends Component<{
  Args: { pokemon: PokemonModel; allPokemon: PokemonModel[] };
}> {
  @service declare router: RouterService;

  transitionToPokemonDetails = (
    pokemonId: string,
    direction: 'forwards' | 'backwards',
  ) => {
    // Fallback for browsers that don't support this API:
    if (!document.startViewTransition) {
      this.router.transitionTo('pokemon.pokemon', {
        id: pokemonId,
        allPokemon: this.args.allPokemon,
      });
      return;
    }

    // With a transition:
    document.startViewTransition({
      // @ts-expect-error: No types for these options yet
      update: () => {
        this.router.transitionTo('pokemon.pokemon', {
          id: pokemonId,
          allPokemon: this.args.allPokemon,
        });
      },
      types: ['slide', direction],
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
                    'backwards'
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
                {{on
                  'click'
                  (fn this.transitionToPokemonDetails (get next 0) 'forwards')
                }}
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
      :global(html:active-view-transition-type(forwards, backwards)) {
        .pokemon-details { view-transition-name: pokemon-details; }
        .full-embed { view-transition-name: none; }
      }

      @keyframes fade-in {
        from { opacity: 0; }
      }

      @keyframes fade-out {
        to { opacity: 0; }
      }

      @keyframes slide-in-from-left {
        from {
          translate: -10vw 0;
        }
      }
      @keyframes slide-in-from-right {
        from {
          translate: 10vw 0;
        }
      }
      @keyframes slide-out-to-left {
        to {
          translate: -10vw 0;
        }
      }
      @keyframes slide-out-to-right {
        to {
          translate: 10vw 0;
        }
      }

      /* Animation styles for forwards type only */
      :global(html:active-view-transition-type(forwards)) {
        :global(&::view-transition-old(pokemon-details)) {
          animation-name: slide-out-to-left, fade-out;
        }
        :global(&::view-transition-new(pokemon-details)) {
          animation-name: slide-in-from-right, fade-in;
        }
      }

      /* Animation styles for backwards type only */
      :global(html:active-view-transition-type(backwards)) {
        :global(&::view-transition-old(pokemon-details)) {
          animation-name: slide-out-to-right, fade-out;
        }
        :global(&::view-transition-new(pokemon-details)) {
          animation-name: slide-in-from-left, fade-in;
        }
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
      (pokemon) => pokemon.id!.toString() === this.args.model.id,
    );
  };

  <template>
    <HomeButton />

    {{#if @model.pokemonRequest}}
      <Request @request={{@model.pokemonRequest}}>
        <:content as |PokemonContent|>
          {{#let (this.currentPokemon PokemonContent.data) as |pokemon|}}
            {{#if pokemon}}
              <PokemonCard @pokemon={{pokemon}} @allPokemon={{PokemonContent.data}} />
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
      <PokemonCard
        {{! @glint-expect-error: model is of type PokemonModel if it's passed in the transition }}
        @pokemon={{this.currentPokemon (get @model 'allPokemon')}}
        {{! @glint-expect-error: model is of type PokemonModel if it's passed in the transition }}
        @allPokemon={{(get @model 'allPokemon')}}
      />
    {{/if}}

    {{outlet}}
  </template>
}
