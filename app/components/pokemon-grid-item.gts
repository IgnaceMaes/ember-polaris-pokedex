import { fn } from '@ember/helper';
import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import type PokemonModel from 'ember-embroider-pokedex/models/pokemon';
import { service } from '@ember/service';
import type RouterService from '@ember/routing/router-service';
import { type RouterScrollService } from 'ember-embroider-pokedex/utils/router-scroll-service';

export function preloadImage(imageUrl: string) {
  const img = new Image();
  img.src = imageUrl;
}

interface PokemonSignature {
  Args: { pokemon: PokemonModel };
}

export default class PokemonGridItem extends Component<PokemonSignature> {
  @service declare router: RouterService;

  @service declare routerScroll: RouterScrollService;

  transitionToPokemonDetails = (pokemon: PokemonModel, event: MouseEvent) => {
    this.routerScroll.preserveScrollPosition = false;
    // Fallback for browsers that don't support this API:
    if (!document.startViewTransition) {
      this.router.transitionTo('pokemon.pokemon', pokemon.id?.toString());
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
      this.router.transitionTo('pokemon.pokemon', pokemon.id?.toString());
    });
  };

  <template>
    <button
      type='button'
      class='revealing-image group flex cursor-pointer flex-col items-center rounded-xl bg-gradient-to-br from-pink-100 to-yellow-100 p-4 shadow transition-shadow hover:shadow-md'
      {{on 'pointerenter' (fn preloadImage @pokemon.image.hires)}}
      {{on 'click' (fn this.transitionToPokemonDetails @pokemon)}}
    >
      <img
        data-pokemon-thumbnail
        class='block aspect-square w-full p-4 transition-transform group-hover:scale-125 group-hover:drop-shadow-xl'
        loading='lazy'
        src={{@pokemon.image.thumbnail}}
        alt={{@pokemon.name.english}}
      />
      <h3 class='mt-4 text-lg font-medium'>{{@pokemon.name.english}}</h3>
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
