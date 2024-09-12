import RequestManager from '@ember-data/request';
import Fetch from '@ember-data/request/fetch';

import BaseStore, { CacheHandler } from '@ember-data/store';
import { PokemonHandler } from 'ember-polaris-pokedex/utils/pokemon-api-handler';

export default class Store extends BaseStore {
  requestManager = new RequestManager()
    .use([PokemonHandler, Fetch])
    .useCache(CacheHandler);
}
