import RequestManager from '@ember-data/request';
import BaseStore, { CacheHandler } from '@ember-data/store';
import { CachePolicy } from '@ember-data/request-utils';
import {
  registerDerivations,
  SchemaService,
} from '@warp-drive/schema-record/schema';
import { register as registerPokemon } from 'ember-polaris-pokedex/schemas/pokemon';
import type { CacheCapabilitiesManager } from '@ember-data/store/types';
import JSONAPICache from '@ember-data/json-api';
import type { StableRecordIdentifier } from '@warp-drive/core-types/identifier';
import {
  instantiateRecord,
  teardownRecord,
} from '@warp-drive/schema-record/hooks';
import type { SchemaRecord } from '@warp-drive/schema-record/record';

// import { WorkerFetch } from '@warp-drive/experiments/worker-fetch';
import { JsonSuffixHandler } from 'ember-polaris-pokedex/utils/handlers';
import Fetch from '@ember-data/request/fetch';

export default class Store extends BaseStore {
  lifetimes = new CachePolicy({
    apiCacheHardExpires: 1000 * 60 * 60 * 48, // 48 hours
    apiCacheSoftExpires: 1000 * 60 * 60, // 1 hour
  });

  requestManager = new RequestManager()
    .use([
      // new WorkerFetch(
      //   new SharedWorker(new URL('./basic-worker.ts', import.meta.url), {
      //     type: 'module',
      //   }),
      // ),
      JsonSuffixHandler,
      Fetch,
    ])
    .useCache(CacheHandler);

  createSchemaService() {
    const schema = new SchemaService();

    registerDerivations(schema);
    registerPokemon(schema);

    return schema;
  }

  createCache(capabilites: CacheCapabilitiesManager) {
    return new JSONAPICache(capabilites);
  }

  instantiateRecord(
    identifier: StableRecordIdentifier,
    createRecordArgs: { [key: string]: unknown },
  ) {
    return instantiateRecord(this, identifier, createRecordArgs);
  }

  teardownRecord(record: SchemaRecord): void {
    teardownRecord(record);
  }
}
