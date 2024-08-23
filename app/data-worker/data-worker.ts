import Store from '@ember-data/store';
import RequestManager from '@ember-data/request';
import Fetch from '@ember-data/request/fetch';
import JSONAPICache from '@ember-data/json-api';

import { DataWorker, CacheHandler } from '@warp-drive/experiments/data-worker';
import type { CacheCapabilitiesManager } from '@ember-data/store/types';
import { CachePolicy } from '@ember-data/request-utils';
import { SchemaService } from '@warp-drive/schema-record/schema';
import { register } from '../schemas/pokemon';
import { JsonSuffixHandler } from '../utils/handlers';

class WorkerStore extends Store {
  requestManager = new RequestManager()
    .use([JsonSuffixHandler, Fetch])
    .useCache(CacheHandler);

  lifetimes = new CachePolicy({
    apiCacheHardExpires: 1000 * 60 * 60 * 48, // 48 hours
    apiCacheSoftExpires: 1000 * 60 * 60, // 1 hour
  });

  createCache(capabilities: CacheCapabilitiesManager) {
    return new JSONAPICache(capabilities);
  }

  createSchemaService() {
    const schema = new SchemaService();
    register(schema);
    return schema;
  }
}

new DataWorker(WorkerStore);
