import type { TOC } from '@ember/component/template-only';
import { LinkTo } from '@ember/routing';
import type PokemonModel from 'ember-embroider-pokedex/models/pokemon';

interface PokemonSignature {
  Args: { pokemon: PokemonModel };
}

const Pokemon: TOC<PokemonSignature> = <template>
  <LinkTo @route="pokemon.pokemon" @model={{@pokemon.id}} class='bg-gradient-to-br from-pink-100 to-yellow-100 rounded-xl p-4 shadow hover:shadow-md transition-shadow flex flex-col items-center group cursor-pointer'>
    <img class="group-hover:drop-shadow-xl group-hover:scale-125 transition-transform aspect-square block w-full p-4" src={{@pokemon.image.thumbnail}} alt={{@pokemon.name.english}} />
    <h3 class="font-medium mt-4 text-lg">{{@pokemon.name.english}}</h3>
  </LinkTo>
</template>;

export default Pokemon;
