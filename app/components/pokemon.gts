import type { TOC } from '@ember/component/template-only';
import { fn } from '@ember/helper';
import { on } from '@ember/modifier';
import { LinkTo } from '@ember/routing';
import type PokemonModel from 'ember-embroider-pokedex/models/pokemon';

interface PokemonSignature {
  Args: { pokemon: PokemonModel };
}

function preloadImage(imageUrl: string) {
  const img = new Image();
  img.src = imageUrl;
}

const Pokemon: TOC<PokemonSignature> = <template>
  <LinkTo
    @route='pokemon.pokemon'
    @model={{@pokemon.id}}
    class='revealing-image bg-gradient-to-br from-pink-100 to-yellow-100 rounded-xl p-4 shadow hover:shadow-md transition-shadow flex flex-col items-center group cursor-pointer'
    {{on 'mouseenter' (fn preloadImage @pokemon.image.hires)}}
  >
    <img
      class='group-hover:drop-shadow-xl group-hover:scale-125 transition-transform aspect-square block w-full p-4'
      loading='lazy'
      src={{@pokemon.image.thumbnail}}
      alt={{@pokemon.name.english}}
    />
    <h3 class='font-medium mt-4 text-lg'>{{@pokemon.name.english}}</h3>
  </LinkTo>

  <style>
    @keyframes reveal {
      from {
        opacity: 0;
        transform: scale(0.75);
        /* clip-path: inset(45% 20% 45% 20%); */
      }
      to {
        opacity: 1;
        transform: scale(1);
        /* clip-path: inset(0% 0% 0% 0%); */
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
</template>;

export default Pokemon;
