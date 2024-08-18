import { template } from "@ember/template-compiler";
import { fn } from '@ember/helper';
import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import type PokemonModel from 'ember-polaris-pokedex/models/pokemon';
import { service } from '@ember/service';
import type RouterService from '@ember/routing/router-service';
import { type RouterScrollService } from 'ember-polaris-pokedex/utils/router-scroll-service';
export function preloadImage(imageUrl1: string) {
    const img1 = new Image();
    img1.src = imageUrl1;
}
interface PokemonSignature {
    Args: {
        pokemon: PokemonModel;
    };
}
export default class PokemonGridItem extends Component<PokemonSignature> {
    @service
    router: RouterService;
    @service
    routerScroll: RouterScrollService;
    transitionToPokemonDetails = (pokemon1: PokemonModel, event1: MouseEvent)=>{
        this.routerScroll.preserveScrollPosition = false;
        // Fallback for browsers that don't support this API:
        if (!document.startViewTransition) {
            this.router.transitionTo('pokemon.pokemon', pokemon1.id?.toString());
            return;
        }
        const thumbnail1 = (event1.target as HTMLElement).attributes.length ? (event1.target as HTMLImageElement) : ((event1.target as HTMLElement).querySelector('img[data-pokemon-thumbnail]') as HTMLImageElement);
        thumbnail1.style.viewTransitionName = 'full-embed';
        // With a transition:
        document.startViewTransition(()=>{
            thumbnail1.style.viewTransitionName = '';
            this.router.transitionTo('pokemon.pokemon', pokemon1.id?.toString());
        });
    };
    static{
        template(`
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
  `, {
            component: this,
            eval () {
                return eval(arguments[0]);
            }
        });
    }
}
