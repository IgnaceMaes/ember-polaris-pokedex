import Route from '@ember/routing/route';
import { service } from '@ember/service';
import { query } from '@ember-data/rest/request';
import type StoreService from '@ember-data/store';
import type { Pokemon } from 'ember-polaris-pokedex/schemas/pokemon';

export default class ApplicationRoute extends Route {
  @service declare store: StoreService;

  model() {
    return {
      pokemonRequest: this.store.request(query<Pokemon>('pokemon')),
    };
  }
}
