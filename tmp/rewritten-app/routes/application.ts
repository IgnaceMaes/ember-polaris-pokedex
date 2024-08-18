import Route from '@ember/routing/route';
import { service } from '@ember/service';
import { query } from '@ember-data/rest/request';
import type StoreService from '@ember-data/store';
import PokemonModel from 'ember-polaris-pokedex/models/pokemon';

export default class ApplicationRoute extends Route {
  @service declare store: StoreService;

  model() {
    return {
      pokemonRequest: this.store.request(query<PokemonModel>('pokemon'))
    };
  }
}
