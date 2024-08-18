import Route from '@ember/routing/route';
import type { ModelFrom } from 'ember-embroider-pokedex/utils/ember-route-template';
import type ApplicationRoute from 'ember-embroider-pokedex/routes/application';

export default class PokemonRoute extends Route {
  model(params: { pokemon_id: string }) {
    return {
      pokemonRequest: (this.modelFor('application') as ModelFrom<ApplicationRoute>).pokemonRequest,
      id: params.pokemon_id,
    };
  }
}
