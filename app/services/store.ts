import RequestManager from '@ember-data/request';
import { CachePolicy } from '@ember-data/request-utils';
import Fetch from '@ember-data/request/fetch';

import BaseStore, { CacheHandler } from '@ember-data/store';
import { PokemonHandler } from 'ember-polaris-pokedex/utils/pokemon-api-handler';

export default class Store extends BaseStore {
  requestManager = new RequestManager()
    .use([PokemonHandler, Fetch])
    .useCache(CacheHandler);

  lifetimes = new CachePolicy({
    apiCacheHardExpires: 1000 * 60 * 60 * 48, // 48 hours
    apiCacheSoftExpires: 1000 * 60 * 60, // 1 hour
  });
}
