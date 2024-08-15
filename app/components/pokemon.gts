import type { TOC } from '@ember/component/template-only';
import type PokemonModel from 'ember-embroider-pokedex/models/pokemon';

interface PokemonSignature {
  Args: { pokemon: PokemonModel };
}

const Pokemon: TOC<PokemonSignature> = <template>
  <div class='bg-white rounded-xl p-4 shadow hover:shadow-md transition-shadow flex flex-col items-center'>
    <img src={{@pokemon.image.thumbnail}} />
    <h3 class="font-medium mt-4 text-lg">{{@pokemon.name.english}}</h3>
  </div>
</template>;

export default Pokemon;
