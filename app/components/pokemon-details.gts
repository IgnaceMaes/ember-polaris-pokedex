import Component from '@glimmer/component';
import type { Pokemon } from 'ember-polaris-pokedex/schemas/pokemon';
import PokemonTypeBadge from 'ember-polaris-pokedex/components/pokemon-type-badge';
import PokemonEvolutionNav from 'ember-polaris-pokedex/components/pokemon-evolution-nav';
import { service } from '@ember/service';
import type { ImageFetch } from '@warp-drive/experiments/image-fetch';
import { cached } from '@glimmer/tracking';
import { getPromiseState } from '@warp-drive/ember';

export default class PokemonDetails extends Component<{
  Args: { pokemon: Pokemon };
}> {
  @service declare images: ImageFetch;

  @cached
  get detailImageRequest() {
    return this.images.load(this.args.pokemon.image.hires);
  }

  @cached
  get detailImageUrl() {
    const state = getPromiseState(this.detailImage);
    if (state.isError || state.isPending) {
      return null;
    }
    return state.result;
  }

  <template>
    <div
      class='pokemon-details flex flex-col justify-center gap-16 md:flex-row'
    >
      {{#if this.detailImageUrl}}
        <img
          class='max-size-96 full-embed aspect-square size-96 animate-wiggle drop-shadow-2xl [animation-delay:_0.2s]'
          src={{this.detailImageUrl}}
          alt={{@pokemon.name.english}}
        />
      {{else}}
        <div class='data-pokemon-thumbnail-loading'></div>
      {{/if}}
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

    <PokemonEvolutionNav @pokemon={{@pokemon}} />

    {{! prettier-ignore }}
    <style>
      .full-embed { view-transition-name: full-embed; }
      html:active-view-transition-type(forwards, backwards) {
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
      html:active-view-transition-type(forwards) {
        &::view-transition-old(pokemon-details) {
          animation-name: slide-out-to-left, fade-out;
        }
        &::view-transition-new(pokemon-details) {
          animation-name: slide-in-from-right, fade-in;
        }
      }

      /* Animation styles for backwards type only */
      html:active-view-transition-type(backwards) {
        &::view-transition-old(pokemon-details) {
          animation-name: slide-out-to-right, fade-out;
        }
        &::view-transition-new(pokemon-details) {
          animation-name: slide-in-from-left, fade-in;
        }
      }
    </style>
  </template>
}
