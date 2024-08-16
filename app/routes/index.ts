import Route from '@ember/routing/route';
import { service } from '@ember/service';
import { query } from '@ember-data/rest/request';
import type StoreService from '@ember-data/store';
import PokemonModel from 'ember-embroider-pokedex/models/pokemon';

export default class IndexRoute extends Route {
  @service declare store: StoreService;

  model() {
    // return this.store.findAll<PokemonModel>('pokemon');
    // const { content } = await this.store.request(query<PokemonModel>('pokemon'));
    // return content.data;
    return {
      pokemonRequest: this.store.request(query<PokemonModel>('pokemon'))
    };
  }
}
