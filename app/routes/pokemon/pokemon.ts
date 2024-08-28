import Route from '@ember/routing/route';
import { service } from '@ember/service';
import type Store from '@ember-data/store';
import { findRecord } from '@ember-data/json-api/request';

export default class PokemonRoute extends Route {
  @service declare store: Store;

  model(params: { pokemon_id: string }) {
    const req = findRecord('pokemon', params.pokemon_id, {
      resourcePath: `pokemon/single`,
    });
    req.url += '.json';

    return {
      pokemonRequest: this.store.request(req),
      id: params.pokemon_id,
    };
  }
}
