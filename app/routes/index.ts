import Route from '@ember/routing/route';
import { service } from '@ember/service';
import { query } from '@ember-data/json-api/request';
import type StoreService from '@ember-data/store';
import type { IdentifierArray } from '@ember-data/store/-private/record-arrays/identifier-array';
import type PokemonModel from 'ember-embroider-pokedex/models/pokemon';

export default class IndexRoute extends Route {
  @service declare store: StoreService;

  async model() {
    // const pokemon = await fetch('/pokedex.json');
    // return (await pokemon.json());
    return this.store.findAll('pokemon') as unknown as IdentifierArray<PokemonModel>;
    // const { content } = await this.store.request(query('pokemon'));
    // return content.data;
  }
}
