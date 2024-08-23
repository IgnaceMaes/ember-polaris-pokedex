import Route from '@ember/routing/route';
import { service } from '@ember/service';
import type Store from '@ember-data/store';
import { findRecord } from '@ember-data/json-api/request';

export default class PokemonRoute extends Route {
  @service declare store: Store;

  model(params: { pokemon_id: string }) {
    return {
      pokemonRequest: this.store.request(
        findRecord('pokemon', params.pokemon_id, {
          resourcePath: `api/pokemon/single`,
        }),
      ),
      id: params.pokemon_id,
    };
  }
}
