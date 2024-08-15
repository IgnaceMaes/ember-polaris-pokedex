import Route from '@ember/routing/route';
import { service } from '@ember/service';
import type StoreService from '@ember-data/store';

export default class IndexRoute extends Route {
  @service declare store: StoreService;

  async model() {
    // const pokemon = await fetch('/pokedex.json');
    // return (await pokemon.json());
    return this.store.findAll('pokemon');
  }
}
