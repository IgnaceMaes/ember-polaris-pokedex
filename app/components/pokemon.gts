import { fn } from '@ember/helper';
import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import type PokemonModel from 'ember-embroider-pokedex/models/pokemon';
import { service } from '@ember/service';
import type RouterService from '@ember/routing/router-service';

interface PokemonSignature {
  Args: { pokemon: PokemonModel; allPokemon: PokemonModel[] };
}

function preloadImage(imageUrl: string) {
  const img = new Image();
  img.src = imageUrl;
}

export default class Pokemon extends Component<PokemonSignature> {
  @service declare router: RouterService;

  transitionToPokemonDetails = (pokemon: PokemonModel, event: MouseEvent) => {
    // Fallback for browsers that don't support this API:
    if (!document.startViewTransition) {
      this.router.transitionTo('pokemon.pokemon', { id: pokemon.id?.toString(), allPokemon: this.args.allPokemon });
      return;
    }

    const thumbnail = (event.target as HTMLElement).attributes.length
      ? (event.target as HTMLImageElement)
      : ((event.target as HTMLElement).querySelector(
          'img[data-pokemon-thumbnail]',
        ) as HTMLImageElement);
    thumbnail.style.viewTransitionName = 'full-embed';

    // With a transition:
    document.startViewTransition(() => {
      thumbnail.style.viewTransitionName = '';
      this.router.transitionTo('pokemon.pokemon', { id: pokemon.id?.toString(), allPokemon: this.args.allPokemon });
    });
  };

  <template>
    <button
      class='revealing-image bg-gradient-to-br from-pink-100 to-yellow-100 rounded-xl p-4 shadow hover:shadow-md transition-shadow flex flex-col items-center group cursor-pointer'
      {{on 'mouseenter' (fn preloadImage @pokemon.image.hires)}}
      {{on 'click' (fn this.transitionToPokemonDetails @pokemon)}}
    >
      <img
        data-pokemon-thumbnail
        class='group-hover:drop-shadow-xl group-hover:scale-125 transition-transform aspect-square block w-full p-4'
        loading='lazy'
        src={{@pokemon.image.thumbnail}}
        alt={{@pokemon.name.english}}
      />
      <h3 class='font-medium mt-4 text-lg'>{{@pokemon.name.english}}</h3>
    </button>

    {{! prettier-ignore }}
    <style>
      @keyframes reveal {
        from {
          opacity: 0;
          transform: scale(0.75);
        }
        to {
          opacity: 1;
          transform: scale(1);
        }
      }
      .revealing-image {
        /* Create View Timeline */
        view-timeline-name: --revealing-image;
        view-timeline-axis: block;

        /* Attach animation, linked to the  View Timeline */
        animation: linear reveal both;
        animation-timeline: --revealing-image;

        /* Tweak range when effect should run*/
        animation-range: entry 0% cover 25%;
      }
    </style>
  </template>
}
