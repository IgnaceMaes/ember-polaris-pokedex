import type { PokemonType } from 'ember-polaris-pokedex/schemas/pokemon';
import { get } from '@ember/helper';
import type { TOC } from '@ember/component/template-only';
import {
  emojiForType,
  tailwindColorForPokemonType,
} from 'ember-polaris-pokedex/utils/pokemon-type-mappings';

const PokemonTypeBadge: TOC<{ Args: { type: PokemonType } }> = <template>
  <div class='group relative'>
    <span
      class='flex h-16 w-16 items-center justify-center rounded-lg text-2xl
        {{get tailwindColorForPokemonType @type}}
        border shadow'
    >
      {{get emojiForType @type}}
    </span>
    <span
      class='pointer-events-none absolute -top-8 left-0 w-max rounded bg-gray-900 px-2 py-1 text-sm font-medium text-gray-50 opacity-0 shadow transition-opacity group-hover:opacity-100'
    >{{@type}}</span>
  </div>
</template>;

export default PokemonTypeBadge;
