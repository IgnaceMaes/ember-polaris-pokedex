import { template } from "@ember/template-compiler";
import Component from '@glimmer/component';
import { get } from '@ember/helper';
import type PokemonModel from 'ember-embroider-pokedex/models/pokemon';
import type RouterService from '@ember/routing/router-service';
import { service } from '@ember/service';
import { fn } from '@ember/helper';
import { on } from '@ember/modifier';
import { preloadImage } from 'ember-embroider-pokedex/components/pokemon-grid-item';
import PokemonTypeBadge from 'ember-embroider-pokedex/components/pokemon-type-badge';
import { type RouterScrollService } from 'ember-embroider-pokedex/utils/router-scroll-service';
export function getPokemonById(pokemons1: PokemonModel[], id1: string) {
    return pokemons1.find((pokemon1)=>pokemon1.id!.toString() === id1);
}
export default class PokemonDetails extends Component<{
    Args: {
        pokemon: PokemonModel;
        allPokemon: PokemonModel[];
    };
}> {
    @service
    router: RouterService;
    @service
    routerScroll: RouterScrollService;
    transitionToPokemonDetails = (pokemonId1: string, direction1: 'forwards' | 'backwards')=>{
        this.routerScroll.preserveScrollPosition = true;
        // Fallback for browsers that don't support this API:
        if (!document.startViewTransition) {
            this.router.transitionTo('pokemon.pokemon', pokemonId1.toString());
            return;
        }
        // With a transition:
        document.startViewTransition({
            // @ts-expect-error: No types for these options yet
            update: ()=>{
                this.router.transitionTo('pokemon.pokemon', pokemonId1.toString());
            },
            types: [
                'slide',
                direction1
            ]
        });
    };
    preloadImageForPokemonId = (pokemonId1: string)=>{
        const pokemon1 = getPokemonById(this.args.allPokemon, pokemonId1);
        if (pokemon1) {
            preloadImage(pokemon1.image.hires);
        }
    };
    static{
        template(`
    <div
      class='pokemon-details flex flex-col justify-center gap-16 md:flex-row'
    >
      <img
        class='animate-wiggle max-size-96 full-embed aspect-square size-96 drop-shadow-2xl [animation-delay:_0.2s]'
        src={{@pokemon.image.hires}}
        alt={{@pokemon.name.english}}
      />
      <div class='max-w-96'>
        <h2 class='text-4xl font-medium'>{{@pokemon.name.english}}</h2>
        <p class='my-2 text-lg italic text-slate-700'>
          {{@pokemon.description}}
        </p>

        <div class='my-8 grid text-lg md:grid-cols-2'>
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
      <section class='m-auto max-w-3xl'>
        <h3 class='mt-12 text-2xl'>Evolutions</h3>

        <div class='grid grid-cols-2 gap-8'>
          <div>
            {{#if @pokemon.evolution.prev}}
              <button
                type='button'
                class='flex w-full cursor-pointer flex-col items-center rounded-xl bg-gradient-to-br from-pink-100 to-yellow-100 p-4 shadow transition-shadow hover:shadow-md'
                {{on
                  'click'
                  (fn
                    this.transitionToPokemonDetails
                    (get @pokemon.evolution.prev 0)
                    'backwards'
                  )
                }}
                {{on
                  'pointerenter'
                  (fn
                    this.preloadImageForPokemonId
                    (get @pokemon.evolution.prev 0)
                  )
                }}
              >
                ⏪ Previous
              </button>
            {{else}}
              <button
                type='button'
                class='flex w-full cursor-not-allowed flex-col items-center rounded-xl bg-gradient-to-br from-gray-100 to-slate-100 p-4 opacity-50 shadow'
              >
                ⏪ Previous
              </button>
            {{/if}}
          </div>
          <div class='flex flex-col gap-2'>
            {{#each @pokemon.evolution.next as |next|}}
              <button
                type='button'
                class='flex w-full cursor-pointer flex-col items-center rounded-xl bg-gradient-to-br from-pink-100 to-yellow-100 p-4 shadow transition-shadow hover:shadow-md'
                {{on
                  'click'
                  (fn this.transitionToPokemonDetails (get next 0) 'forwards')
                }}
                {{on
                  'pointerenter'
                  (fn this.preloadImageForPokemonId (get next 0))
                }}
              >
                Next ⏩
              </button>
            {{else}}
              <button
                type='button'
                class='flex w-full cursor-not-allowed flex-col items-center rounded-xl bg-gradient-to-br from-gray-100 to-slate-100 p-4 opacity-50 shadow'
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
  `, {
            component: this,
            eval () {
                return eval(arguments[0]);
            }
        });
    }
}
