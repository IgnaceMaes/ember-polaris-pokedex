import RequestManager from '@ember-data/request';
import Fetch from '@ember-data/request/fetch';

import BaseStore, { CacheHandler } from '@ember-data/store';

export default class Store extends BaseStore {
  requestManager = new RequestManager().use([Fetch]).useCache(CacheHandler);
}
