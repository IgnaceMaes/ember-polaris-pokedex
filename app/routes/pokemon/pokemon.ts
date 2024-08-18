import Route from '@ember/routing/route';
import { service } from '@ember/service';
import type StoreService from '@ember-data/store';
import PokemonModel from 'ember-embroider-pokedex/models/pokemon';
import { query } from '@ember-data/rest/request';

export default class PokemonRoute extends Route {
  @service declare store: StoreService;

  model(params: { pokemon_id: string }) {
    // return this.store.request(findRecord<PokemonModel>('pokemon', params.pokemon_id));
    return {
      pokemonRequest: this.store.request(query<PokemonModel>('pokemon')),
      currentPokemonId: params.pokemon_id,
    };
  }
}
