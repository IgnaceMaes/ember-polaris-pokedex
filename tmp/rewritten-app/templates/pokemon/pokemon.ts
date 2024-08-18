import { template } from "@ember/template-compiler";
import { pageTitle } from 'ember-page-title';
import type PokemonRoute from 'ember-embroider-pokedex/routes/pokemon/pokemon';
import { RouteTemplate, type RouteTemplateSignature } from 'ember-embroider-pokedex/utils/ember-route-template';
import Component from '@glimmer/component';
import { Request } from '@warp-drive/ember';
import LoadingBar from 'ember-embroider-pokedex/components/loading-bar';
import HomeButton from 'ember-embroider-pokedex/components/home-button';
import PokemonDetails, { getPokemonById } from 'ember-embroider-pokedex/components/pokemon-details';
type PokemonTemplateSignature = RouteTemplateSignature<PokemonRoute>;
export default @RouteTemplate
class PokemonTemplate extends Component<PokemonTemplateSignature> {
    currentPokemon = (pokemons1: Awaited<PokemonTemplateSignature['Args']['model']['pokemonRequest']>['content']['data'])=>{
        return getPokemonById(pokemons1, this.args.model.id);
    };
    static{
        template(`
    <HomeButton />

    <Request @request={{@model.pokemonRequest}}>
      <:content as |PokemonContent|>
        {{#let (this.currentPokemon PokemonContent.data) as |pokemon|}}
          {{#if pokemon}}
            {{pageTitle pokemon.name.english}}

            <PokemonDetails
              @pokemon={{pokemon}}
              @allPokemon={{PokemonContent.data}}
            />
          {{else}}
            <p>Couldn't find that Pokémon!</p>
          {{/if}}
        {{/let}}
      </:content>
      <:loading>
        <LoadingBar />
      </:loading>
    </Request>

    {{outlet}}
  `, {
            component: this,
            eval () {
                return eval(arguments[0]);
            }
        });
    }
}
